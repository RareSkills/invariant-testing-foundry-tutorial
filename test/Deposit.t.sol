// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Deposit.sol";

contract InvariantDeposit is Test {
    Deposit deposit;

    function setUp() external {
        deposit = new Deposit();
        vm.deal(address(deposit), 100 ether);
    }

    function invariant_alwaysWithdrawable() external payable {
        vm.deal(address(0xaa), 10 ether);
        vm.startPrank(address(0xaa));
        
        deposit.deposit{value: 1 ether}();
        uint256 balanceBefore = deposit.balance(address(0xaa));
        vm.stopPrank();
        assertEq(balanceBefore, 1 ether);

        vm.prank(address(0xaa));
        deposit.withdraw();
        uint256 balanceAfter = deposit.balance(address(0xaa));
        vm.stopPrank();
        assertGt(balanceBefore, balanceAfter);
    }

    receive() external payable {}
}
