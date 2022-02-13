// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

//Add Imports
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "hardhat/console.sol";

contract NFTMinter is ERC721URIStorage {

  // Counter contract to help keep NFTs unique
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  //Base SVG String
  string baseSvg1 = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='";
  string baseSvg2 = "' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>DopeGoat";

  //Random Lists
  string[] names = ["Alfred", "Bertrand", "Charles", "Dennis", "Eugene", "Friedrich", "George", "Hans", "Ivan", "Julius", "Klaus", "Ludwig", "Manfred", "Nils", "Otto", "Paul"];
  string[] colours = ["crimson", "darkslateblue", "darkgreen", "burlywood", "coral", "midnightblue", "mediumvioletred", "lightblue", "seagreen", "steelblue", "mediumaquamarine", "plum", "sienna", "limegreen", "orchid"];


  // Pass constructor the name of our NFTs token and its symbol.
  constructor() ERC721 ("DopeGoats", "DPGT") {
    console.log("This is my Dope Goat NFT contract. Woah!");
  }

  function randomName(uint256 tokenId) public view returns (string memory) {
    uint256 rand = random(string(abi.encodePacked("NAME", Strings.toString(tokenId))));
    rand = rand % names.length;
    return names[rand];
  }

  function randomColour(uint256 tokenId) public view returns (string memory) {
    uint256 rand = random(string(abi.encodePacked("COLOUR", Strings.toString(tokenId))));
    rand = rand % colours.length;
    return colours[rand];
  }

  function random(string memory input) internal pure returns (uint256) {
      return uint256(keccak256(abi.encodePacked(input)));
  }

  // A function our user will hit to get their NFT.
  function makeDGNFT() public {
     // Get the current tokenId, this starts at 0.
    uint256 newItemId = _tokenIds.current();

    string memory name = randomName(newItemId);
    string memory colour = randomColour(newItemId);

    string memory finalSvg = string(abi.encodePacked(baseSvg1, colour, baseSvg2, name, "</text></svg>"));
    console.log("\n--------------------");
    console.log(finalSvg);
    console.log("--------------------\n");

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