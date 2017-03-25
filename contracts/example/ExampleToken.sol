pragma solidity ^0.4.8;

import "../implementation/Standard23Token.sol";

contract ExampleToken is Standard23Token {
  function ExampleToken(uint initialBalance) {
    balances[msg.sender] = initialBalance;
    totalSupply = initialBalance;
    // Ideally call fallback here too
  }
}
