// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/StakingContract.sol";

contract StakingContractTest is Test {
    StakingContract stakingContract;

    function setUp() public {
        stakingContract = new StakingContract();
    }

    function testStake() public {
        stakingContract.stake{value: 200}();
        assert(stakingContract.balanceOf(address(this)) == 200);
    }

    function testUnstake() public {
        vm.startPrank(0x9af180F5bBe5592b7c51D952f75f56125Bde9718);
        vm.deal(0x9af180F5bBe5592b7c51D952f75f56125Bde9718, 200);
        stakingContract.stake{value: 200}();
        stakingContract.unStake(100);
        assert(
            stakingContract.balanceOf(
                0x9af180F5bBe5592b7c51D952f75f56125Bde9718
            ) == 100
        );
    }

    function testFailUnstake() public {
        stakingContract.stake{value: 200}();
        stakingContract.unStake(300);
    }
}
