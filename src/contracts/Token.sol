// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {

    address public minter;
    event MinterChanged(address indexed from, address to);

    constructor() public payable ERC20("Decentralized Bank Currency", "DCB") {
        minter = msg.sender;
    }

    function passMinterRole(address newMinter) public returns (bool) {
        require(msg.sender == minter, "Error. Only contract creator can assign new role");
        minter = newMinter;

        emit MinterChanged(msg.sender, newMinter);
        return true;
    }

    function mint(address adr, uint amount) public {
        require(msg.sender == minter, "Error. Minter only can be creator of token");
        _mint(adr, amount);
    }
}