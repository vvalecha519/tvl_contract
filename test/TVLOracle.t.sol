// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {TVLOracle} from "../src/TVLOracle.sol";

contract TVLOracleTest is Test {
    TVLOracle public tvlOracle;

    function setUp() public {
        tvlOracle = new TVLOracle(address(this));
    }

    function testSetTvl() public {
        tvlOracle.setTvl("liquid-weth", 100);
        assertEq(tvlOracle.tvl("liquid-weth"), 100);
    }

    function testSetTVLAggregator() public {
        tvlOracle.setTVLAggregator(address(0x1));
        assertEq(tvlOracle.tvlAggregator(), address(0x1));
    }

    function testSetTVLAggregatorFail() public {
        address alice = address(1);
        vm.prank(alice);
        vm.expectRevert();
        tvlOracle.setTVLAggregator(address(0x1));
        vm.stopPrank();
    }

    function testSetTVLFail() public {
        address alice = address(1);
        vm.prank(alice);
        vm.expectRevert();
        tvlOracle.setTvl("total_tvl", 12);
        vm.stopPrank();
    }
}
