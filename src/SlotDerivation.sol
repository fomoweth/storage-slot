// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

/// @title SlotDerivation
/// @notice Library for computing storage locations from namespaces and deriving slots corresponding to standard patterns
/// @dev Modified from https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/SlotDerivation.sol
library SlotDerivation {
	/// @notice Derives an ERC-7201 slot from a string `namespace`
	function erc7201Slot(string memory namespace) internal pure returns (uint256 slot) {
		assembly ("memory-safe") {
			mstore(0x00, sub(keccak256(add(namespace, 0x20), mload(namespace)), 0x01))
			slot := and(keccak256(0x00, 0x20), not(0xff))
		}
	}

	/// @notice Adds an offset to a slot to get the n-th element of a structure or an array
	function offset(uint256 slot, uint256 pos) internal pure returns (uint256) {
		unchecked {
			return slot + pos;
		}
	}

	/// @notice Derives the location of the first element in an array from the slot where the length is stored
	function derive(uint256 slot) internal pure returns (uint256 result) {
		assembly ("memory-safe") {
			mstore(0x00, slot)
			result := keccak256(0x00, 0x20)
		}
	}

	/// @notice Derives the location of a mapping element from the key
	function derive(uint256 slot, address key) internal pure returns (uint256 result) {
		assembly ("memory-safe") {
			mstore(0x00, shr(0x60, shl(0x60, key)))
			mstore(0x20, slot)
			result := keccak256(0x00, 0x40)
		}
	}

	/// @notice Derives the location of a mapping element from the key
	function derive(uint256 slot, bool key) internal pure returns (uint256 result) {
		assembly ("memory-safe") {
			mstore(0x00, iszero(iszero(key)))
			mstore(0x20, slot)
			result := keccak256(0x00, 0x40)
		}
	}

	/// @notice Derives the location of a mapping element from the key
	function derive(uint256 slot, bytes32 key) internal pure returns (uint256 result) {
		assembly ("memory-safe") {
			mstore(0x00, key)
			mstore(0x20, slot)
			result := keccak256(0x00, 0x40)
		}
	}

	/// @notice Derives the location of a mapping element from the key
	function derive(uint256 slot, uint256 key) internal pure returns (uint256 result) {
		assembly ("memory-safe") {
			mstore(0x00, key)
			mstore(0x20, slot)
			result := keccak256(0x00, 0x40)
		}
	}

	/// @notice Derives the location of a mapping element from the key
	function derive(uint256 slot, int256 key) internal pure returns (uint256 result) {
		assembly ("memory-safe") {
			mstore(0x00, key)
			mstore(0x20, slot)
			result := keccak256(0x00, 0x40)
		}
	}

	/// @notice Derives the location of a mapping element from the key
	function derive(uint256 slot, string memory key) internal pure returns (uint256 result) {
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
	function derive(uint256 slot, bytes memory key) internal pure returns (uint256 result) {
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
