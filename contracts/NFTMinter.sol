// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

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
    _setTokenURI(newItemId, "data:application/json;base64,ewogICAgIm5hbWUiOiAiS2V2aW4iLAogICAgImRlc2NyaXB0aW9uIjogIkEgRG9wZSBHb2F0IE5hbWVkIEtldmluIiwKICAgICJpbWFnZSI6ICJkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LFBITjJaeUI0Yld4dWN6MGlhSFIwY0RvdkwzZDNkeTUzTXk1dmNtY3ZNakF3TUM5emRtY2lJSEJ5WlhObGNuWmxRWE53WldOMFVtRjBhVzg5SW5oTmFXNVpUV2x1SUcxbFpYUWlJSFpwWlhkQ2IzZzlJakFnTUNBek5UQWdNelV3SWo0S0lDQWdJRHh6ZEhsc1pUNHVZbUZ6WlNCN0lHWnBiR3c2SUhkb2FYUmxPeUJtYjI1MExXWmhiV2xzZVRvZ2MyVnlhV1k3SUdadmJuUXRjMmw2WlRvZ01UUndlRHNnZlR3dmMzUjViR1UrQ2lBZ0lDQThjbVZqZENCM2FXUjBhRDBpTVRBd0pTSWdhR1ZwWjJoMFBTSXhNREFsSWlCbWFXeHNQU0ppYkdGamF5SWdMejRLSUNBZ0lEeDBaWGgwSUhnOUlqVXdKU0lnZVQwaU5UQWxJaUJqYkdGemN6MGlZbUZ6WlNJZ1pHOXRhVzVoYm5RdFltRnpaV3hwYm1VOUltMXBaR1JzWlNJZ2RHVjRkQzFoYm1Ob2IzSTlJbTFwWkdSc1pTSStSRzl3WlVkdllYUkxaWFpwYmp3dmRHVjRkRDRLUEM5emRtYysiCn0=");

    // Increment the counter for when the next NFT is minted.
    _tokenIds.increment();

    //Log the NFT to the console.
    console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);
  }
}