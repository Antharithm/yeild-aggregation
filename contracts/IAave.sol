// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

interface IAave {
    function getReserveData(address asset) external view returns (uint256); // APY
    // Add any other required functions from the Aave protocol
}