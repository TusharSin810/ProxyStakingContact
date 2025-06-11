// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/OrcaCoin.sol";

contract OrcaCoinTest is Test {
    OrcaCoinContract orcaCoin;

    function setUp() public {
        orcaCoin = new OrcaCoinContract(address(this));
    }

    function testInitialSupply() public view {
        assert(orcaCoin.totalSupply() == 0);
    }

    function testFailMint() public {
        vm.startPrank(0x9af180F5bBe5592b7c51D952f75f56125Bde9718);
        orcaCoin.mint(0x9af180F5bBe5592b7c51D952f75f56125Bde9718, 10);
    }

    function testMint() public {
        orcaCoin.mint(0x9af180F5bBe5592b7c51D952f75f56125Bde9718, 10);
        assert(
            orcaCoin.balanceOf(0x9af180F5bBe5592b7c51D952f75f56125Bde9718) == 10
        );
    }

    function testChangeSatkingContract() public {
        orcaCoin.updateStakingContract(
            0x9af180F5bBe5592b7c51D952f75f56125Bde9718
        );
        vm.startPrank(0x9af180F5bBe5592b7c51D952f75f56125Bde9718);
        orcaCoin.mint(0x9af180F5bBe5592b7c51D952f75f56125Bde9718, 10);
        assert(
            orcaCoin.balanceOf(0x9af180F5bBe5592b7c51D952f75f56125Bde9718) == 10
        );
    }
}
