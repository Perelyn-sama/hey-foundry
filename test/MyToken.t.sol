// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/MyToken.sol";

contract MyTokenTest is Test {
    // Target contract
    MyToken myToken;

    // Actors
    address owner;
    address ZERO_ADDRESS = address(0);
    address spender = vm.addr(1);
    address user1 = vm.addr(2);

    // Test params
    string public name = "My Token";
    string public symbol = "MTKN";

    uint256 public decimals = 18;
    uint256 amount = 1000 * 1e18;
    uint256 public initialSupply = 1000 * 1e18;

    event Transfer(address indexed from, address indexed to, uint256 value);

    //  =====   Set up  =====

    function setUp() public {
        owner = address(this);
        myToken = new MyToken();
    }

    //  =====   Initial state   =====

    /**
     *  @dev Tests the relevant initial state of the contract.
     *
     *  - Token name is 'My Token'
     *  - Token symbol is 'MTKN'
     *  - Token initail supply is '1000000000000000000000'
     *  - Token decimals is '18'
     */
    function testinitialState() public {
        // assert if the corrent name was used
        assertEq(myToken.name(), name);

        // assert if the correct symbol was used
        assertEq(myToken.symbol(), symbol);

        // assert if the correct initial supply was set
        assertEq(myToken.totalSupply(), initialSupply);

        // assert if the correct decimal was set
        assertEq(myToken.decimals(), decimals);
    }

    //  =====   Functionality tests   =====

    /// @dev Test `mint`

    // Only Owner should be able to mint
    function testFailUnauthorizedMinter() public {
        vm.prank(user1);
        myToken.mint(user1, amount);
    }

    // Should not be able to mint to the zero address
    function testFailMintToZeroAddress() public {
        vm.prank(owner);
        myToken.mint(ZERO_ADDRESS, amount);
    }

    // Should increase total supply
    function testIncreseTotalSupply() public {
        uint256 expectedSupply = initialSupply + amount;
        vm.prank(owner);
        myToken.mint(owner, amount);
        assertEq(myToken.totalSupply(), expectedSupply);
    }

    // Should increase recipient balance
    function testIncreaseRecipientBalance() public {
        vm.prank(owner);
        myToken.mint(user1, amount);
        assertEq(myToken.balanceOf(user1), amount);
    }

    // Should emit Transfer event
    function testEmitTransferEvent() public {
        vm.expectEmit(true, true, false, true);

        emit Transfer(ZERO_ADDRESS, user1, amount);

        vm.prank(owner);
        myToken.mint(user1, amount);
    }
}
