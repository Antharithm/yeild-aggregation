// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

interface ICompound {
    function getAPY() external view returns (uint256);
    // Add any other required functions from the Compound protocol
}