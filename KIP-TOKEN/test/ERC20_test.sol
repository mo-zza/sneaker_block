pragma solidity ^0.4.24;

import "../ERC20/ERC20.sol";


contract ERC20Test is StandardToken {
  function setBalance(address holder, uint256 amount) public {
    balances[holder] = amount;
  }
}