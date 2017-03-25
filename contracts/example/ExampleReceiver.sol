pragma solidity ^0.4.8;

import "../implementation/TokenReceiver.sol";

contract ExampleReceiver is TokenReceiver {
  function foo(/*uint i*/) tokenPayable {
    LogTokenPayable(1, tkn.addr, tkn.sender, tkn.value);
  }

  function () tokenPayable {
    LogTokenPayable(0, tkn.addr, tkn.sender, tkn.value);
  }

  function supportsToken(address token) returns (bool) {
    return true;
  }

  event LogTokenPayable(uint i, address token, address sender, uint value);
}
