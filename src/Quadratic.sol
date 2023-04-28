// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Quadratic {
    bool public ok = true;

    function notOkay(int x) external {
        if ((x - 11111) * (x - 11113) < 0) {
            ok = false;
        }
    }
}
