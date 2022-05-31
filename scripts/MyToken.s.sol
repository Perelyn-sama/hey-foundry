// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/MyToken.sol";

contract MyScript is Script {
    function run() external {
        vm.startBroadcast();

        MyToken myToken = new MyToken();
    }
}
