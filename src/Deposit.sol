// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Deposit {
    address public seller = msg.sender;
    mapping(address => uint256) public balance;

    function deposit() external payable {
        balance[msg.sender] += msg.value;
    }

    function withdraw() external {
        uint256 amount = balance[msg.sender];
        require(amount > 0, "no balance");
        balance[msg.sender] = 0;
        (bool s, ) = msg.sender.call{value: amount}("");
        require(s, "failed to send");
    }

    // vulnerable function
    function changeBalance(address depositor, uint amount) public {
        balance[depositor] = amount;
    }
}
