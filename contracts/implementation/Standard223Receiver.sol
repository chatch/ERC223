pragma solidity ^0.4.15;

 /* ERC223 additions to ERC20 */

import "../interface/ERC223Receiver.sol";

contract Standard223Receiver is ERC223Receiver {
  Tkn tkn;

  struct Tkn {
    address addr;
    address sender;
    address origin;
    uint256 value;
    bytes data;
    bytes4 sig;
  }

  /**
   * This is called by the token contract after token transfer.
   *
   * A function signature is extracted from the first 4 bytes of _data and a
   * a delegatecall is made to that function.
   *
   * Call details are stored in tkn which the derivative contact has access too.
   *
   * @param _sender Address that called token.transfer() or token.transferFrom()
   * @param _origin If token.transfer() called this is the same as _sender
   *    if token.transferFrom() called this is the from address in the transfer
   * @param _value Number of tokens
   * @param _data Bytes containing the signature of the function to call on the
   *    receiver (1st 4 bytes) plus any other data specific to the call.
   *
   * @return ok True if the call was successful.
   */
  function tokenFallback(
    address _sender,
    address _origin,
    uint _value,
    bytes _data
  )
    returns (bool ok)
  {
    if (!supportsToken(msg.sender)) return false;

    // Problem: This will do a sstore which is expensive gas wise. Find a way to keep it in memory.
    tkn = Tkn(msg.sender, _sender, _origin, _value, _data, getSig(_data));
    __isTokenFallback = true;
    if (!address(this).delegatecall(_data)) return false;

    // avoid doing an overwrite to .token, which would be more expensive
    // makes accessing .tkn values outside tokenPayable functions unsafe
    __isTokenFallback = false;

    return true;
  }

  function getSig(bytes _data)
    private
    returns (bytes4 sig)
  {
    uint l = _data.length < 4 ? _data.length : 4;
    for (uint i = 0; i < l; i++) {
      sig = bytes4(uint(sig) + uint(_data[i]) * (2 ** (8 * (l - 1 - i))));
    }
  }

  bool __isTokenFallback;

  modifier tokenPayable {
      require(__isTokenFallback);
    _;
  }

  /**
   * Check the token contract that is calling tokenFallback is supported by this
   *  receiver contract.
   *
   * @param _token Token contract that called this receiver
   */
  function supportsToken(address _token) returns (bool);
}
