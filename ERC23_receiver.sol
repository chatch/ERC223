pragma solidity ^0.4.9;

 /*
 * Contract that is working with ERC23 tokens
 * light version
 * this contract is a token trap. Accept all incoming tokens and never let them back
 */
 
 contract contractReciever {
     
    //supported token contracts are stored here
    //mapping (address => bool) supportedTokens;
    
    //contract creator can add supported tokens
    /*
    function addToken(address _token){     //onlyOwner
        supportedTokens[_token]=true;
    }
    */
    
    //if token is now disabled, replacced or not supported for other reasons we it can be disabled
    /*
    function removeToken(address _token){  //onlyOwner
        supportedTokens[_token]=false;
    }
    */
    
    //Fallback fuction analogue called from token contract when token transaction to this contract appears
    function fallbackToken(address _from, uint _value){
    
    }
 }
