# Storage Slot

A comprehensive Solidity library providing type-safe storage slot operations and slot derivation utilities for smart contract development.

## Overview

This repository contains two main components designed to streamline storage management in smart contracts:

- `StorageSlot`: Type-safe storage operations supporting both persistent and transient storage (EIP-1153)
- `SlotDerivation`: Utilities for computing and deriving storage slot positions

### Features

- Read and write to persistent storage and transient storage
- Efficient multi-slot handling for dynamic data (bytes/string)
- Assembly-optimized operations for gas efficiency

`StorageSlot` exposes user defined value types which represent slot indices. Each type has strongly typed sload and sstore for persistent storage and tload and tstore for transient storage.

#### Supported Types:

- `AddressSlot`

- `BooleanSlot`

- `Bytes32Slot`

- `Uint256Slot`

- `Int256Slot`

- `BytesSlot`

- `StringSlot`

## Installation

### Using Foundry

```bash
forge install fomoweth/storage-slot
```

### Using Git Submodules

```bash
git submodule add https://github.com/fomoweth/storage-slot.git lib/storage-slot
```

Add `storage-slot/=lib/storage-slot/src/` in `remappings.txt`

## Example Usage

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {StorageSlot, AddressSlot, Uint256Slot} from "storage-slot/StorageSlot.sol";
import {SlotDerivation} from "storage-slot/SlotDerivation.sol";

contract Example {
    using StorageSlot for uint256;
    using SlotDerivation for uint256;

    error ContractLocked();
    error InvalidNonce();
    error Unauthorized();

    // Define storage slots using {SlotDerivation}
    AddressSlot private immutable LOCKER_SLOT = SlotDerivation.erc7201Slot("example.locker").asAddressSlot();
    Uint256Slot private immutable NONCES_SLOT = SlotDerivation.erc7201Slot("example.nonces").asUint256Slot();

    // Define storage slots using precomputed keccak256 hash
    AddressSlot private constant ADMIN_SLOT = AddressSlot.wrap(0xb53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d6103);

    modifier lock() {
        if (LOCKER_SLOT.tload() != address(0)) revert ContractLocked();
        LOCKER_SLOT.tstore(msg.sender);
        _;
        LOCKER_SLOT.tclear();
    }

    modifier onlyAdmin() {
        if (admin() != msg.sender) revert Unauthorized();
        _;
    }

    function invalidateNonce(uint256 nonce) external lock {
        Uint256Slot nonceSlot = _getNonceSlot(msg.sender);
        require(nonceSlot.sload() < nonce, InvalidNonce());
        nonceSlot.sstore(nonce);
    }

    function useNonce() external lock returns (uint256 nonce) {
        Uint256Slot nonceSlot = _getNonceSlot(msg.sender);
        nonceSlot.sstore((nonce = nonceSlot.sload()) + 1);
    }

    function nonces(address owner) public view returns (uint256 nonce) {
        return _getNonceSlot(owner).sload();
    }

    function _getNonceSlot(address owner) internal view returns (Uint256Slot) {
        return NONCES_SLOT.asUint256().derive(owner).asUint256Slot();
    }

    function setAdmin(address newAdmin) external onlyAdmin {
        ADMIN_SLOT.sstore(newAdmin);
    }

    function admin() public view returns (address) {
        return ADMIN_SLOT.sload();
    }
}
```

### ReentrancyGuard

[OpenZeppelin's Implementation](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/ReentrancyGuard.sol)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {StorageSlot, Uint256Slot} from "storage-slot/StorageSlot.sol";
import {SlotDerivation} from "storage-slot/SlotDerivation.sol";

abstract contract ReentrancyGuard {
    using StorageSlot for uint256;

    error ReentrantCall();

    Uint256Slot private immutable STATUS_SLOT = SlotDerivation.erc7201Slot("reentrancy.status").asUint256Slot();

    uint256 private constant NOT_ENTERED = 1;
    uint256 private constant ENTERED = 2;

    modifier nonReentrant() {
        _nonReentrantBefore();
        _;
        _nonReentrantAfter();
    }

    constructor() {
        STATUS_SLOT.sstore(NOT_ENTERED);
    }

    function _nonReentrantBefore() private {
        if (_reentrancyGuardEntered()) revert ReentrantCall();
        STATUS_SLOT.sstore(ENTERED);
    }

    function _nonReentrantAfter() private {
        STATUS_SLOT.sstore(NOT_ENTERED);
    }

    function _reentrancyGuardEntered() internal view returns (bool) {
        return STATUS_SLOT.sload() == ENTERED;
    }
}
```

### ReentrancyGuardTransient

