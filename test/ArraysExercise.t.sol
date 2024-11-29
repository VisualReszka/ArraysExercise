/// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/ArraysExercise.sol";

contract ArraysExerciseTest is Test {
    ArraysExercise public arraysExercise;

    function setUp() public {
        // Deploy the ArraysExercise contract
        arraysExercise = new ArraysExercise();
    }

    function testInitialNumbers() public {
        // Get the initial numbers array
        uint256[] memory numbers = arraysExercise.getNumbers();

        // Assert the array length is correct
        assertEq(numbers.length, 10, "Initial array should have 10 elements");

        // Assert each element is correct
        for (uint256 i = 0; i < numbers.length; i++) {
            assertEq(numbers[i], i + 1, string(abi.encodePacked("Element ", vm.toString(i), " mismatch")));
        }
    }

    function testResetNumbers() public {
        // Declare and initialise `toAppend` array
        uint256[] memory toAppend = new uint256[](2);
        toAppend[0] = 99;
        toAppend[1] = 100;

        // Append numbers to modify the array
        arraysExercise.appendToNumbers(toAppend);

        // Reset the array to its original state
        arraysExercise.resetNumbers();

        // Retrieve the reset array
        uint256[] memory numbers = arraysExercise.getNumbers();

        // Assert the array length is back to 10
        assertEq(numbers.length, 10, "Array should be reset to 10 elements");

        // Assert each element is correct
        for (uint256 i = 0; i < numbers.length; i++) {
            assertEq(numbers[i], i + 1, string(abi.encodePacked("Reset element ", vm.toString(i), " mismatch")));
        }
    }

    function testAppendToNumbers() public {
        // Declare and initialise `toAppend` array
        uint256[] memory toAppend = new uint256[](2);
        toAppend[0] = 11;
        toAppend[1] = 12;

        // Append the numbers
        arraysExercise.appendToNumbers(toAppend);

        // Retrieve the updated numbers array
        uint256[] memory numbers = arraysExercise.getNumbers();

        // Assert the array length is 12
        assertEq(numbers.length, 12, "Array should have 12 elements after appending");

        // Assert the appended values are correct
        assertEq(numbers[10], 11, "First appended number should be 11");
        assertEq(numbers[11], 12, "Second appended number should be 12");
    }

    function testSaveTimestamp() public {
        // Save a timestamp
        uint256 timestamp = 946702801; // Ensure it's after Y2K
        arraysExercise.saveTimestamp(timestamp);

        // Retrieve the filtered timestamps and senders
        (uint256[] memory timestamps, address[] memory senders) = arraysExercise.afterY2K();

        // Assert the length of filtered timestamps is 1
        assertEq(timestamps.length, 1, "Should have one timestamp");

        // Assert the timestamp and sender are correct
        assertEq(timestamps[0], timestamp, "Saved timestamp should match");
        assertEq(senders.length, 1, "Should have one sender");
        assertEq(senders[0], address(this), "Sender should be the current address");
    }

    function testAfterY2K() public {
        // Save timestamps before and after Y2K
        uint256 beforeY2K = 946702799;
        uint256 afterY2K = 946702801;

        arraysExercise.saveTimestamp(beforeY2K);
        arraysExercise.saveTimestamp(afterY2K);

        // Retrieve the filtered timestamps
        (uint256[] memory timestamps,) = arraysExercise.afterY2K();

        // Assert only one timestamp is included after Y2K
        assertEq(timestamps.length, 1, "Should have one timestamp after Y2K");
        assertEq(timestamps[0], afterY2K, "Should only include timestamp after Y2K");
    }

    function testResetSendersAndTimestamps() public {
        // Save a timestamp
        arraysExercise.saveTimestamp(block.timestamp);

        // Reset senders and timestamps
        arraysExercise.resetSenders();
        arraysExercise.resetTimestamps();

        // Retrieve the filtered data
        (uint256[] memory timestamps, address[] memory senders) = arraysExercise.afterY2K();

        // Assert both arrays are empty
        assertEq(timestamps.length, 0, "Timestamps should be reset");
        assertEq(senders.length, 0, "Senders should be reset");
    }
}
