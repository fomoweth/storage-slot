// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {
    AddressSlot,
    BooleanSlot,
    Bytes32Slot,
    Uint256Slot,
    Int256Slot,
    BytesSlot,
    StringSlot,
    StorageSlot
} from "src/StorageSlot.sol";
import {SlotDerivation} from "src/SlotDerivation.sol";

contract StorageSlotTest is Test {
    using StorageSlot for bytes32;
    using SlotDerivation for bytes32;

    bytes32 internal immutable ADDRESS_SLOT = SlotDerivation.erc7201Slot("ADDRESS_SLOT");
    bytes32 internal immutable BOOLEAN_SLOT = SlotDerivation.erc7201Slot("BOOLEAN_SLOT");
    bytes32 internal immutable BYTES32_SLOT = SlotDerivation.erc7201Slot("BYTES32_SLOT");
    bytes32 internal immutable UINT256_SLOT = SlotDerivation.erc7201Slot("UINT256_SLOT");
    bytes32 internal immutable INT256_SLOT = SlotDerivation.erc7201Slot("INT256_SLOT");
    bytes32 internal immutable BYTES_SLOT = SlotDerivation.erc7201Slot("BYTES_SLOT");
    bytes32 internal immutable STRING_SLOT = SlotDerivation.erc7201Slot("STRING_SLOT");

    uint256 internal constant LENGTH_MASK = 0xffffffff;

    function test_fuzz_persistent_storage_address(address value) public {
        AddressSlot slot = ADDRESS_SLOT.asAddress();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, address(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_address(address key, address value) public {
        AddressSlot slot = ADDRESS_SLOT.derive(key).asAddress();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, address(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_address(bytes32 key, address value) public {
        AddressSlot slot = ADDRESS_SLOT.derive(key).asAddress();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, address(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_address(uint256 key, address value) public {
        AddressSlot slot = ADDRESS_SLOT.derive(key).asAddress();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, address(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_address(int256 key, address value) public {
        AddressSlot slot = ADDRESS_SLOT.derive(key).asAddress();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, address(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_address(bytes memory key, address value) public {
        AddressSlot slot = ADDRESS_SLOT.derive(key).asAddress();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, address(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_address(string memory key, address value) public {
        AddressSlot slot = ADDRESS_SLOT.derive(key).asAddress();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, address(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_boolean(bool value) public {
        BooleanSlot slot = BOOLEAN_SLOT.asBoolean();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, !value, false);
    }

    function test_fuzz_persistent_storage_boolean(address key, bool value) public {
        BooleanSlot slot = BOOLEAN_SLOT.derive(key).asBoolean();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, !value, false);
    }

    function test_fuzz_persistent_storage_boolean(bytes32 key, bool value) public {
        BooleanSlot slot = BOOLEAN_SLOT.derive(key).asBoolean();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, !value, false);
    }

    function test_fuzz_persistent_storage_boolean(uint256 key, bool value) public {
        BooleanSlot slot = BOOLEAN_SLOT.derive(key).asBoolean();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, !value, false);
    }

    function test_fuzz_persistent_storage_boolean(int256 key, bool value) public {
        BooleanSlot slot = BOOLEAN_SLOT.derive(key).asBoolean();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, !value, false);
    }

    function test_fuzz_persistent_storage_boolean(bytes memory key, bool value) public {
        BooleanSlot slot = BOOLEAN_SLOT.derive(key).asBoolean();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, !value, false);
    }

    function test_fuzz_persistent_storage_boolean(string memory key, bool value) public {
        BooleanSlot slot = BOOLEAN_SLOT.derive(key).asBoolean();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, !value, false);
    }

    function test_fuzz_persistent_storage_bytes32(bytes32 value) public {
        Bytes32Slot slot = BYTES32_SLOT.asBytes32();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, bytes32(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_bytes32(address key, bytes32 value) public {
        Bytes32Slot slot = BYTES32_SLOT.derive(key).asBytes32();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, bytes32(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_bytes32(bytes32 key, bytes32 value) public {
        Bytes32Slot slot = BYTES32_SLOT.derive(key).asBytes32();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, bytes32(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_bytes32(uint256 key, bytes32 value) public {
        Bytes32Slot slot = BYTES32_SLOT.derive(key).asBytes32();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, bytes32(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_bytes32(int256 key, bytes32 value) public {
        Bytes32Slot slot = BYTES32_SLOT.derive(key).asBytes32();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, bytes32(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_bytes32(bytes memory key, bytes32 value) public {
        Bytes32Slot slot = BYTES32_SLOT.derive(key).asBytes32();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, bytes32(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_bytes32(string memory key, bytes32 value) public {
        Bytes32Slot slot = BYTES32_SLOT.derive(key).asBytes32();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, bytes32(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_uint256(uint256 value) public {
        Uint256Slot slot = UINT256_SLOT.asUint256();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, uint256(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_uint256(address key, uint256 value) public {
        Uint256Slot slot = UINT256_SLOT.derive(key).asUint256();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, uint256(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_uint256(bytes32 key, uint256 value) public {
        Uint256Slot slot = UINT256_SLOT.derive(key).asUint256();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, uint256(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_uint256(uint256 key, uint256 value) public {
        Uint256Slot slot = UINT256_SLOT.derive(key).asUint256();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, uint256(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_uint256(int256 key, uint256 value) public {
        Uint256Slot slot = UINT256_SLOT.derive(key).asUint256();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, uint256(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_uint256(bytes memory key, uint256 value) public {
        Uint256Slot slot = UINT256_SLOT.derive(key).asUint256();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, uint256(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_uint256(string memory key, uint256 value) public {
        Uint256Slot slot = UINT256_SLOT.derive(key).asUint256();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, uint256(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_int256(int256 value) public {
        Int256Slot slot = INT256_SLOT.asInt256();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, int256(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_int256(address key, int256 value) public {
        Int256Slot slot = INT256_SLOT.derive(key).asInt256();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, int256(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_int256(bytes32 key, int256 value) public {
        Int256Slot slot = INT256_SLOT.derive(key).asInt256();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, int256(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_int256(uint256 key, int256 value) public {
        Int256Slot slot = INT256_SLOT.derive(key).asInt256();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, int256(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_int256(int256 key, int256 value) public {
        Int256Slot slot = INT256_SLOT.derive(key).asInt256();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, int256(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_int256(bytes memory key, int256 value) public {
        Int256Slot slot = INT256_SLOT.derive(key).asInt256();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, int256(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_int256(string memory key, int256 value) public {
        Int256Slot slot = INT256_SLOT.derive(key).asInt256();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, int256(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_bytes(bytes memory value) public {
        BytesSlot slot = BYTES_SLOT.asBytes();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, new bytes(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_bytes(address key, bytes memory value) public {
        BytesSlot slot = BYTES_SLOT.derive(key).asBytes();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, new bytes(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_bytes(bytes32 key, bytes memory value) public {
        BytesSlot slot = BYTES_SLOT.derive(key).asBytes();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, new bytes(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_bytes(uint256 key, bytes memory value) public {
        BytesSlot slot = BYTES_SLOT.derive(key).asBytes();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, new bytes(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_bytes(int256 key, bytes memory value) public {
        BytesSlot slot = BYTES_SLOT.derive(key).asBytes();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, new bytes(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_bytes(bytes memory key, bytes memory value) public {
        BytesSlot slot = BYTES_SLOT.derive(key).asBytes();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, new bytes(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_bytes(string memory key, bytes memory value) public {
        BytesSlot slot = BYTES_SLOT.derive(key).asBytes();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, new bytes(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_string(string memory value) public {
        StringSlot slot = STRING_SLOT.asString();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, new string(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_string(address key, string memory value) public {
        StringSlot slot = STRING_SLOT.derive(key).asString();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, new string(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_string(bytes32 key, string memory value) public {
        StringSlot slot = STRING_SLOT.derive(key).asString();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, new string(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_string(uint256 key, string memory value) public {
        StringSlot slot = STRING_SLOT.derive(key).asString();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, new string(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_string(int256 key, string memory value) public {
        StringSlot slot = STRING_SLOT.derive(key).asString();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, new string(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_string(bytes memory key, string memory value) public {
        StringSlot slot = STRING_SLOT.derive(key).asString();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, new string(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_persistent_storage_string(string memory key, string memory value) public {
        StringSlot slot = STRING_SLOT.derive(key).asString();
        assertSlotEmpty(slot, false);
        testStore(slot, value, false);
        testStore(slot, new string(0), false);
        assertSlotEmpty(slot, false);
    }

    function test_fuzz_transient_storage_address(address value) public {
        AddressSlot slot = ADDRESS_SLOT.asAddress();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_address(address key, address value) public {
        AddressSlot slot = ADDRESS_SLOT.derive(key).asAddress();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_address(bool key, address value) public {
        AddressSlot slot = ADDRESS_SLOT.derive(key).asAddress();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_address(bytes32 key, address value) public {
        AddressSlot slot = ADDRESS_SLOT.derive(key).asAddress();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_address(uint256 key, address value) public {
        AddressSlot slot = ADDRESS_SLOT.derive(key).asAddress();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_address(int256 key, address value) public {
        AddressSlot slot = ADDRESS_SLOT.derive(key).asAddress();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_address(bytes memory key, address value) public {
        AddressSlot slot = ADDRESS_SLOT.derive(key).asAddress();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_address(string memory key, address value) public {
        AddressSlot slot = ADDRESS_SLOT.derive(key).asAddress();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_boolean(bool value) public {
        BooleanSlot slot = BOOLEAN_SLOT.asBoolean();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_boolean(address key, bool value) public {
        BooleanSlot slot = BOOLEAN_SLOT.derive(key).asBoolean();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_boolean(bool key, bool value) public {
        BooleanSlot slot = BOOLEAN_SLOT.derive(key).asBoolean();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_boolean(bytes32 key, bool value) public {
        BooleanSlot slot = BOOLEAN_SLOT.derive(key).asBoolean();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_boolean(uint256 key, bool value) public {
        BooleanSlot slot = BOOLEAN_SLOT.derive(key).asBoolean();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_boolean(int256 key, bool value) public {
        BooleanSlot slot = BOOLEAN_SLOT.derive(key).asBoolean();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_boolean(bytes memory key, bool value) public {
        BooleanSlot slot = BOOLEAN_SLOT.derive(key).asBoolean();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_boolean(string memory key, bool value) public {
        BooleanSlot slot = BOOLEAN_SLOT.derive(key).asBoolean();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_bytes32(bytes32 value) public {
        Bytes32Slot slot = BYTES32_SLOT.asBytes32();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_bytes32(address key, bytes32 value) public {
        Bytes32Slot slot = BYTES32_SLOT.derive(key).asBytes32();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_bytes32(bool key, bytes32 value) public {
        Bytes32Slot slot = BYTES32_SLOT.derive(key).asBytes32();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_bytes32(bytes32 key, bytes32 value) public {
        Bytes32Slot slot = BYTES32_SLOT.derive(key).asBytes32();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_bytes32(uint256 key, bytes32 value) public {
        Bytes32Slot slot = BYTES32_SLOT.derive(key).asBytes32();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_bytes32(int256 key, bytes32 value) public {
        Bytes32Slot slot = BYTES32_SLOT.derive(key).asBytes32();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_bytes32(bytes memory key, bytes32 value) public {
        Bytes32Slot slot = BYTES32_SLOT.derive(key).asBytes32();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_bytes32(string memory key, bytes32 value) public {
        Bytes32Slot slot = BYTES32_SLOT.derive(key).asBytes32();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_uint256(uint256 value) public {
        Uint256Slot slot = UINT256_SLOT.asUint256();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_uint256(address key, uint256 value) public {
        Uint256Slot slot = UINT256_SLOT.derive(key).asUint256();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_uint256(bool key, uint256 value) public {
        Uint256Slot slot = UINT256_SLOT.derive(key).asUint256();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_uint256(bytes32 key, uint256 value) public {
        Uint256Slot slot = UINT256_SLOT.derive(key).asUint256();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_uint256(uint256 key, uint256 value) public {
        Uint256Slot slot = UINT256_SLOT.derive(key).asUint256();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_uint256(int256 key, uint256 value) public {
        Uint256Slot slot = UINT256_SLOT.derive(key).asUint256();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_uint256(bytes memory key, uint256 value) public {
        Uint256Slot slot = UINT256_SLOT.derive(key).asUint256();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_uint256(string memory key, uint256 value) public {
        Uint256Slot slot = UINT256_SLOT.derive(key).asUint256();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_int256(int256 value) public {
        Int256Slot slot = INT256_SLOT.asInt256();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_int256(address key, int256 value) public {
        Int256Slot slot = INT256_SLOT.derive(key).asInt256();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_int256(bool key, int256 value) public {
        Int256Slot slot = INT256_SLOT.derive(key).asInt256();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_int256(bytes32 key, int256 value) public {
        Int256Slot slot = INT256_SLOT.derive(key).asInt256();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_int256(uint256 key, int256 value) public {
        Int256Slot slot = INT256_SLOT.derive(key).asInt256();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_int256(int256 key, int256 value) public {
        Int256Slot slot = INT256_SLOT.derive(key).asInt256();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_int256(bytes memory key, int256 value) public {
        Int256Slot slot = INT256_SLOT.derive(key).asInt256();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_int256(string memory key, int256 value) public {
        Int256Slot slot = INT256_SLOT.derive(key).asInt256();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_bytes(bytes memory value) public {
        BytesSlot slot = BYTES_SLOT.asBytes();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_bytes(address key, bytes memory value) public {
        BytesSlot slot = BYTES_SLOT.derive(key).asBytes();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_bytes(bool key, bytes memory value) public {
        BytesSlot slot = BYTES_SLOT.derive(key).asBytes();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_bytes(bytes32 key, bytes memory value) public {
        BytesSlot slot = BYTES_SLOT.derive(key).asBytes();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_bytes(uint256 key, bytes memory value) public {
        BytesSlot slot = BYTES_SLOT.derive(key).asBytes();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_bytes(int256 key, bytes memory value) public {
        BytesSlot slot = BYTES_SLOT.derive(key).asBytes();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_bytes(bytes memory key, bytes memory value) public {
        BytesSlot slot = BYTES_SLOT.derive(key).asBytes();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_bytes(string memory key, bytes memory value) public {
        BytesSlot slot = BYTES_SLOT.derive(key).asBytes();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_string(string memory value) public {
        StringSlot slot = STRING_SLOT.asString();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_string(address key, string memory value) public {
        StringSlot slot = STRING_SLOT.derive(key).asString();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_string(bool key, string memory value) public {
        StringSlot slot = STRING_SLOT.derive(key).asString();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_string(bytes32 key, string memory value) public {
        StringSlot slot = STRING_SLOT.derive(key).asString();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_string(uint256 key, string memory value) public {
        StringSlot slot = STRING_SLOT.derive(key).asString();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_string(int256 key, string memory value) public {
        StringSlot slot = STRING_SLOT.derive(key).asString();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_string(bytes memory key, string memory value) public {
        StringSlot slot = STRING_SLOT.derive(key).asString();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function test_fuzz_transient_storage_string(string memory key, string memory value) public {
        StringSlot slot = STRING_SLOT.derive(key).asString();
        assertSlotEmpty(slot, true);
        testStore(slot, value, true);
        testClear(slot);
    }

    function testStore(AddressSlot slot, address value, bool isTransient) internal {
        if (isTransient) {
            slot.tstore(value);
            assertEq(slot.tload(), value);
        } else {
            slot.sstore(value);
            assertEq(slot.sload(), value);
        }
    }

    function testStore(BooleanSlot slot, bool value, bool isTransient) internal {
        if (isTransient) {
            slot.tstore(value);
            assertEq(slot.tload(), value);
        } else {
            slot.sstore(value);
            assertEq(slot.sload(), value);
        }
    }

    function testStore(Bytes32Slot slot, bytes32 value, bool isTransient) internal {
        if (isTransient) {
            slot.tstore(value);
            assertEq(slot.tload(), value);
        } else {
            slot.sstore(value);
            assertEq(slot.sload(), value);
        }
    }

    function testStore(Uint256Slot slot, uint256 value, bool isTransient) internal {
        if (isTransient) {
            slot.tstore(value);
            assertEq(slot.tload(), value);
        } else {
            slot.sstore(value);
            assertEq(slot.sload(), value);
        }
    }

    function testStore(Int256Slot slot, int256 value, bool isTransient) internal {
        if (isTransient) {
            slot.tstore(value);
            assertEq(slot.tload(), value);
        } else {
            slot.sstore(value);
            assertEq(slot.sload(), value);
        }
    }

    function testStore(BytesSlot slot, bytes memory value, bool isTransient) internal {
        if (value.length > LENGTH_MASK) {
            vm.expectRevert(StorageSlot.ExceededMaxDataLength.selector);
            if (isTransient) slot.tstore(value);
            else slot.sstore(value);
            return;
        }

        if (isTransient) {
            slot.tstore(value);
            assertEq(slot.tlength(), value.length);
            assertEq(slot.tload(), value);
        } else {
            slot.sstore(value);
            assertEq(slot.slength(), value.length);
            assertEq(slot.sload(), value);
        }
    }

    function testStore(StringSlot slot, string memory value, bool isTransient) internal {
        if (bytes(value).length > LENGTH_MASK) {
            vm.expectRevert(StorageSlot.ExceededMaxDataLength.selector);
            if (isTransient) slot.tstore(value);
            else slot.sstore(value);
            return;
        }

        if (isTransient) {
            slot.tstore(value);
            assertEq(slot.tlength(), bytes(value).length);
            assertEq(slot.tload(), value);
        } else {
            slot.sstore(value);
            assertEq(slot.slength(), bytes(value).length);
            assertEq(slot.sload(), value);
        }
    }

    function testClear(AddressSlot slot) internal {
        slot.tclear();
        assertSlotEmpty(slot, true);
    }

    function testClear(BooleanSlot slot) internal {
        slot.tclear();
        assertSlotEmpty(slot, true);
    }

    function testClear(Bytes32Slot slot) internal {
        slot.tclear();
        assertSlotEmpty(slot, true);
    }

    function testClear(Uint256Slot slot) internal {
        slot.tclear();
        assertSlotEmpty(slot, true);
    }

    function testClear(Int256Slot slot) internal {
        slot.tclear();
        assertSlotEmpty(slot, true);
    }

    function testClear(BytesSlot slot) internal {
        slot.tclear();
        assertSlotEmpty(slot, true);
    }

    function testClear(StringSlot slot) internal {
        slot.tclear();
        assertSlotEmpty(slot, true);
    }

    function assertSlotEmpty(AddressSlot slot, bool isTransient) internal view {
        if (isTransient) {
            assertTrue(slot.isEmpty());
            assertEq(slot.tload(), address(0));
        } else {
            assertEq(slot.sload(), address(0));
        }
    }

    function assertSlotEmpty(BooleanSlot slot, bool isTransient) internal view {
        if (isTransient) {
            assertTrue(slot.isEmpty());
            assertEq(slot.tload(), false);
        } else {
            assertEq(slot.sload(), false);
        }
    }

    function assertSlotEmpty(Bytes32Slot slot, bool isTransient) internal view {
        if (isTransient) {
            assertTrue(slot.isEmpty());
            assertEq(slot.tload(), bytes32(0));
        } else {
            assertEq(slot.sload(), bytes32(0));
        }
    }

    function assertSlotEmpty(Uint256Slot slot, bool isTransient) internal view {
        if (isTransient) {
            assertTrue(slot.isEmpty());
            assertEq(slot.tload(), uint256(0));
        } else {
            assertEq(slot.sload(), uint256(0));
        }
    }

    function assertSlotEmpty(Int256Slot slot, bool isTransient) internal view {
        if (isTransient) {
            assertTrue(slot.isEmpty());
            assertEq(slot.tload(), int256(0));
        } else {
            assertEq(slot.sload(), int256(0));
        }
    }

    function assertSlotEmpty(BytesSlot slot, bool isTransient) internal view {
        if (isTransient) {
            assertTrue(slot.isEmpty());
            assertEq(slot.tlength(), uint256(0));
            assertEq(slot.tload(), new bytes(0));
        } else {
            assertEq(slot.slength(), uint256(0));
            assertEq(slot.sload(), new bytes(0));
        }
    }

    function assertSlotEmpty(StringSlot slot, bool isTransient) internal view {
        if (isTransient) {
            assertTrue(slot.isEmpty());
            assertEq(slot.tlength(), uint256(0));
            assertEq(slot.tload(), new string(0));
        } else {
            assertEq(slot.slength(), uint256(0));
            assertEq(slot.sload(), new string(0));
        }
    }
}
