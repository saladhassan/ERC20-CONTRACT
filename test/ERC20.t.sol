// SPDX-License-Identifier:MIT

pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/ERC20.sol";

contract ERC20Test is Test {
    ERC20 token;

    address owner = address(1);

    function setUp() public {
        vm.prank(owner);
        token = new ERC20("MyToken", "MTK", 1000);
    }

    function testInitialSetup() public view {
        assertEq(token.owner(), owner);
        assertEq(token.totalSupply(), 1000);
        assertEq(token.balanceOf(owner), 1000);
    }

    function testTransferWorks() public {
        address user = address(2);

        vm.prank(owner);
        token.transfer(user, 100);

        assertEq(token.balanceOf(owner), 900);
        assertEq(token.balanceOf(user), 100);
    }

    function testCannotTransferToZero() public {
        vm.prank(owner);
        vm.expectRevert();

        token.transfer(address(0), 100);
    }

    function testCannotTransferMoreThanBalance() public {
        address user = address(2);

        vm.prank(user); // user has 0 tokens
        vm.expectRevert();

        token.transfer(owner, 100);
    }

    function testMintWorks() public {
        address user = address(2);

        vm.prank(owner);
        token.mint(user, 100);

        assertEq(token.balanceOf(user), 100);
        assertEq(token.totalSupply(), 1100);
    }

    function testOnlyOwnerCanMint() public {
        address user = address(2);

        vm.prank(user);
        vm.expectRevert();

        token.mint(user, 100);
    }

    function testCannotMintToZero() public {
        vm.prank(owner);
        vm.expectRevert();

        token.mint(address(0), 100);
    }

    function testBurnWorks() public {
        vm.prank(owner);
        token.burn(100);

        assertEq(token.balanceOf(owner), 900);
        assertEq(token.totalSupply(), 900);
    }

    function testCannotBurnMoreThanBalance() public {
        address user = address(2);

        vm.prank(user);
        vm.expectRevert();

        token.burn(100); // user has 0
    }

    function testApproveWorks() public {
        address spender = address(2);

        vm.prank(owner);
        token.approve(spender, 100);

        assertEq(token.allowance(owner, spender), 100);
    }

    function testTransferFromWorks() public {
        address spender = address(2);
        address receiver = address(3);

        // owner approves spender
        vm.prank(owner);
        token.approve(spender, 100);

        // spender transfers tokens
        vm.prank(spender);
        token.transferFrom(owner, receiver, 50);

        assertEq(token.balanceOf(owner), 950);
        assertEq(token.balanceOf(receiver), 50);
        assertEq(token.allowance(owner, spender), 50);
    }

    function testCannotExceedAllowance() public {
        address spender = address(2);

        vm.prank(owner);
        token.approve(spender, 50);

        vm.prank(spender);
        vm.expectRevert();

        token.transferFrom(owner, address(3), 100);
    }
}
