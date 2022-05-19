//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract Maths {
    uint a;
    uint b;
    uint public res;


    function add(uint _a, uint _b) public {
        a=_a;
        b=_b;
        console.log("adding 2 numbers");
        res=a+b;
    }

    function getRes() public view returns (uint){
        console.log("sum of 2 number is %d: ", res);
        return res;
    }
}

