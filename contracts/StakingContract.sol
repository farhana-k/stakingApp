// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './StakingToken.sol';

contract StakingContract is StakingToken {

    struct Staker {
        uint256 stakedBalance;
        uint256 lastBlockStaked;   
        uint256 cumulativeRewards; // Cumulative rewards including compound interest
    }

    mapping(address => Staker) public stakers;

    uint256 public compoundInterestRate = 2; // 2% interest rate per 10 blocks
    uint256 public blocksPerReward = 10; // Generate rewards every 10 blocks
    uint256 public firstBlock; // timestamp of first block, to calculate average block time

    constructor() StakingToken() {
        firstBlock = block.timestamp; 
    }

    // Function to stake tokens
    function stakeTokens(uint256 _amount) public {
        require(_amount > 0, "Amount must be greater than 0");

        // Transfer tokens from the sender to this contract
        require(
            transfer( address(this), _amount),
            "Token transfer failed"
        );

        // Update the staker's data
        if (stakers[msg.sender].stakedBalance == 0) {
            // New staker, set the lastUpdatedBlock to the current block number
            stakers[msg.sender].lastBlockStaked = block.number;
        } else {
            // Existing staker, calculate and add the additional reward
            uint256 reward = calculateRewards(msg.sender);
            stakers[msg.sender].stakedBalance += reward;
            stakers[msg.sender].lastBlockStaked = block.number;
            stakers[msg.sender].cumulativeRewards += reward;
        }

        // Add the new staked amount
        stakers[msg.sender].stakedBalance += _amount;
    }

    // Function to withdraw staked tokens
    function withdrawStake() public {
        uint256 stakedAmount = stakers[msg.sender].stakedBalance;
        require(stakedAmount > 0, "No staked amount to withdraw");

        // Calculate and send the reward
        uint256 reward = calculateRewards(msg.sender);
        uint256 totalAmount = stakedAmount + reward;

        approve(msg.sender, totalAmount);
        // Transfer the total amount (staked amount + reward) to the staker
        require(
            transferFrom(address(this), msg.sender, totalAmount),
            "Token transfer failed"
        );

        // Reset the staker's data
        delete stakers[msg.sender];
    }

    // function to claim rewards
    function claimRewards() public {
        Staker storage staker = stakers[msg.sender];

        // Calculate rewards with compound interest up to the current block
        uint256 rewards = calculateRewards(msg.sender);
        staker.cumulativeRewards = staker.cumulativeRewards + rewards;

        approve(msg.sender, rewards);
        
        // Transfer rewards to the user
        require(
            transferFrom(address(this),msg.sender, rewards),
            "Token transfer failed"
        );

        staker.lastBlockStaked = block.number;
    }

    // returns staking details of a specific account / user
    function viewStakeDetails(address addr) public  view returns (  Staker memory) {
        return ( stakers[addr]) ;
    }

    // function to calculate rewards 
    function calculateRewards(address addr) public view returns (uint256) {
            if (stakers[addr].stakedBalance == 0) {
                return 0;
            }

            uint256 blocksSinceLastStake = block.number - stakers[addr].lastBlockStaked;
            uint256 rewardBlocks = blocksSinceLastStake / blocksPerReward;

            // Calculate rewards with compound interest for every 10 blocks
            uint256 rewards = stakers[addr].stakedBalance;
            for (uint256 i = 0; i < rewardBlocks; i++) {
                rewards += ( (rewards * compoundInterestRate) / 100 );
            }

            return rewards - stakers[addr].stakedBalance;
    }

    // functio to calculate estimated APY 
    function calculateAPY(uint256 amount, uint256 period) public view returns(uint256) {

            // time elapsed after first block 
            uint256 timeperiod = block.timestamp - firstBlock;

            // average block time 
            uint256 averageBlockPeriod = timeperiod / block.number;

            // no. of blocks that will be added based on average block time 
            uint256 Blocks =  period / averageBlockPeriod;

            // Calculate rewards with compound interest for every 10 blocks
            uint256 rewards = amount;
            for (uint256 i = 0; i < Blocks / 10 ; i++) {
                rewards += ( (rewards * compoundInterestRate) / 100) ;
            }

            return (rewards - amount );   
    }

    // function to check current block number
    function blockNumber() public view returns(uint256){
        return block.number;
    }
    
}

