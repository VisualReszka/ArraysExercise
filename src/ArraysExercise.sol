// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract ArraysExercise {
    uint256[] private numbers;
    address[] private senders;
    uint256[] private timestamps;

    constructor() {
        resetNumbers();
    }

    function getNumbers() external view returns (uint256[] memory) {
        return numbers;
    }

    function resetNumbers() public {
        delete numbers;
        for (uint256 i = 1; i <= 10; i++) {
            numbers.push(i);
        }
    }

    function appendToNumbers(uint256[] calldata newNumbers) external {
        for (uint256 i = 0; i < newNumbers.length; i++) {
            numbers.push(newNumbers[i]);
        }
    }

    function saveTimestamp(uint256 timestamp) external {
        senders.push(msg.sender);
        timestamps.push(timestamp);
    }

    function afterY2K() external view returns (uint256[] memory, address[] memory) {
        uint256 count = 0;
        for (uint256 i = 0; i < timestamps.length; i++) {
            if (timestamps[i] > 946702800) {
                count++;
            }
        }

        uint256[] memory filteredTimestamps = new uint256[](count);
        address[] memory filteredSenders = new address[](count);

        uint256 index = 0;
        for (uint256 i = 0; i < timestamps.length; i++) {
            if (timestamps[i] > 946702800) {
                filteredTimestamps[index] = timestamps[i];
                filteredSenders[index] = senders[i];
                index++;
            }
        }

        return (filteredTimestamps, filteredSenders);
    }

    function resetSenders() external {
        delete senders;
    }

    function resetTimestamps() external {
        delete timestamps;
    }
}