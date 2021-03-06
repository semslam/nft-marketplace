// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
    buliding out the minting function:
    a. nft to point to an address
    b. keep track of the token ids
    c. keep track of token owner addresses to token ids
    d. keep track of how many token an owner has
    e. create an event that emits a transfer log - contract address, where it is being minited to, the id
 */
contract ERC721{

    event Transfer(
        address indexed from, 
        address indexed to , 
        uint256 indexed tokenId);
    

// Mapping from the id to the owner
mapping(uint256 => address) private _tokenOwner;

// Mapping from owner to number of owner tokens
mapping(address => uint256) private _OwnedTokensCount;


//Mapping from token id to approved address
mapping(uint256 => address) private _tokenApprovals;


/// @notice Count all NFTs assigned to an owner
/// @dev NFTs assigned to the zero address are considered invalid, and this
///  function throws for queries about the zero address.
/// @param _owner An address for whom to query the balance
/// @return The number of NFTs owned by `_owner`, possibly zero
function balanceOf(address _owner) public view returns(uint256){
    require(_owner != address(0),'Error- owner query for non-exixtent token');
  return _OwnedTokensCount[_owner];
}
/// @notice Find the owner of an NFT
/// @dev NFTs assigned to zero address are considered invalid, and queries
///  about them do throw.
/// @param _tokenId The identifier for an NFT
/// @return The address of the owner of the NFT
function ownerOf(uint256 _tokenId) external view returns(address){
//    require(!_exists(_tokenId), 'ERC721: token already minted');
    address owner = _tokenOwner[_tokenId];
     require(owner != address(0), 'Owner query for  non-exixtent token');
    return owner;
}

function _exists (uint256 tokenId) internal view returns(bool){
    //setting the address of the nft owner to check the mapping
    //of the addresss from tokenOwner at the tokenId
    address owner = _tokenOwner[tokenId];
    // return truthiness the address is not zero
    return owner != address(0); 
}

function _mint(address to, uint256 tokenId) internal virtual {
    // requires that the address isn't zero
    require(to != address(0), 'ERC721: minting to the zero address');
    //requires that the token does not already exist
    require(!_exists(tokenId), 'ERC721: token already minted');
    // we are adding a new address with a token id for miniting
    _tokenOwner[tokenId] = to;
    //keeping track of each address that is miniting and adding one to the count
    _OwnedTokensCount[to] +=1;

    emit Transfer(address(0), to, tokenId);
}

/// @notice Transfer ownership of an NFT -- THE CALLER IS RESPONSIBLE
///  TO CONFIRM THAT `_to` IS CAPABLE OF RECEIVING NFTS OR ELSE
///  THEY MAY BE PERMANENTLY LOST
/// @dev Throws unless `msg.sender` is the current owner, an authorized
///  operator, or the approved address for this NFT. Throws if `_from` is
///  not the current owner. Throws if `_to` is the zero address. Throws if
///  `_tokenId` is not a valid NFT.
/// @param _from The current owner of the NFT
/// @param _to The new owner
/// @param _tokenId The NFT to transfer
function _transferFrom(address _from, address _to, uint256 _tokenId)internal{
    require(_to != address(0), 'Error - ERC721 Transfer to the zero address');
    require(ownerOf(_tokenId) == _from,'Trying to transfer a token the sddress does not exist');
    _OwnedTokensCount[_from] -=1;
    _OwnedTokensCount[_to] +=1;

    _tokenOwner[_tokenId] = _to;
    emit Transfer(_from, _to, _tokenId);

}


function transferFrom(address _from, address _to, uint256 _tokenId)public{
    _transferFrom(_from, _to, _tokenId);
}




}