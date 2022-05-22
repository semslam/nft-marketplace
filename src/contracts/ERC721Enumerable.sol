// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import './ERC721.sol';

contract ERC721Enumerable is ERC721{

    uint256[] private _allTokens;
 
    // mapping from tokenId to position in _allTokens array
    mapping(uint256 => uint256) private _allTokenIndexes;
// mapping of owner to list of all owner to ids
    mapping(address => uint256[]) private _OwnerTokens;
// mapping from token ID index of the owner tokens list
     mapping(uint256 => uint256) private _OwnerTokensIndexs;

     

    function _mint(address to, uint256 tokenId) internal override(ERC721){
        super._mint(to, tokenId);
        _addTokensToTotalSupply(tokenId);
    }

    function _addTokensToTotalSupply(uint256 tokenId)private{

        _allTokens.push(tokenId);
    }

    function totalSupply() public view returns(uint256){
        return _allTokens.length;
    }
}