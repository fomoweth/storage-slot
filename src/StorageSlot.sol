// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

type AddressSlot is uint256;
type BooleanSlot is uint256;
type Bytes32Slot is uint256;
type Uint256Slot is uint256;
type Int256Slot is uint256;
type BytesSlot is uint256;
type StringSlot is uint256;

using StorageSlot for AddressSlot global;
using StorageSlot for BooleanSlot global;
using StorageSlot for Bytes32Slot global;
using StorageSlot for Uint256Slot global;
using StorageSlot for Int256Slot global;
using StorageSlot for BytesSlot global;
using StorageSlot for StringSlot global;

/// @title StorageSlot
/// @notice Provides type-safe storage operations for both persistent and transient storage
library StorageSlot {
	/// @notice Thrown when attempting to store a dynamic value (bytes/string) exceeding 2³² - 1 bytes
	error ExceededMaxDataLength();

	uint256 internal constant DATA_CAPACITY = 0x1c;
	uint256 internal constant LENGTH_MASK = 0xffffffff;
	uint256 internal constant LENGTH_SIZE = 0x04;
	uint256 internal constant LENGTH_SHIFT = 0xe0;

	/// @notice Converts uint256 to AddressSlot type
	function asAddressSlot(uint256 slot) internal pure returns (AddressSlot) {
		return AddressSlot.wrap(slot);
	}

	/// @notice Converts bytes32 to AddressSlot type
	function asAddressSlot(bytes32 slot) internal pure returns (AddressSlot) {
		return AddressSlot.wrap(uint256(slot));
	}

	/// @notice Converts AddressSlot back to uint256
	function asUint256(AddressSlot slot) internal pure returns (uint256) {
		return AddressSlot.unwrap(slot);
	}

	/// @notice Converts AddressSlot to bytes32
	function asBytes32(AddressSlot slot) internal pure returns (bytes32) {
		return bytes32(AddressSlot.unwrap(slot));
	}

	/// @notice Loads an address value from persistent storage
	function sload(AddressSlot slot) internal view returns (address result) {
		assembly ("memory-safe") {
			result := sload(slot)
		}
	}

	/// @notice Stores an address value to persistent storage
	function sstore(AddressSlot slot, address value) internal {
		assembly ("memory-safe") {
			sstore(slot, shr(0x60, shl(0x60, value)))
		}
	}

	/// @notice Loads an address value from transient storage
	function tload(AddressSlot slot) internal view returns (address result) {
		assembly ("memory-safe") {
			result := tload(slot)
		}
	}

	/// @notice Stores an address value to transient storage
	function tstore(AddressSlot slot, address value) internal {
		assembly ("memory-safe") {
			tstore(slot, shr(0x60, shl(0x60, value)))
		}
	}

	/// @notice Clears the transient storage slot to zero
	function tclear(AddressSlot slot) internal {
		assembly ("memory-safe") {
			tstore(slot, 0x00)
		}
	}

	/// @notice Converts uint256 to BooleanSlot type
	function asBooleanSlot(uint256 slot) internal pure returns (BooleanSlot) {
		return BooleanSlot.wrap(slot);
	}

	/// @notice Converts bytes32 to BooleanSlot type
	function asBooleanSlot(bytes32 slot) internal pure returns (BooleanSlot) {
		return BooleanSlot.wrap(uint256(slot));
	}

	/// @notice Converts BooleanSlot back to uint256
	function asUint256(BooleanSlot slot) internal pure returns (uint256) {
		return BooleanSlot.unwrap(slot);
	}

	/// @notice Converts BooleanSlot to bytes32
	function asBytes32(BooleanSlot slot) internal pure returns (bytes32) {
		return bytes32(BooleanSlot.unwrap(slot));
	}

	/// @notice Loads a boolean value from persistent storage
	function sload(BooleanSlot slot) internal view returns (bool result) {
		assembly ("memory-safe") {
			result := sload(slot)
		}
	}

	/// @notice Stores a boolean value to persistent storage
	function sstore(BooleanSlot slot, bool value) internal {
		assembly ("memory-safe") {
			sstore(slot, iszero(iszero(value)))
		}
	}

	/// @notice Loads a boolean value from transient storage
	function tload(BooleanSlot slot) internal view returns (bool result) {
		assembly ("memory-safe") {
			result := tload(slot)
		}
	}

	/// @notice Stores a boolean value to transient storage
	function tstore(BooleanSlot slot, bool value) internal {
		assembly ("memory-safe") {
			tstore(slot, iszero(iszero(value)))
		}
	}

	/// @notice Clears the transient storage slot to zero
	function tclear(BooleanSlot slot) internal {
		assembly ("memory-safe") {
			tstore(slot, 0x00)
		}
	}

	/// @notice Converts uint256 to Bytes32Slot type
	function asBytes32Slot(uint256 slot) internal pure returns (Bytes32Slot) {
		return Bytes32Slot.wrap(slot);
	}

	/// @notice Converts bytes32 to Bytes32Slot type
	function asBytes32Slot(bytes32 slot) internal pure returns (Bytes32Slot) {
		return Bytes32Slot.wrap(uint256(slot));
	}

	/// @notice Converts Bytes32Slot back to uint256
	function asUint256(Bytes32Slot slot) internal pure returns (uint256) {
		return Bytes32Slot.unwrap(slot);
	}

	/// @notice Converts Bytes32Slot to bytes32
	function asBytes32(Bytes32Slot slot) internal pure returns (bytes32) {
		return bytes32(Bytes32Slot.unwrap(slot));
	}

	/// @notice Loads a bytes32 value from persistent storage
	function sload(Bytes32Slot slot) internal view returns (bytes32 result) {
		assembly ("memory-safe") {
			result := sload(slot)
		}
	}

	/// @notice Stores a bytes32 value to persistent storage
	function sstore(Bytes32Slot slot, bytes32 value) internal {
		assembly ("memory-safe") {
			sstore(slot, value)
		}
	}

	/// @notice Loads a bytes32 value from transient storage
	function tload(Bytes32Slot slot) internal view returns (bytes32 result) {
		assembly ("memory-safe") {
			result := tload(slot)
		}
	}

	/// @notice Stores a bytes32 value to transient storage
	function tstore(Bytes32Slot slot, bytes32 value) internal {
		assembly ("memory-safe") {
			tstore(slot, value)
		}
	}

	/// @notice Clears the transient storage slot to zero
	function tclear(Bytes32Slot slot) internal {
		assembly ("memory-safe") {
			tstore(slot, 0x00)
		}
	}

	/// @notice Converts uint256 to Uint256Slot type
	function asUint256Slot(uint256 slot) internal pure returns (Uint256Slot) {
		return Uint256Slot.wrap(slot);
	}

	/// @notice Converts bytes32 to Uint256Slot type
	function asUint256Slot(bytes32 slot) internal pure returns (Uint256Slot) {
		return Uint256Slot.wrap(uint256(slot));
	}

	/// @notice Converts Uint256Slot back to uint256
	function asUint256(Uint256Slot slot) internal pure returns (uint256) {
		return Uint256Slot.unwrap(slot);
	}

	/// @notice Converts Uint256Slot to bytes32
	function asBytes32(Uint256Slot slot) internal pure returns (bytes32) {
		return bytes32(Uint256Slot.unwrap(slot));
	}

	/// @notice Loads an uint256 value from persistent storage
	function sload(Uint256Slot slot) internal view returns (uint256 result) {
		assembly ("memory-safe") {
			result := sload(slot)
		}
	}

	/// @notice Stores an uint256 value to persistent storage
	function sstore(Uint256Slot slot, uint256 value) internal {
		assembly ("memory-safe") {
			sstore(slot, value)
		}
	}

	/// @notice Loads an uint256 value from transient storage
	function tload(Uint256Slot slot) internal view returns (uint256 result) {
		assembly ("memory-safe") {
			result := tload(slot)
		}
	}

	/// @notice Stores an uint256 value to transient storage
	function tstore(Uint256Slot slot, uint256 value) internal {
		assembly ("memory-safe") {
			tstore(slot, value)
		}
	}

	/// @notice Clears the transient storage slot to zero
	function tclear(Uint256Slot slot) internal {
		assembly ("memory-safe") {
			tstore(slot, 0x00)
		}
	}

	/// @notice Converts uint256 to Int256Slot type
	function asInt256Slot(uint256 slot) internal pure returns (Int256Slot) {
		return Int256Slot.wrap(slot);
	}

	/// @notice Converts bytes32 to Int256Slot type
	function asInt256Slot(bytes32 slot) internal pure returns (Int256Slot) {
		return Int256Slot.wrap(uint256(slot));
	}

	/// @notice Converts Int256Slot back to uint256
	function asUint256(Int256Slot slot) internal pure returns (uint256) {
		return Int256Slot.unwrap(slot);
	}

	/// @notice Converts Int256Slot to bytes32
	function asBytes32(Int256Slot slot) internal pure returns (bytes32) {
		return bytes32(Int256Slot.unwrap(slot));
	}

	/// @notice Loads an int256 value from persistent storage
	function sload(Int256Slot slot) internal view returns (int256 result) {
		assembly ("memory-safe") {
			result := sload(slot)
		}
	}

	/// @notice Stores an int256 value to persistent storage
	function sstore(Int256Slot slot, int256 value) internal {
		assembly ("memory-safe") {
			sstore(slot, value)
		}
	}

	/// @notice Loads an int256 value from transient storage
	function tload(Int256Slot slot) internal view returns (int256 result) {
		assembly ("memory-safe") {
			result := tload(slot)
		}
	}

	/// @notice Stores an int256 value to transient storage
	function tstore(Int256Slot slot, int256 value) internal {
		assembly ("memory-safe") {
			tstore(slot, value)
		}
	}

	/// @notice Clears the transient storage slot to zero
	function tclear(Int256Slot slot) internal {
		assembly ("memory-safe") {
			tstore(slot, 0x00)
		}
	}

	/// @notice Converts uint256 to BytesSlot type
	function asBytesSlot(uint256 slot) internal pure returns (BytesSlot) {
		return BytesSlot.wrap(slot);
	}

	/// @notice Converts bytes32 to BytesSlot type
	function asBytesSlot(bytes32 slot) internal pure returns (BytesSlot) {
		return BytesSlot.wrap(uint256(slot));
	}

	/// @notice Converts BytesSlot back to uint256
	function asUint256(BytesSlot slot) internal pure returns (uint256) {
		return BytesSlot.unwrap(slot);
	}

	/// @notice Converts BytesSlot to bytes32
	function asBytes32(BytesSlot slot) internal pure returns (bytes32) {
		return bytes32(BytesSlot.unwrap(slot));
	}

	/// @notice Returns only the length field of a bytes value from persistent storage
	function slength(BytesSlot slot) internal view returns (uint256 length) {
		assembly ("memory-safe") {
			length := shr(LENGTH_SHIFT, sload(slot))
		}
	}

	/// @notice Loads a bytes value from persistent storage
	function sload(BytesSlot slot) internal view returns (bytes memory result) {
		assembly ("memory-safe") {
			result := mload(0x40)
			mstore(result, 0x00)
			mstore(add(result, DATA_CAPACITY), sload(slot))

			let length := mload(result)
			let offset := add(result, 0x20)
			let guard := add(offset, length)
			mstore(0x40, guard)

			if gt(length, DATA_CAPACITY) {
				mstore(0x00, slot)
				slot := keccak256(0x00, 0x20)
				offset := add(offset, DATA_CAPACITY)

				// prettier-ignore
				for {} 0x01 {} {
					mstore(offset, sload(slot))
					offset := add(offset, 0x20)
					if gt(offset, guard) { break }
					slot := add(slot, 0x01)
				}

				mstore(guard, 0x00)
			}
		}
	}

	/// @notice Stores a bytes value to persistent storage
	function sstore(BytesSlot slot, bytes memory data) internal {
		assembly ("memory-safe") {
			let length := mload(data)
			if gt(length, LENGTH_MASK) {
				mstore(0x00, 0x06045ade) // ExceededMaxDataLength()
				revert(0x1c, 0x04)
			}

			let offset := add(data, 0x20)
			sstore(slot, mload(sub(offset, LENGTH_SIZE)))

			if gt(length, DATA_CAPACITY) {
				mstore(0x00, slot)
				slot := keccak256(0x00, 0x20)

				let guard := sub(add(offset, length), 0x01)
				offset := add(offset, DATA_CAPACITY)

				// prettier-ignore
				for {} 0x01 {} {
					sstore(slot, mload(offset))
					offset := add(offset, 0x20)
					if gt(offset, guard) { break }
					slot := add(slot, 0x01)
				}
			}
		}
	}

	/// @notice Returns only the length field of a bytes value from transient storage
	function tlength(BytesSlot slot) internal view returns (uint256 length) {
		assembly ("memory-safe") {
			length := shr(LENGTH_SHIFT, tload(slot))
		}
	}

	/// @notice Loads a bytes value from transient storage
	function tload(BytesSlot slot) internal view returns (bytes memory result) {
		assembly ("memory-safe") {
			result := mload(0x40)
			mstore(result, 0x00)
			mstore(add(result, DATA_CAPACITY), tload(slot))

			let length := mload(result)
			let offset := add(result, 0x20)
			let guard := add(offset, length)
			mstore(0x40, guard)

			if gt(length, DATA_CAPACITY) {
				mstore(0x00, slot)
				slot := keccak256(0x00, 0x20)
				offset := add(offset, DATA_CAPACITY)

				// prettier-ignore
				for {} 0x01 {} {
					mstore(offset, tload(slot))
					offset := add(offset, 0x20)
					if gt(offset, guard) { break }
					slot := add(slot, 0x01)
				}

				mstore(guard, 0x00)
			}
		}
	}

	/// @notice Stores a bytes value to transient storage
	function tstore(BytesSlot slot, bytes memory data) internal {
		assembly ("memory-safe") {
			let length := mload(data)
			if gt(length, LENGTH_MASK) {
				mstore(0x00, 0x06045ade) // ExceededMaxDataLength()
				revert(0x1c, 0x04)
			}

			let offset := add(data, 0x20)
			tstore(slot, mload(sub(offset, LENGTH_SIZE)))

			if gt(length, DATA_CAPACITY) {
				mstore(0x00, slot)
				slot := keccak256(0x00, 0x20)

				let guard := sub(add(offset, length), 0x01)
				offset := add(offset, DATA_CAPACITY)

				// prettier-ignore
				for {} 0x01 {} {
					tstore(slot, mload(offset))
					offset := add(offset, 0x20)
					if gt(offset, guard) { break }
					slot := add(slot, 0x01)
				}
			}
		}
	}

	/// @notice Clears the transient storage slot to zero
	function tclear(BytesSlot slot) internal {
		assembly ("memory-safe") {
			tstore(slot, 0x00)
		}
	}

	/// @notice Converts uint256 to StringSlot type
	function asStringSlot(uint256 slot) internal pure returns (StringSlot) {
		return StringSlot.wrap(slot);
	}

	/// @notice Converts bytes32 to StringSlot type
	function asStringSlot(bytes32 slot) internal pure returns (StringSlot) {
		return StringSlot.wrap(uint256(slot));
	}

	/// @notice Converts StringSlot back to uint256
	function asUint256(StringSlot slot) internal pure returns (uint256) {
		return StringSlot.unwrap(slot);
	}

	/// @notice Converts StringSlot to bytes32
	function asBytes32(StringSlot slot) internal pure returns (bytes32) {
		return bytes32(StringSlot.unwrap(slot));
	}

	/// @notice Returns only the length field of a string value from persistent storage
	function slength(StringSlot slot) internal view returns (uint256 length) {
		assembly ("memory-safe") {
			length := shr(LENGTH_SHIFT, sload(slot))
		}
	}

	/// @notice Loads a string value from persistent storage
	function sload(StringSlot slot) internal view returns (string memory result) {
		assembly ("memory-safe") {
			result := mload(0x40)
			mstore(result, 0x00)
			mstore(add(result, DATA_CAPACITY), sload(slot))

			let length := mload(result)
			let offset := add(result, 0x20)
			let guard := add(offset, length)
			mstore(0x40, guard)

			if gt(length, DATA_CAPACITY) {
				mstore(0x00, slot)
				slot := keccak256(0x00, 0x20)
				offset := add(offset, DATA_CAPACITY)

				// prettier-ignore
				for {} 0x01 {} {
					mstore(offset, sload(slot))
					offset := add(offset, 0x20)
					if gt(offset, guard) { break }
					slot := add(slot, 0x01)
				}

				mstore(guard, 0x00)
			}
		}
	}

	/// @notice Stores a string value to persistent storage
	function sstore(StringSlot slot, string memory data) internal {
		assembly ("memory-safe") {
			let length := mload(data)
			if gt(length, LENGTH_MASK) {
				mstore(0x00, 0x06045ade) // ExceededMaxDataLength()
				revert(0x1c, 0x04)
			}

			let offset := add(data, 0x20)
			sstore(slot, mload(sub(offset, LENGTH_SIZE)))

			if gt(length, DATA_CAPACITY) {
				mstore(0x00, slot)
				slot := keccak256(0x00, 0x20)

				let guard := sub(add(offset, length), 0x01)
				offset := add(offset, DATA_CAPACITY)

				// prettier-ignore
				for {} 0x01 {} {
					sstore(slot, mload(offset))
					offset := add(offset, 0x20)
					if gt(offset, guard) { break }
					slot := add(slot, 0x01)
				}
			}
		}
	}

	/// @notice Returns only the length field of a string value from transient storage
	function tlength(StringSlot slot) internal view returns (uint256 length) {
		assembly ("memory-safe") {
			length := shr(LENGTH_SHIFT, tload(slot))
		}
	}

	/// @notice Loads a string value from transient storage
	function tload(StringSlot slot) internal view returns (string memory result) {
		assembly ("memory-safe") {
			result := mload(0x40)
			mstore(result, 0x00)
			mstore(add(result, DATA_CAPACITY), tload(slot))

			let length := mload(result)
			let offset := add(result, 0x20)
			let guard := add(offset, length)
			mstore(0x40, guard)

			if gt(length, DATA_CAPACITY) {
				mstore(0x00, slot)
				slot := keccak256(0x00, 0x20)
				offset := add(offset, DATA_CAPACITY)

				// prettier-ignore
				for {} 0x01 {} {
					mstore(offset, tload(slot))
					offset := add(offset, 0x20)
					if gt(offset, guard) { break }
					slot := add(slot, 0x01)
				}

				mstore(guard, 0x00)
			}
		}
	}

	/// @notice Stores a string value to transient storage
	function tstore(StringSlot slot, string memory data) internal {
		assembly ("memory-safe") {
			let length := mload(data)
			if gt(length, LENGTH_MASK) {
				mstore(0x00, 0x06045ade) // ExceededMaxDataLength()
				revert(0x1c, 0x04)
			}

			let offset := add(data, 0x20)
			tstore(slot, mload(sub(offset, LENGTH_SIZE)))

			if gt(length, DATA_CAPACITY) {
				mstore(0x00, slot)
				slot := keccak256(0x00, 0x20)

				let guard := sub(add(offset, length), 0x01)
				offset := add(offset, DATA_CAPACITY)

				// prettier-ignore
				for {} 0x01 {} {
					tstore(slot, mload(offset))
					offset := add(offset, 0x20)
					if gt(offset, guard) { break }
					slot := add(slot, 0x01)
				}
			}
		}
	}

	/// @notice Clears the transient storage slot to zero
	function tclear(StringSlot slot) internal {
		assembly ("memory-safe") {
			tstore(slot, 0x00)
		}
	}
}
