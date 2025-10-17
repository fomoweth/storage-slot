// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {SlotDerivation} from "src/SlotDerivation.sol";

contract SlotDerivationTest is Test {
    using SlotDerivation for bytes32;

    bytes[] internal array;

    function test_fuzz_derive_array(uint256 length, uint256 offset) public {
        vm.assume(length > 0);
        vm.assume(offset < length);

        bytes32 baseSlot;
        assembly ("memory-safe") {
            baseSlot := array.slot
            sstore(baseSlot, length)
        }

        bytes storage derived = array[offset];
        bytes32 derivedSlot;
        assembly ("memory-safe") {
            derivedSlot := derived.slot
        }

        assertEq(baseSlot.deriveArray().offset(offset), derivedSlot);
    }

    mapping(address => bytes) internal addressMapping;

    function test_fuzz_derive_addressMapping(address key) public view {
        bytes storage derived = addressMapping[key];

        bytes32 baseSlot;
        bytes32 derivedSlot;
        assembly ("memory-safe") {
            baseSlot := addressMapping.slot
            derivedSlot := derived.slot
        }

        assertEq(baseSlot.derive(key), derivedSlot);
    }

    function test_fuzz_derive_addressMapping(address key1, address key2) public view {
        bytes storage derived1 = addressMapping[key1];
        bytes storage derived2 = addressMapping[key2];

        bytes32 baseSlot;
        bytes32 derived1Slot;
        bytes32 derived2Slot;
        assembly ("memory-safe") {
            baseSlot := addressMapping.slot
            derived1Slot := derived1.slot
            derived2Slot := derived2.slot
        }

        assertEq(baseSlot.derive(key1), derived1Slot);
        assertEq(baseSlot.derive(key2), derived2Slot);

        if (key1 == key2) assertEq(derived1Slot, derived2Slot);
        else assertNotEq(derived1Slot, derived2Slot);
    }

    mapping(bool => bytes) internal boolMapping;

    function test_fuzz_derive_booleanMapping(bool key) public view {
        bytes storage derived = boolMapping[key];

        bytes32 baseSlot;
        bytes32 derivedSlot;
        assembly ("memory-safe") {
            baseSlot := boolMapping.slot
            derivedSlot := derived.slot
        }

        assertEq(baseSlot.derive(key), derivedSlot);
    }

    function test_fuzz_derive_booleanMapping(bool key1, bool key2) public view {
        bytes storage derived1 = boolMapping[key1];
        bytes storage derived2 = boolMapping[key2];

        bytes32 baseSlot;
        bytes32 derived1Slot;
        bytes32 derived2Slot;
        assembly ("memory-safe") {
            baseSlot := boolMapping.slot
            derived1Slot := derived1.slot
            derived2Slot := derived2.slot
        }

        assertEq(baseSlot.derive(key1), derived1Slot);
        assertEq(baseSlot.derive(key2), derived2Slot);

        if (key1 == key2) assertEq(derived1Slot, derived2Slot);
        else assertNotEq(derived1Slot, derived2Slot);
    }

    mapping(bytes32 => bytes) internal bytes32Mapping;

    function test_fuzz_derive_bytes32Mapping(bytes32 key) public view {
        bytes storage derived = bytes32Mapping[key];

        bytes32 baseSlot;
        bytes32 derivedSlot;
        assembly ("memory-safe") {
            baseSlot := bytes32Mapping.slot
            derivedSlot := derived.slot
        }

        assertEq(baseSlot.derive(key), derivedSlot);
    }

    function test_fuzz_derive_bytes32Mapping(bytes32 key1, bytes32 key2) public view {
        bytes storage derived1 = bytes32Mapping[key1];
        bytes storage derived2 = bytes32Mapping[key2];

        bytes32 baseSlot;
        bytes32 derived1Slot;
        bytes32 derived2Slot;
        assembly ("memory-safe") {
            baseSlot := bytes32Mapping.slot
            derived1Slot := derived1.slot
            derived2Slot := derived2.slot
        }

        assertEq(baseSlot.derive(key1), derived1Slot);
        assertEq(baseSlot.derive(key2), derived2Slot);

        if (key1 == key2) assertEq(derived1Slot, derived2Slot);
        else assertNotEq(derived1Slot, derived2Slot);
    }

    mapping(bytes4 => bytes) internal bytes4Mapping;

    function test_fuzz_derive_bytes4Mapping(bytes4 key) public view {
        bytes storage derived = bytes4Mapping[key];

        bytes32 baseSlot;
        bytes32 derivedSlot;
        assembly ("memory-safe") {
            baseSlot := bytes4Mapping.slot
            derivedSlot := derived.slot
        }

        assertEq(baseSlot.derive(key), derivedSlot);
    }

    function test_fuzz_derive_bytes4Mapping(bytes4 key1, bytes4 key2) public view {
        bytes storage derived1 = bytes4Mapping[key1];
        bytes storage derived2 = bytes4Mapping[key2];

        bytes32 baseSlot;
        bytes32 derived1Slot;
        bytes32 derived2Slot;
        assembly ("memory-safe") {
            baseSlot := bytes4Mapping.slot
            derived1Slot := derived1.slot
            derived2Slot := derived2.slot
        }

        assertEq(baseSlot.derive(key1), derived1Slot);
        assertEq(baseSlot.derive(key2), derived2Slot);

        if (key1 == key2) assertEq(derived1Slot, derived2Slot);
        else assertNotEq(derived1Slot, derived2Slot);
    }

    mapping(uint256 => bytes) internal uint256Mapping;

    function test_fuzz_derive_uint256Mapping(uint256 key) public view {
        bytes storage derived = uint256Mapping[key];

        bytes32 baseSlot;
        bytes32 derivedSlot;
        assembly ("memory-safe") {
            baseSlot := uint256Mapping.slot
            derivedSlot := derived.slot
        }

        assertEq(baseSlot.derive(key), derivedSlot);
    }

    function test_fuzz_derive_uint256Mapping(uint256 key1, uint256 key2) public view {
        bytes storage derived1 = uint256Mapping[key1];
        bytes storage derived2 = uint256Mapping[key2];

        bytes32 baseSlot;
        bytes32 derived1Slot;
        bytes32 derived2Slot;
        assembly ("memory-safe") {
            baseSlot := uint256Mapping.slot
            derived1Slot := derived1.slot
            derived2Slot := derived2.slot
        }

        assertEq(baseSlot.derive(key1), derived1Slot);
        assertEq(baseSlot.derive(key2), derived2Slot);

        if (key1 == key2) assertEq(derived1Slot, derived2Slot);
        else assertNotEq(derived1Slot, derived2Slot);
    }

    mapping(uint32 => bytes) internal uint32Mapping;

    function test_fuzz_derive_uint32Mapping(uint32 key) public view {
        bytes storage derived = uint32Mapping[key];

        bytes32 baseSlot;
        bytes32 derivedSlot;
        assembly ("memory-safe") {
            baseSlot := uint32Mapping.slot
            derivedSlot := derived.slot
        }

        assertEq(baseSlot.derive(key), derivedSlot);
    }

    function test_fuzz_derive_uint32Mapping(uint32 key1, uint32 key2) public view {
        bytes storage derived1 = uint32Mapping[key1];
        bytes storage derived2 = uint32Mapping[key2];

        bytes32 baseSlot;
        bytes32 derived1Slot;
        bytes32 derived2Slot;
        assembly ("memory-safe") {
            baseSlot := uint32Mapping.slot
            derived1Slot := derived1.slot
            derived2Slot := derived2.slot
        }

        assertEq(baseSlot.derive(key1), derived1Slot);
        assertEq(baseSlot.derive(key2), derived2Slot);

        if (key1 == key2) assertEq(derived1Slot, derived2Slot);
        else assertNotEq(derived1Slot, derived2Slot);
    }

    mapping(int256 => bytes) internal int256Mapping;

    function test_fuzz_derive_int256Mapping(int256 key) public view {
        bytes storage derived = int256Mapping[key];

        bytes32 baseSlot;
        bytes32 derivedSlot;
        assembly ("memory-safe") {
            baseSlot := int256Mapping.slot
            derivedSlot := derived.slot
        }

        assertEq(baseSlot.derive(key), derivedSlot);
    }

    function test_fuzz_derive_int256Mapping(int256 key1, int256 key2) public view {
        bytes storage derived1 = int256Mapping[key1];
        bytes storage derived2 = int256Mapping[key2];

        bytes32 baseSlot;
        bytes32 derived1Slot;
        bytes32 derived2Slot;
        assembly ("memory-safe") {
            baseSlot := int256Mapping.slot
            derived1Slot := derived1.slot
            derived2Slot := derived2.slot
        }

        assertEq(baseSlot.derive(key1), derived1Slot);
        assertEq(baseSlot.derive(key2), derived2Slot);

        if (key1 == key2) assertEq(derived1Slot, derived2Slot);
        else assertNotEq(derived1Slot, derived2Slot);
    }

    mapping(int32 => bytes) internal int32Mapping;

    function test_fuzz_derive_int32Mapping(int32 key) public view {
        bytes storage derived = int32Mapping[key];

        bytes32 baseSlot;
        bytes32 derivedSlot;
        assembly ("memory-safe") {
            baseSlot := int32Mapping.slot
            derivedSlot := derived.slot
        }

        assertEq(baseSlot.derive(key), derivedSlot);
    }

    function test_fuzz_derive_int32Mapping(int32 key1, int32 key2) public view {
        bytes storage derived1 = int32Mapping[key1];
        bytes storage derived2 = int32Mapping[key2];

        bytes32 baseSlot;
        bytes32 derived1Slot;
        bytes32 derived2Slot;
        assembly ("memory-safe") {
            baseSlot := int32Mapping.slot
            derived1Slot := derived1.slot
            derived2Slot := derived2.slot
        }

        assertEq(baseSlot.derive(key1), derived1Slot);
        assertEq(baseSlot.derive(key2), derived2Slot);

        if (key1 == key2) assertEq(derived1Slot, derived2Slot);
        else assertNotEq(derived1Slot, derived2Slot);
    }

    mapping(bytes => bytes) internal bytesMapping;

    function test_fuzz_derive_bytesMapping(bytes memory key) public view {
        bytes storage derived = bytesMapping[key];

        bytes32 baseSlot;
        bytes32 derivedSlot;
        assembly ("memory-safe") {
            baseSlot := bytesMapping.slot
            derivedSlot := derived.slot
        }

        assertEq(baseSlot.derive(key), derivedSlot);
    }

    function test_fuzz_derive_bytesMapping(bytes memory key1, bytes memory key2) public view {
        bytes storage derived1 = bytesMapping[key1];
        bytes storage derived2 = bytesMapping[key2];

        bytes32 baseSlot;
        bytes32 derived1Slot;
        bytes32 derived2Slot;
        assembly ("memory-safe") {
            baseSlot := bytesMapping.slot
            derived1Slot := derived1.slot
            derived2Slot := derived2.slot
        }

        assertEq(baseSlot.derive(key1), derived1Slot);
        assertEq(baseSlot.derive(key2), derived2Slot);

        if (keccak256(key1) == keccak256(key2)) assertEq(derived1Slot, derived2Slot);
        else assertNotEq(derived1Slot, derived2Slot);
    }

    mapping(string => bytes) internal stringMapping;

    function test_fuzz_derive_stringMapping(string memory key) public view {
        bytes storage derived = stringMapping[key];

        bytes32 baseSlot;
        bytes32 derivedSlot;
        assembly ("memory-safe") {
            baseSlot := stringMapping.slot
            derivedSlot := derived.slot
        }

        assertEq(baseSlot.derive(key), derivedSlot);
    }

    function test_fuzz_derive_stringMapping(string memory key1, string memory key2) public view {
        bytes storage derived1 = stringMapping[key1];
        bytes storage derived2 = stringMapping[key2];

        bytes32 baseSlot;
        bytes32 derived1Slot;
        bytes32 derived2Slot;
        assembly ("memory-safe") {
            baseSlot := stringMapping.slot
            derived1Slot := derived1.slot
            derived2Slot := derived2.slot
        }

        assertEq(baseSlot.derive(key1), derived1Slot);
        assertEq(baseSlot.derive(key2), derived2Slot);

        if (keccak256(bytes(key1)) == keccak256(bytes(key2))) assertEq(derived1Slot, derived2Slot);
        else assertNotEq(derived1Slot, derived2Slot);
    }
}
