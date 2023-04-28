// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "../../src/SideEntranceLenderPool/SideEntranceLenderPool.sol";
import "forge-std/Test.sol";

contract Handler is Test {
    SideEntranceLenderPool pool;

    bool canWithdraw;

    constructor(SideEntranceLenderPool _pool) {
        pool = _pool;

        vm.deal(address(this), 10 ether);
    }

    function execute() external payable {
        pool.deposit{value: msg.value}();
        canWithdraw = true;
    }

    function withdraw() external {
        if (canWithdraw) pool.withdraw();
    }

    function flashLoan(uint amount) external {
        vm.assume(amount > 10 ether);
        amount = bound(amount, 10 ether, 200 ether);

        pool.flashLoan(amount);
    }

    receive() external payable {}
}
