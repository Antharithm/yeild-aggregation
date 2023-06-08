// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

// Deposit and Withdraw from AAVE & Compound
// Must have functions called:
// deposit
// rebalance
// withdraw

// APY Rates are determinded before Depositing and Rebalancing - use JS
// Fork mainnet with Alchemy, deploy locally and point to mainnet
// Demo locally with forked mainnet

// Bonus:
// emit events and fail catch test cases

import "./IERC20.sol";
import "./ICompound.sol";
import "./IAave.sol";

contract YieldAggregator {
    struct UserBalance {
        uint256 amount;
        uint256 lastUpdated;
    }

    mapping(address => UserBalance) private balances;

    address private constant COMP_ADDRESS =
        address(0xc00e94Cb662C3520282E6f5717214004A7f26888);
    address private constant AAVE_ADDRESS =
        address(0x7Fc66500c84A76Ad7e9c93437bFc5Ac33E2DDaE9);

    IERC20 private constant wethToken =
        IERC20(address(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2));

    ICompound private compound;
    IAave private aave;

    constructor(address _compoundAddress, address _aaveAddress) {
        compound = ICompound(_compoundAddress);
        aave = IAave(_aaveAddress);
    }

    function deposit(uint256 amount) external {
        require(amount > 0, "Invalid amount");

        wethToken.transferFrom(msg.sender, address(this), amount);

        balances[msg.sender].amount += amount;
        balances[msg.sender].lastUpdated = block.timestamp;
    }

    function withdraw(uint256 amount) external {
        require(amount > 0, "Invalid amount");
        require(amount <= balances[msg.sender].amount, "Insufficient balance");

        balances[msg.sender].amount -= amount;

        wethToken.transfer(msg.sender, amount);
    }

    function rebalance() external {
        uint256 compoundAPY = compound.getAPY();
        uint256 aaveAPY = aave.getAPY();

        address protocolAddress;

        if (compoundAPY > aaveAPY) {
            protocolAddress = COMP_ADDRESS;
        } else {
            protocolAddress = AAVE_ADDRESS;
        }

        uint256 currentBalance = balances[msg.sender].amount;
        uint256 updatedBalance = (currentBalance *
            (protocolAddress == COMP_ADDRESS ? compoundAPY : aaveAPY)) / 100;

        balances[msg.sender].amount = updatedBalance;
        balances[msg.sender].lastUpdated = block.timestamp;
    }

    function getBalance(address user) external view returns (uint256) {
        return balances[user].amount;
    }

    function getLastUpdated(address user) external view returns (uint256) {
        return balances[user].lastUpdated;
    }
}
