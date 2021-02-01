pragma solidity ^0.4.24;

import "../ERC721/ERC721.sol";


contract ERC721Test is ERC721Token {
  constructor(string name, string symbol) public {
    ERC721Token.initialize(name, symbol);
  }

  function mint(address _to, uint256 _tokenId) public {
    super._mint(_to, _tokenId);
  }

  function burn(uint256 _tokenId) public {
    super._burn(ownerOf(_tokenId), _tokenId);
  }

  function setTokenURI(uint256 _tokenId, string _uri) public {
    super._setTokenURI(_tokenId, _uri);
  }
}