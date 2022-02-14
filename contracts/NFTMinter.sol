// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

//Add Imports
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "hardhat/console.sol";

import { Base64 } from "./libraries/Base64.sol";

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
  
  //events
  event NFTMinted(address sender, uint256 tokenId);

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

    //Generate name colout and SVG
    string memory name = randomName(newItemId);
    string memory colour = randomColour(newItemId);

    string memory finalSvg = string(abi.encodePacked(baseSvg1, colour, baseSvg2, name, "</text></svg>"));

    //Generate json object and encode
    string memory json = Base64.encode(
        bytes(
            string(
                abi.encodePacked(
                    '{"name": "',
                    name,
                    '", "description": "A Dope Goat named ',name,'.", "image": "data:image/svg+xml;base64,',
                    Base64.encode(bytes(finalSvg)),
                    '"}'
                )
            )
        )
    );

    string memory finalTokenUri = string(
        abi.encodePacked("data:application/json;base64,", json)
    );

     // Actually mint the NFT to the sender using msg.sender.
    _safeMint(msg.sender, newItemId);

    // Set the NFTs data.
    _setTokenURI(newItemId, finalTokenUri);

    // Increment the counter for when the next NFT is minted.
    _tokenIds.increment();

    //Log the NFT to the console.
    console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);

    //emit
    emit NFTMinted(msg.sender, newItemId);
  }
}