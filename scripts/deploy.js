const main = async () => {
    //Get the contract and deploy it
    const nftContractFactory = await hre.ethers.getContractFactory('NFTMinter');
    const nftContract = await nftContractFactory.deploy();
    await nftContract.deployed();
    console.log("Contract deployed to:", nftContract.address);
  
    // Call the Minting function 10 times
    for (let i = 0; i < 10; i++) {
        let txn = await nftContract.makeDGNFT()
        // Wait for it to be mined
        await txn.wait()
    }
  
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