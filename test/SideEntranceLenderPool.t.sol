// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "../src/SideEntranceLenderPool/SideEntranceLenderPool.sol";
import "./handlers/Handler.sol";

contract InvariantSideEntranceLenderPool is Test {
    SideEntranceLenderPool pool;
    Handler handler;

    function setUp() external {
        pool = new SideEntranceLenderPool{value: 25 ether}();

        handler = new Handler(pool);
        // set the handler contract as the target for our test
        targetContract(address(handler));
    }

    function invariant_poolBalanceAlwaysGtThanInitialBalance() external {
        assert(address(pool).balance >= pool.initialPoolBalance());
    }
}
