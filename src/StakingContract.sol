// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

contract StakingContract {
    mapping(address => uint256) balances;
    mapping(address => uint256) unclaimedRewards;
    mapping(address => uint256) lastUpdateTime;

    constructor() {}

    function stake() public payable {
        require(msg.value > 0);
        if (lastUpdateTime[msg.sender] == 0) {
            lastUpdateTime[msg.sender] = block.timestamp;
        } else {
            unclaimedRewards[msg.sender] +=
                (block.timestamp - lastUpdateTime[msg.sender]) *
                balances[address];
            lastUpdateTime[msg.sender] = block.timestamp;
        }
        balances[msg.sender] += msg.value;
    }

    function unStake(uint _amount) public {
        require(_amount <= balances[msg.sender]);

        unclaimedRewards[msg.sender] +=
            (block.timestamp - lastUpdateTime[msg.sender]) *
            balances[address];
        lastUpdateTime[msg.sender] = block.timestamp;

        payable(msg.sender).transfer(_amount);
        balances[msg.sender] -= _amount;
    }

    function getRewards(address _address) public view returns (uint) {
        uint currentReward = unclaimedRewards[_address];
        uint updateTime = lastUpdateTime[_address];
        uint newReward = (block.timestamp - updateTime) * balances[address];
        return currentReward + newReward;
    }

    function claimRewards() public {
        uint currentReward = unclaimedRewards[msg.sender];
        uint updateTime = lastUpdateTime[msg.sender];
        uint newReward = (block.timestamp - updateTime) * balances[address];

        // tranfer currentReward + newReward unclamiedRewards[msg.sender] ORCA Tokens

        unclaimedRewards[msg.sender] = 0;
        lastUpdateTime[msg.sender] = block.timestamp;
    }

    function balanceOf(address _address) public view returns (uint) {
        return balances[_address];
    }
}
