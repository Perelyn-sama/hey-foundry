// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/MyToken.sol";

contract MyTokenTest is Test {
    MyToken myToken;
    // Vm private vm = Vm(HEVM_ADDRESS);

    address spender = address(100);
    address addr2 = address(200);
    address owner;

    string public name = "My Token";
    string public symbol = "MTKN";

    uint256 public initialSupply = 1000 * 1e18;
    uint256 public decimals = 18;

    function setUp() public {
        owner = address(this);
        myToken = new MyToken();
    }

    function testConfig() public {
        // assert if the corrent name was used
        assertEq(myToken.name(), name);

        // assert if the correct symbol was used
        assertEq(myToken.symbol(), symbol);

        // assert if the correct initial supply was set
        assertEq(myToken.totalSupply(), initialSupply);

        // assert if the correct decimal was set
        assertEq(myToken.decimals(), decimals);
    }

    function testFailApprove() public {
        emit log_address(owner);
        emit log_named_uint("balance of owner", myToken.balanceOf(owner));
        emit log_named_uint("total supply", myToken.totalSupply());
        myToken.decreaseAllowance(spender, 10);

        // stdError.assertionError();
        // asser
        // stdError.assertionError(myToken.decreaseAllowance(spender, 10));
    }

    //     function testApprove() public {
    //         vm.prank(owner);
    //         myToken.approve(spender, 10 * 1e18);

    //         emit log_named_uint(
    //             "allowance of spender",
    //             myToken.allowance(owner, spender) / 1e18
    //         );
    //         emit log_named_uint(
    //             "balance of owner",
    //             myToken.balanceOf(owner) / 1e18
    //         );

    //         // vm.prank(owner);
    //         // myToken.decreaseAllowance(spender, 5 * 1e18);
    //         // emit log_uint(myToken.allowance(owner, spender));

    //         vm.prank(spender);
    //         myToken.transferFrom(spender, addr2, 1);
    //     }
}
