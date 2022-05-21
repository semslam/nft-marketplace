// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import './ERC721Connector.sol';

contract Kryptobird is ERC721Connector{
    // array to store out nft
    string [] public kryptobird;
    mapping(string => bool) _kryptoBirdExists;

    function mint(string memory _kryptoBird) public {
        require(!_kryptoBirdExists[_kryptoBird], 'Error - KryptoBird already minted');
       //this is deprecated- uint _id = KryptoBird.push(_kryptoBird);
        kryptobird.push(_kryptoBird);
        uint _id = kryptobird.length;
        _mint(msg.sender, _id); 
        _kryptoBirdExists[_kryptoBird] = true; 
    }
   
    constructor()ERC721Connector('KryptoBird', 'KBIRD'){

    }

}