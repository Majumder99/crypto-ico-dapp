// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

// this is erc20 token 
// Write a erc20 token contract and then import it
import "./FunToken.sol";

contract IcoToken{
    address payable admin;
    FunToken public tokenContract;
    uint256 public tokenPrice;
    uint256 public tokenSold;

    event Sell(address _buyer, uint256 _amount);

    // first is erc20 token, and second is the amount
    constructor(FunToken _tokenContract, uint256 _tokenPrice) {
        admin = payable(msg.sender);
        tokenContract = _tokenContract;
        tokenPrice = _tokenPrice;
    }

    function multiply(uint256 x, uint256 y) internal pure returns(uint256){
        require(y == 0 || (z = x * y) /y == x );
    }

    function buyTokens(uint256 _numberOftoken) public payable{
        require(msg.value == multiply(_numberOftoken, tokenPrice));
        require(tokenContract.balanceOf(address(this)) >= _numberOftoken);
        require(tokenContract.transfer(msg.sender, _numberOftoken));

        tokenSold += _numberOftoken;

        emit Sell(msg.sender, _numberOftoken);
    }

    function endSale() public {
        require(msg.sender == admin);
        require(tokenContract.transfer(admin, tokenContract.balanceOf(address(this))));
        admin.transfer(address(this).balance);
    }

}