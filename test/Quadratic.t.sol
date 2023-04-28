// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Quadratic.sol";
import "./handlers/Handler_2.sol";

contract InvariantQuadratic is Test {
    Quadratic quadratic;
    Handler_2 handler;

    function setUp() external {
        quadratic = new Quadratic();
        handler = new Handler_2(quadratic);

        targetContract(address(handler));
    }

    function invariant_NotOkay() external {
        assertTrue(quadratic.ok());
    }
}