[OpenZeppelin's Implementation](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/ReentrancyGuardTransient.sol)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {StorageSlot, BooleanSlot} from "storage-slot/StorageSlot.sol";
import {SlotDerivation} from "storage-slot/SlotDerivation.sol";

abstract contract ReentrancyGuardTransient {
    using StorageSlot for uint256;

    error ReentrantCall();

    BooleanSlot private immutable STATUS_SLOT = SlotDerivation.erc7201Slot("reentrancy.status").asBooleanSlot();

    modifier nonReentrant() {
        _nonReentrantBefore();
        _;
        _nonReentrantAfter();
    }

    function _nonReentrantBefore() private {
        if (_reentrancyGuardEntered()) revert ReentrantCall();
        STATUS_SLOT.tstore(true);
    }

    function _nonReentrantAfter() private {
        STATUS_SLOT.tclear();
    }

    function _reentrancyGuardEntered() internal view returns (bool) {
        return STATUS_SLOT.tload();
    }
}
```

### ShortStrings

[OpenZeppelin's Implementation](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/ShortStrings.sol)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {StringSlot} from "storage-slot/StorageSlot.sol";

type ShortString is bytes32;

library ShortStrings {
    error InvalidShortString();
    error StringTooLong();

    bytes32 private constant FALLBACK_SENTINEL = 0x00000000000000000000000000000000000000000000000000000000000000FF;

    function toShortString(string memory str) internal pure returns (ShortString sstr) {
        assembly ("memory-safe") {
            let length := mload(str)
            if gt(length, 0x1f) {
                mstore(0x00, 0xb11b2ad8) // StringTooLong()
                revert(0x1c, 0x04)
            }
            sstr := or(mload(add(str, 0x20)), length)
        }
    }

    function toString(ShortString sstr) internal pure returns (string memory str) {
        uint256 length = byteLength(sstr);
        assembly ("memory-safe") {
            str := mload(0x40)
            mstore(0x40, add(str, 0x40))
            mstore(str, length)
            mstore(add(str, 0x20), sstr)
        }
    }

    function byteLength(ShortString sstr) internal pure returns (uint256 length) {
        assembly ("memory-safe") {
            length := and(sstr, FALLBACK_SENTINEL)
            if gt(length, 0x1f) {
                mstore(0x00, 0xb3512b0c) // InvalidShortString()
                revert(0x1c, 0x04)
            }
        }
    }

    function toShortStringWithFallback(StringSlot slot, string memory str) internal returns (ShortString) {
        if (bytes(str).length < 32) return toShortString(str);
        slot.sstore(str);
        return ShortString.wrap(FALLBACK_SENTINEL);
    }

    function toStringWithFallback(StringSlot slot, ShortString sstr) internal view returns (string memory) {
        if (ShortString.unwrap(sstr) != FALLBACK_SENTINEL) return toString(sstr);
        return slot.sload();
    }

    function byteLengthWithFallback(StringSlot slot, ShortString sstr) internal view returns (uint256) {
        if (ShortString.unwrap(sstr) != FALLBACK_SENTINEL) return byteLength(sstr);
        return slot.slength();
    }
}
```

### EIP712

[OpenZeppelin's Implementation](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/cryptography/EIP712.sol)

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {StorageSlot, StringSlot} from "storage-slot/StorageSlot.sol";
import {SlotDerivation} from "storage-slot/SlotDerivation.sol";
import {ShortStrings, ShortString} from "src/types/ShortStrings.sol";

abstract contract EIP712 {
    using ShortString for StringSlot;
    using StorageSlot for uint256;

    // keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)")
    bytes32 private constant DOMAIN_TYPEHASH = 0x8b73c3c69bb8fe3d512ecc4cf759cc79239f7b179b0ffacaa9a75d522b39400f;

    StringSlot private immutable NAME_SLOT = SlotDerivation.erc7201Slot("eip712.name").asStringSlot();
    StringSlot private immutable VERSION_SLOT = SlotDerivation.erc7201Slot("eip712.version").asStringSlot();

    uint256 private immutable _cachedThis;
    uint256 private immutable _cachedChainId;
    bytes32 private immutable _cachedDomainSeparator;

    bytes32 private immutable _hashedName;
    bytes32 private immutable _hashedVersion;

    ShortString private immutable _name;
    ShortString private immutable _version;

    constructor(string memory name, string memory version) {
        _name = NAME_SLOT.toShortStringWithFallback(name);
        _version = VERSION_SLOT.toShortStringWithFallback(version);
        _hashedName = keccak256(bytes(name));
        _hashedVersion = keccak256(bytes(version));

        _cachedThis = uint256(uint160(address(this)));
        _cachedChainId = block.chainid;
        _cachedDomainSeparator = _buildDomainSeparator();
    }

    function _domainSeparatorV4() internal view returns (bytes32) { }

    function _buildDomainSeparator() private view returns (bytes32) { }

    function _hashTypedDataV4(bytes32 structHash) internal view virtual returns (bytes32) { }

	function eip712Domain()
        public
        view
        virtual
        returns (
            bytes1 fields,
            string memory name,
            string memory version,
            uint256 chainId,
            address verifyingContract,
            bytes32 salt,
            uint256[] memory extensions
        )
    {
        return (
            hex"0f", // 01111
            _EIP712Name(),
            _EIP712Version(),
            block.chainid,
            address(this),
            bytes32(0),
            new uint256[](0)
        );
    }

    function _EIP712Name() internal view returns (string memory) {
        return NAME_SLOT.toStringWithFallback(_name);
    }

    function _EIP712Version() internal view returns (string memory) {
        return VERSION_SLOT.toStringWithFallback(_version);
    }
}
```

### Snippet for Handling Dynamic Data (bytes/string)

```solidity
import {StorageSlot, BytesSlot, StringSlot} from "storage-slot/StorageSlot.sol";
import {SlotDerivation} from "storage-slot/SlotDerivation.sol";

using StorageSlot for uint256;

BytesSlot immutable BYTES_SLOT = SlotDerivation.erc7201Slot("BYTES_SLOT").asBytesSlot();
StringSlot immutable STRING_SLOT = SlotDerivation.erc7201Slot("STRING_SLOT").asStringSlot();

bytes memory data = abi.encode(param1, param2, param3);
BYTES_SLOT.sstore(data);

require(BYTES_SLOT.slength() == data.length);
require(keccak256(BYTES_SLOT.sload()) == keccak256(data));

string memory str = "fomoweth/storage-slot";
STRING_SLOT.sstore(str);

require(STRING_SLOT.slength() == bytes(str).length);
require(keccak256(STRING_SLOT.sload()), keccak256(bytes(str)));
```
