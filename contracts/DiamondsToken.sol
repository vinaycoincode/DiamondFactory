pragma solidity ^0.5.0;

import '../node_modules/openzeppelin-solidity/contracts/token/ERC721/ERC721Full.sol';

contract diamondsToken is ERC721Full{
constructor() ERC721Full("DiamondFactory", "DF") public {}

function diamondToken(address _to, uint256 _diamondtoken) external  {
    _mint(_to, _diamondtoken);
    }

function transferC(address payable _to, uint256 _diamondPrice) external payable {
   // require(balanceOf[msg.sender]<_diamondPrice,"Insufficient Balance");
        _to.transfer(_diamondPrice);
    }
}