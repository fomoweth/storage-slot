// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "./StorageSlot.sol";

/// @title SlotDerivation
/// @notice Library for computing storage locations from namespaces and deriving slots corresponding to standard patterns
/// @dev Modified from https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/SlotDerivation.sol
library SlotDerivation {
    function computeSlot(string memory protocol, string memory domain, string memory variable)
        internal
        pure
        returns (bytes32)
    {
        return erc7201Slot(string.concat(protocol, ".", domain, ".", variable));
    }

    /// @notice Derives an ERC-7201 slot from a string `namespace`
    function erc7201Slot(string memory namespace) internal pure returns (bytes32 slot) {
        assembly ("memory-safe") {
            mstore(0x00, sub(keccak256(add(namespace, 0x20), mload(namespace)), 0x01))
            slot := and(keccak256(0x00, 0x20), not(0xff))
        }
    }

    /// @notice Adds an offset to a slot to get the n-th element of a structure or an array
    function offset(bytes32 slot, uint256 pos) internal pure returns (bytes32) {
        unchecked {
            return bytes32(uint256(slot) + pos);
        }
    }

    /// @notice Derives the location of the first element in an array from the slot where the length is stored
    function deriveArray(bytes32 slot) internal pure returns (bytes32 result) {
        assembly ("memory-safe") {
            mstore(0x00, slot)
            result := keccak256(0x00, 0x20)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(bytes32 slot, address key) internal pure returns (bytes32 result) {
        assembly ("memory-safe") {
            mstore(0x00, shr(0x60, shl(0x60, key)))
            mstore(0x20, slot)
            result := keccak256(0x00, 0x40)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(bytes32 slot, bool key) internal pure returns (bytes32 result) {
        assembly ("memory-safe") {
            mstore(0x00, iszero(iszero(key)))
            mstore(0x20, slot)
            result := keccak256(0x00, 0x40)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(bytes32 slot, bytes32 key) internal pure returns (bytes32 result) {
        assembly ("memory-safe") {
            mstore(0x00, key)
            mstore(0x20, slot)
            result := keccak256(0x00, 0x40)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(bytes32 slot, uint256 key) internal pure returns (bytes32 result) {
        assembly ("memory-safe") {
            mstore(0x00, key)
            mstore(0x20, slot)
            result := keccak256(0x00, 0x40)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(bytes32 slot, int256 key) internal pure returns (bytes32 result) {
        assembly ("memory-safe") {
            mstore(0x00, key)
            mstore(0x20, slot)
            result := keccak256(0x00, 0x40)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(bytes32 slot, string memory key) internal pure returns (bytes32 result) {
        assembly ("memory-safe") {
            let length := mload(key)
            let begin := add(key, 0x20)
            let end := add(begin, length)
            let cache := mload(end)
            mstore(end, slot)
            result := keccak256(begin, add(length, 0x20))
            mstore(end, cache)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(bytes32 slot, bytes memory key) internal pure returns (bytes32 result) {
        assembly ("memory-safe") {
            let length := mload(key)
            let begin := add(key, 0x20)
            let end := add(begin, length)
            let cache := mload(end)
            mstore(end, slot)
            result := keccak256(begin, add(length, 0x20))
            mstore(end, cache)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(AddressSlot slot, address key) internal pure returns (AddressSlot result) {
        assembly ("memory-safe") {
            mstore(0x00, shr(0x60, shl(0x60, key)))
            mstore(0x20, slot)
            result := keccak256(0x00, 0x40)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(AddressSlot slot, bool key) internal pure returns (AddressSlot result) {
        assembly ("memory-safe") {
            mstore(0x00, iszero(iszero(key)))
            mstore(0x20, slot)
            result := keccak256(0x00, 0x40)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(AddressSlot slot, bytes32 key) internal pure returns (AddressSlot result) {
        assembly ("memory-safe") {
            mstore(0x00, key)
            mstore(0x20, slot)
            result := keccak256(0x00, 0x40)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(AddressSlot slot, uint256 key) internal pure returns (AddressSlot result) {
        assembly ("memory-safe") {
            mstore(0x00, key)
            mstore(0x20, slot)
            result := keccak256(0x00, 0x40)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(AddressSlot slot, int256 key) internal pure returns (AddressSlot result) {
        assembly ("memory-safe") {
            mstore(0x00, key)
            mstore(0x20, slot)
            result := keccak256(0x00, 0x40)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(AddressSlot slot, bytes memory key) internal pure returns (AddressSlot result) {
        assembly ("memory-safe") {
            let length := mload(key)
            let begin := add(key, 0x20)
            let end := add(begin, length)
            let cache := mload(end)
            mstore(end, slot)
            result := keccak256(begin, add(length, 0x20))
            mstore(end, cache)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(AddressSlot slot, string memory key) internal pure returns (AddressSlot result) {
        assembly ("memory-safe") {
            let length := mload(key)
            let begin := add(key, 0x20)
            let end := add(begin, length)
            let cache := mload(end)
            mstore(end, slot)
            result := keccak256(begin, add(length, 0x20))
            mstore(end, cache)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(BooleanSlot slot, address key) internal pure returns (BooleanSlot result) {
        assembly ("memory-safe") {
            mstore(0x00, shr(0x60, shl(0x60, key)))
            mstore(0x20, slot)
            result := keccak256(0x00, 0x40)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(BooleanSlot slot, bool key) internal pure returns (BooleanSlot result) {
        assembly ("memory-safe") {
            mstore(0x00, iszero(iszero(key)))
            mstore(0x20, slot)
            result := keccak256(0x00, 0x40)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(BooleanSlot slot, bytes32 key) internal pure returns (BooleanSlot result) {
        assembly ("memory-safe") {
            mstore(0x00, key)
            mstore(0x20, slot)
            result := keccak256(0x00, 0x40)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(BooleanSlot slot, uint256 key) internal pure returns (BooleanSlot result) {
        assembly ("memory-safe") {
            mstore(0x00, key)
            mstore(0x20, slot)
            result := keccak256(0x00, 0x40)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(BooleanSlot slot, int256 key) internal pure returns (BooleanSlot result) {
        assembly ("memory-safe") {
            mstore(0x00, key)
            mstore(0x20, slot)
            result := keccak256(0x00, 0x40)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(BooleanSlot slot, bytes memory key) internal pure returns (BooleanSlot result) {
        assembly ("memory-safe") {
            let length := mload(key)
            let begin := add(key, 0x20)
            let end := add(begin, length)
            let cache := mload(end)
            mstore(end, slot)
            result := keccak256(begin, add(length, 0x20))
            mstore(end, cache)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(BooleanSlot slot, string memory key) internal pure returns (BooleanSlot result) {
        assembly ("memory-safe") {
            let length := mload(key)
            let begin := add(key, 0x20)
            let end := add(begin, length)
            let cache := mload(end)
            mstore(end, slot)
            result := keccak256(begin, add(length, 0x20))
            mstore(end, cache)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(Bytes32Slot slot, address key) internal pure returns (Bytes32Slot result) {
        assembly ("memory-safe") {
            mstore(0x00, shr(0x60, shl(0x60, key)))
            mstore(0x20, slot)
            result := keccak256(0x00, 0x40)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(Bytes32Slot slot, bool key) internal pure returns (Bytes32Slot result) {
        assembly ("memory-safe") {
            mstore(0x00, iszero(iszero(key)))
            mstore(0x20, slot)
            result := keccak256(0x00, 0x40)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(Bytes32Slot slot, bytes32 key) internal pure returns (Bytes32Slot result) {
        assembly ("memory-safe") {
            mstore(0x00, key)
            mstore(0x20, slot)
            result := keccak256(0x00, 0x40)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(Bytes32Slot slot, uint256 key) internal pure returns (Bytes32Slot result) {
        assembly ("memory-safe") {
            mstore(0x00, key)
            mstore(0x20, slot)
            result := keccak256(0x00, 0x40)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(Bytes32Slot slot, int256 key) internal pure returns (Bytes32Slot result) {
        assembly ("memory-safe") {
            mstore(0x00, key)
            mstore(0x20, slot)
            result := keccak256(0x00, 0x40)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(Bytes32Slot slot, bytes memory key) internal pure returns (Bytes32Slot result) {
        assembly ("memory-safe") {
            let length := mload(key)
            let begin := add(key, 0x20)
            let end := add(begin, length)
            let cache := mload(end)
            mstore(end, slot)
            result := keccak256(begin, add(length, 0x20))
            mstore(end, cache)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(Bytes32Slot slot, string memory key) internal pure returns (Bytes32Slot result) {
        assembly ("memory-safe") {
            let length := mload(key)
            let begin := add(key, 0x20)
            let end := add(begin, length)
            let cache := mload(end)
            mstore(end, slot)
            result := keccak256(begin, add(length, 0x20))
            mstore(end, cache)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(Uint256Slot slot, address key) internal pure returns (Uint256Slot result) {
        assembly ("memory-safe") {
            mstore(0x00, shr(0x60, shl(0x60, key)))
            mstore(0x20, slot)
            result := keccak256(0x00, 0x40)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(Uint256Slot slot, bool key) internal pure returns (Uint256Slot result) {
        assembly ("memory-safe") {
            mstore(0x00, iszero(iszero(key)))
            mstore(0x20, slot)
            result := keccak256(0x00, 0x40)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(Uint256Slot slot, bytes32 key) internal pure returns (Uint256Slot result) {
        assembly ("memory-safe") {
            mstore(0x00, key)
            mstore(0x20, slot)
            result := keccak256(0x00, 0x40)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(Uint256Slot slot, uint256 key) internal pure returns (Uint256Slot result) {
        assembly ("memory-safe") {
            mstore(0x00, key)
            mstore(0x20, slot)
            result := keccak256(0x00, 0x40)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(Uint256Slot slot, int256 key) internal pure returns (Uint256Slot result) {
        assembly ("memory-safe") {
            mstore(0x00, key)
            mstore(0x20, slot)
            result := keccak256(0x00, 0x40)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(Uint256Slot slot, bytes memory key) internal pure returns (Uint256Slot result) {
        assembly ("memory-safe") {
            let length := mload(key)
            let begin := add(key, 0x20)
            let end := add(begin, length)
            let cache := mload(end)
            mstore(end, slot)
            result := keccak256(begin, add(length, 0x20))
            mstore(end, cache)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(Uint256Slot slot, string memory key) internal pure returns (Uint256Slot result) {
        assembly ("memory-safe") {
            let length := mload(key)
            let begin := add(key, 0x20)
            let end := add(begin, length)
            let cache := mload(end)
            mstore(end, slot)
            result := keccak256(begin, add(length, 0x20))
            mstore(end, cache)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(Int256Slot slot, address key) internal pure returns (Int256Slot result) {
        assembly ("memory-safe") {
            mstore(0x00, shr(0x60, shl(0x60, key)))
            mstore(0x20, slot)
            result := keccak256(0x00, 0x40)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(Int256Slot slot, bool key) internal pure returns (Int256Slot result) {
        assembly ("memory-safe") {
            mstore(0x00, iszero(iszero(key)))
            mstore(0x20, slot)
            result := keccak256(0x00, 0x40)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(Int256Slot slot, bytes32 key) internal pure returns (Int256Slot result) {
        assembly ("memory-safe") {
            mstore(0x00, key)
            mstore(0x20, slot)
            result := keccak256(0x00, 0x40)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(Int256Slot slot, uint256 key) internal pure returns (Int256Slot result) {
        assembly ("memory-safe") {
            mstore(0x00, key)
            mstore(0x20, slot)
            result := keccak256(0x00, 0x40)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(Int256Slot slot, int256 key) internal pure returns (Int256Slot result) {
        assembly ("memory-safe") {
            mstore(0x00, key)
            mstore(0x20, slot)
            result := keccak256(0x00, 0x40)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(Int256Slot slot, bytes memory key) internal pure returns (Int256Slot result) {
        assembly ("memory-safe") {
            let length := mload(key)
            let begin := add(key, 0x20)
            let end := add(begin, length)
            let cache := mload(end)
            mstore(end, slot)
            result := keccak256(begin, add(length, 0x20))
            mstore(end, cache)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(Int256Slot slot, string memory key) internal pure returns (Int256Slot result) {
        assembly ("memory-safe") {
            let length := mload(key)
            let begin := add(key, 0x20)
            let end := add(begin, length)
            let cache := mload(end)
            mstore(end, slot)
            result := keccak256(begin, add(length, 0x20))
            mstore(end, cache)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(BytesSlot slot, address key) internal pure returns (BytesSlot result) {
        assembly ("memory-safe") {
            mstore(0x00, shr(0x60, shl(0x60, key)))
            mstore(0x20, slot)
            result := keccak256(0x00, 0x40)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(BytesSlot slot, bool key) internal pure returns (BytesSlot result) {
        assembly ("memory-safe") {
            mstore(0x00, iszero(iszero(key)))
            mstore(0x20, slot)
            result := keccak256(0x00, 0x40)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(BytesSlot slot, bytes32 key) internal pure returns (BytesSlot result) {
        assembly ("memory-safe") {
            mstore(0x00, key)
            mstore(0x20, slot)
            result := keccak256(0x00, 0x40)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(BytesSlot slot, uint256 key) internal pure returns (BytesSlot result) {
        assembly ("memory-safe") {
            mstore(0x00, key)
            mstore(0x20, slot)
            result := keccak256(0x00, 0x40)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(BytesSlot slot, int256 key) internal pure returns (BytesSlot result) {
        assembly ("memory-safe") {
            mstore(0x00, key)
            mstore(0x20, slot)
            result := keccak256(0x00, 0x40)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(BytesSlot slot, bytes memory key) internal pure returns (BytesSlot result) {
        assembly ("memory-safe") {
            let length := mload(key)
            let begin := add(key, 0x20)
            let end := add(begin, length)
            let cache := mload(end)
            mstore(end, slot)
            result := keccak256(begin, add(length, 0x20))
            mstore(end, cache)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(BytesSlot slot, string memory key) internal pure returns (BytesSlot result) {
        assembly ("memory-safe") {
            let length := mload(key)
            let begin := add(key, 0x20)
            let end := add(begin, length)
            let cache := mload(end)
            mstore(end, slot)
            result := keccak256(begin, add(length, 0x20))
            mstore(end, cache)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(StringSlot slot, address key) internal pure returns (StringSlot result) {
        assembly ("memory-safe") {
            mstore(0x00, shr(0x60, shl(0x60, key)))
            mstore(0x20, slot)
            result := keccak256(0x00, 0x40)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(StringSlot slot, bool key) internal pure returns (StringSlot result) {
        assembly ("memory-safe") {
            mstore(0x00, iszero(iszero(key)))
            mstore(0x20, slot)
            result := keccak256(0x00, 0x40)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(StringSlot slot, bytes32 key) internal pure returns (StringSlot result) {
        assembly ("memory-safe") {
            mstore(0x00, key)
            mstore(0x20, slot)
            result := keccak256(0x00, 0x40)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(StringSlot slot, uint256 key) internal pure returns (StringSlot result) {
        assembly ("memory-safe") {
            mstore(0x00, key)
            mstore(0x20, slot)
            result := keccak256(0x00, 0x40)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(StringSlot slot, int256 key) internal pure returns (StringSlot result) {
        assembly ("memory-safe") {
            mstore(0x00, key)
            mstore(0x20, slot)
            result := keccak256(0x00, 0x40)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(StringSlot slot, bytes memory key) internal pure returns (StringSlot result) {
        assembly ("memory-safe") {
            let length := mload(key)
            let begin := add(key, 0x20)
            let end := add(begin, length)
            let cache := mload(end)
            mstore(end, slot)
            result := keccak256(begin, add(length, 0x20))
            mstore(end, cache)
        }
    }

    /// @notice Derives the location of a mapping element from the key
    function derive(StringSlot slot, string memory key) internal pure returns (StringSlot result) {
        assembly ("memory-safe") {
            let length := mload(key)
            let begin := add(key, 0x20)
            let end := add(begin, length)
            let cache := mload(end)
            mstore(end, slot)
            result := keccak256(begin, add(length, 0x20))
            mstore(end, cache)
        }
    }
}
