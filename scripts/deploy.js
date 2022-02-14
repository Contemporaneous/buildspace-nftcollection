const fs = require("fs");
const path = require('path');


// source to copy content
const src = path.join(__dirname, '..', 'artifacts', 'contracts', 'NFTMinter.sol', 'NFTMinter.json');
// destination for copied content
const dest = path.join(__dirname,'..','src','utils','NFTMinter.json');

const main = async () => {
    //Get the contract and deploy it
    const nftContractFactory = await hre.ethers.getContractFactory('NFTMinter');
    const nftContract = await nftContractFactory.deploy();
    await nftContract.deployed();
    console.log("Contract deployed to:", nftContract.address);

    fs.copyFile(src, dest, (error) => {
      // incase of any error
      console.log("Lets Copy")
      if (error) {
        console.error(error);
        return;
      }
      
      console.log("Copied Successfully!");
    });
};
  
const runMain = async () => {
    try {
      await main();
      process.exit(0);
    } catch (error) {
      console.log(error);
      process.exit(1);
    }
};
  
runMain();
