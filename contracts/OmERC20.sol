//SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

//import "@openzeppelin/contracts/token/ERC20/ERC20.sol"
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Capped.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract OmERC20 is ERC20Capped, Ownable{
    constructor(uint256 cap) ERC20("OmToken","OM") ERC20Capped (cap){
    }

    //mint function for tokenss
    function issueToken()public onlyOwner{
        _mint(msg.sender, 1000*10**18);
    }

}