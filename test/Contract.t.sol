// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/Contract.sol";

contract TestContract is Test {
    StakingContract c;

    function setUp() public {
        c = new StakingContract();
    }

    function testStake() public {
        uint value = 10 ether;
        c.stake{value: value}(value);

        assert(c.totalStake() == value);
    }

    function testFailStake() public {
        uint value = 10 ether;
        c.stake(value);

        assert(c.totalStake() == value);
    }

    function testUnstake() public {
        uint value = 10 ether;
        vm.startPrank(0x9af180F5bBe5592b7c51D952f75f56125Bde9718);
        vm.deal(0x9af180F5bBe5592b7c51D952f75f56125Bde9718, value);
        c.stake{value: value}(value);
        c.unstake(value);

        assert(c.totalStake() == 0);
    }
}
