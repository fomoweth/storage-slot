// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Test} from "forge-std/Test.sol";
import {StorageSlot, AddressSlot, BooleanSlot, Bytes32Slot, Uint256Slot, Int256Slot, BytesSlot, StringSlot} from "src/StorageSlot.sol";
import {SlotDerivation} from "src/SlotDerivation.sol";

contract StorageSlotTest is Test {
	using StorageSlot for uint256;
	using SlotDerivation for uint256;

	AddressSlot internal immutable ADDRESS_SLOT = SlotDerivation.erc7201Slot("ADDRESS_SLOT").asAddressSlot();
	BooleanSlot internal immutable BOOLEAN_SLOT = SlotDerivation.erc7201Slot("BOOLEAN_SLOT").asBooleanSlot();
	Bytes32Slot internal immutable BYTES32_SLOT = SlotDerivation.erc7201Slot("BYTES32_SLOT").asBytes32Slot();
	Uint256Slot internal immutable UINT256_SLOT = SlotDerivation.erc7201Slot("UINT256_SLOT").asUint256Slot();
	Int256Slot internal immutable INT256_SLOT = SlotDerivation.erc7201Slot("INT256_SLOT").asInt256Slot();
	BytesSlot internal immutable BYTES_SLOT = SlotDerivation.erc7201Slot("BYTES_SLOT").asBytesSlot();
	StringSlot internal immutable STRING_SLOT = SlotDerivation.erc7201Slot("STRING_SLOT").asStringSlot();

	function test_fuzz_persistent_storage_address(address x) public {
		assertEq(ADDRESS_SLOT.sload(), address(0));
		assertStorageSlot(x, false);
	}

	function test_fuzz_persistent_storage_boolean(bool x) public {
		assertFalse(BOOLEAN_SLOT.sload());
		assertStorageSlot(x, false);
	}

	function test_fuzz_persistent_storage_bytes32(bytes32 x) public {
		assertEq(BYTES32_SLOT.sload(), bytes32(0));
		assertStorageSlot(x, false);
	}

	function test_fuzz_persistent_storage_uint256(uint256 x) public {
		assertEq(UINT256_SLOT.sload(), uint256(0));
		assertStorageSlot(x, false);
	}

	function test_fuzz_persistent_storage_int256(int256 x) public {
		assertEq(INT256_SLOT.sload(), int256(0));
		assertStorageSlot(x, false);
	}

	function test_fuzz_persistent_storage_bytes(bytes memory x) public {
		assertEq(BYTES_SLOT.slength(), uint256(0));
		assertStorageSlot(x, false);
	}

	function test_fuzz_persistent_storage_string(string memory x) public {
		assertEq(STRING_SLOT.slength(), uint256(0));
		assertStorageSlot(x, false);
	}

	function test_fuzz_transient_storage_address(address x) public {
		assertEq(ADDRESS_SLOT.tload(), address(0));
		assertStorageSlot(x, true);
		assertAddressSlotClear();
	}

	function test_fuzz_transient_storage_boolean(bool x) public {
		assertFalse(BOOLEAN_SLOT.tload());
		assertStorageSlot(x, true);
		assertBooleanSlotClear();
	}

	function test_fuzz_transient_storage_bytes32(bytes32 x) public {
		assertEq(BYTES32_SLOT.tload(), bytes32(0));
		assertStorageSlot(x, true);
		assertBytes32SlotClear();
	}

	function test_fuzz_transient_storage_uint256(uint256 x) public {
		assertEq(UINT256_SLOT.tload(), uint256(0));
		assertStorageSlot(x, true);
		assertUint256SlotClear();
	}

	function test_fuzz_transient_storage_int256(int256 x) public {
		assertEq(INT256_SLOT.tload(), int256(0));
		assertStorageSlot(x, true);
		assertInt256SlotClear();
	}

	function test_fuzz_transient_storage_bytes(bytes memory x) public {
		assertEq(BYTES_SLOT.tlength(), uint256(0));
		assertStorageSlot(x, true);
		assertBytesSlotClear();
	}

	function test_fuzz_transient_storage_string(string memory x) public {
		assertEq(STRING_SLOT.tlength(), uint256(0));
		assertStorageSlot(x, true);
		assertStringSlotClear();
	}

	function assertStorageSlot(address x, bool isTransient) internal {
		if (isTransient) {
			ADDRESS_SLOT.tstore(x);
			assertEq(ADDRESS_SLOT.tload(), x);
		} else {
			ADDRESS_SLOT.sstore(x);
			assertEq(ADDRESS_SLOT.sload(), x);
		}
	}

	function assertStorageSlot(bool x, bool isTransient) internal {
		if (isTransient) {
			BOOLEAN_SLOT.tstore(x);
			assertEq(BOOLEAN_SLOT.tload(), x);
		} else {
			BOOLEAN_SLOT.sstore(x);
			assertEq(BOOLEAN_SLOT.sload(), x);
		}
	}

	function assertStorageSlot(bytes32 x, bool isTransient) internal {
		if (isTransient) {
			BYTES32_SLOT.tstore(x);
			assertEq(BYTES32_SLOT.tload(), x);
		} else {
			BYTES32_SLOT.sstore(x);
			assertEq(BYTES32_SLOT.sload(), x);
		}
	}

	function assertStorageSlot(uint256 x, bool isTransient) internal {
		if (isTransient) {
			UINT256_SLOT.tstore(x);
			assertEq(UINT256_SLOT.tload(), x);
		} else {
			UINT256_SLOT.sstore(x);
			assertEq(UINT256_SLOT.sload(), x);
		}
	}

	function assertStorageSlot(int256 x, bool isTransient) internal {
		if (isTransient) {
			INT256_SLOT.tstore(x);
			assertEq(INT256_SLOT.tload(), x);
		} else {
			INT256_SLOT.sstore(x);
			assertEq(INT256_SLOT.sload(), x);
		}
	}

	function assertStorageSlot(bytes memory x, bool isTransient) internal {
		if (x.length > StorageSlot.LENGTH_MASK) {
			vm.expectRevert(StorageSlot.ExceededMaxDataLength.selector);
			if (isTransient) BYTES_SLOT.tstore(x);
			else BYTES_SLOT.sstore(x);
			return;
		}

		if (isTransient) {
			BYTES_SLOT.tstore(x);
			assertEq(BYTES_SLOT.tlength(), x.length);
			assertEq(BYTES_SLOT.tload(), x);
		} else {
			BYTES_SLOT.sstore(x);
			assertEq(BYTES_SLOT.slength(), x.length);
			assertEq(BYTES_SLOT.sload(), x);
		}
	}

	function assertStorageSlot(string memory x, bool isTransient) internal {
		if (bytes(x).length > StorageSlot.LENGTH_MASK) {
			vm.expectRevert(StorageSlot.ExceededMaxDataLength.selector);
			if (isTransient) STRING_SLOT.tstore(x);
			else STRING_SLOT.sstore(x);
			return;
		}

		if (isTransient) {
			STRING_SLOT.tstore(x);
			assertEq(STRING_SLOT.tlength(), bytes(x).length);
			assertEq(STRING_SLOT.tload(), x);
		} else {
			STRING_SLOT.sstore(x);
			assertEq(STRING_SLOT.slength(), bytes(x).length);
			assertEq(STRING_SLOT.sload(), x);
		}
	}

	function assertAddressSlotClear() internal {
		ADDRESS_SLOT.tclear();
		assertEq(ADDRESS_SLOT.tload(), address(0));
	}

	function assertBooleanSlotClear() internal {
		BOOLEAN_SLOT.tclear();
		assertEq(BOOLEAN_SLOT.tload(), false);
	}

	function assertBytes32SlotClear() internal {
		BYTES32_SLOT.tclear();
		assertEq(BYTES32_SLOT.tload(), bytes32(0));
	}

	function assertUint256SlotClear() internal {
		UINT256_SLOT.tclear();
		assertEq(UINT256_SLOT.tload(), uint256(0));
	}

	function assertInt256SlotClear() internal {
		INT256_SLOT.tclear();
		assertEq(INT256_SLOT.tload(), int256(0));
	}

	function assertBytesSlotClear() internal {
		BYTES_SLOT.tclear();
		assertEq(BYTES_SLOT.tload(), new bytes(0));
	}

	function assertStringSlotClear() internal {
		STRING_SLOT.tclear();
		assertEq(STRING_SLOT.tload(), new string(0));
	}
}
