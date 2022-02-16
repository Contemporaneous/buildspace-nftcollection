# NFT Collection Tutorial

This Project is following the [buildspace](https://buildspace.so/) tutorial `Mint Your own NFT collection`

My version is a web app that allows the user to mint an svg based NFT called `Dope Goats`


### Setup
Install dependancies
```bash
npm install
```

### Deployment

Deploy Contract (requires update of `src\App.js` with new contract address)
```bash
npx hardhat run scripts\run.js --network NETWORK
```

Verify Contract (not on matic networks)
```bash
npx hardhat verify YOUR_CONTRACT_ADDRESS --network NETWORK 
```

### App
Run WebApp Locally
```bash
npm run start
```