// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    address public _owner;

    constructor() ERC20("My Token", "MTKN") {
        _owner = msg.sender;
        _mint(msg.sender, 1000 * 10**decimals());
    }

    function mint(address account, uint256 amount) public owner {
        _mint(account, amount);
    }

    function burn(address account, uint256 amount) public owner {
        _burn(account, amount);
    }
    
    modifier owner() {
        require(msg.sender == _owner, "Only Owner ");
        _;
    }
}
