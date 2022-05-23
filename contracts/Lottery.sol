//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.4.0 <0.8.0;

import "hardhat/console.sol";

contract Lottery {

    address public manager;
    address[] public players;

    constructor() {
        manager=msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender==manager);
        _;

    }
    
    function startLottery() public payable {
        require(msg.value > 0.1 ether);
        players.push(msg.sender);
    }

    function winner() public {


        uint i = uint(keccak256(abi.encodePacked(block.timestamp,players)));
    console.log("value of i is %s : ", i);
    console.log("player length is %s: ", players.length);
        uint j = i% players.length;

    console.log("value of j is %s : ", j);

    payable (players[j]).transfer(address(this).balance);


    }

}