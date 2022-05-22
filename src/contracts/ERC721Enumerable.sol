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
        _addTokensToAllTokenEnumeration(tokenId);
        _addTokensToOwnerEnumeration(to, tokenId);
    }
//add tokens to the _allTokens array and set the position of the token indexes
    function _addTokensToAllTokenEnumeration(uint256 tokenId)private{
        _allTokenIndexes[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);
    }

    function _addTokensToOwnerEnumeration(address to, uint256 tokenId) private{
        // add address and token id to the _ownedTokens
        // ownedTokensIndex tokenId set to address of ownerToken poasition
        _OwnerTokensIndexs[tokenId] =_OwnerTokens[to].length;
         _OwnerTokens[to].push(tokenId);
        // we want to execute the function with minting
    }

    // write two functions - one that returns tokenByIndex and another one that returns tokenOfOwnerByIndex
    function tokenByIndex(uint256 index) public view returns(uint256){
        require(index < totalSupply(),'global index i out of bounds!');
        return _allTokens[index];
    }

    function tokenOfOwnerByIndex(address owner,uint256 index) public view returns(uint256){
       require(index < balanceOf(owner),'owner index i out of bounds!');
       return _OwnerTokens[owner][index];
    }

    //return the total supply of the _allToken arry
    function totalSupply() public view returns(uint256){
        return _allTokens.length;
    }
}