// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

//Add Imports
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

contract NFTMinter is ERC721URIStorage {

  // Counter contract to help keep NFTs unique
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  // Pass constructor the name of our NFTs token and its symbol.
  constructor() ERC721 ("DopeGoats", "DPGT") {
    console.log("This is my Dope Goat NFT contract. Woah!");
  }

  // A function our user will hit to get their NFT.
  function makeDGNFT() public {
     // Get the current tokenId, this starts at 0.
    uint256 newItemId = _tokenIds.current();

     // Actually mint the NFT to the sender using msg.sender.
    _safeMint(msg.sender, newItemId);

    // Set the NFTs data.
    _setTokenURI(newItemId, "https://jsonkeeper.com/b/WDAO");

    // Increment the counter for when the next NFT is minted.
    _tokenIds.increment();
  }
}