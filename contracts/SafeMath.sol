//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;
library SafeMath{

    function add(uint a, uint b) public pure returns (uint){
        uint c= a+b;
        require(c>=b);
        return c;
    }

    //sub
    function sub(uint a, uint b) public pure returns (uint){
        require(b<=a);
        uint c= a-b;
        return c;
    }
}