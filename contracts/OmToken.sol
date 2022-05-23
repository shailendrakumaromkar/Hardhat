//SPDX-License-Identifier:MIT

import "../SafeMath.sol";
import "hardhat/console.sol";

pragma solidity ^0.8.0;

abstract contract IOmTokenInterface{

    function transfer(address to, uint amount) public virtual;
    function transferFrom(address from, address to, uint amount) public virtual ;
    function allowance(address tokenowner) public virtual;


}

contract OmToken {


    string public tokenName ;
    string public tokenSymbol;
    uint public decimal;
    uint public totalSupply;

    event Transfer(address to, uint amount);
    event TransferFrom(address from, address to, uint amount);

    mapping(address=> uint) public balanceOf;
    mapping (address=> mapping(address=>uint)) public allowedAmount;
    constructor(){
        tokenName ="OMKAR";
        tokenSymbol ="OM";
        decimal =2;
        totalSupply=1000*10**18;
        balanceOf[msg.sender]=totalSupply;
        emit Transfer(msg.sender, totalSupply);

    }


    function transfer(address to, uint amount) public {

        require (balanceOf[msg.sender] >=amount);
       require(amount >=0);

        balanceOf[msg.sender] = SafeMath.sub(balanceOf[msg.sender],amount);
        balanceOf[to] = SafeMath.add(balanceOf[to], amount);
        totalSupply= SafeMath.sub(totalSupply, amount);
        emit Transfer(msg.sender, amount);
    }

    function transferFrom(address from, address to, uint amount) public {
        balanceOf[from] = SafeMath.sub(balanceOf[from], amount);
        allowedAmount[from][to] = SafeMath.sub(balanceOf[msg.sender], amount);
        balanceOf[to] = SafeMath.add(balanceOf[to], amount);
        emit TransferFrom(from, to, amount);
    }

    function allowance(address tokenowner) public view returns (uint){
        return balanceOf[tokenowner];
    }
}