# WavePortal Smart Contract

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, a sample script that deploys that contract, and an example of a task implementation, which simply lists the available accounts.

Try running some of the following tasks:

```shell
npx hardhat accounts
npx hardhat compile
npx hardhat clean
npx hardhat test
npx hardhat node
node scripts/sample-script.js
npx hardhat help
```
## Run on local test network
This will run a test network that is torn down when contract code finishes running

```npx hardhat run scripts/run.js```

- contract state will not be persisted in between


## Deploy
This will deploy contract to the Rinkeby test network

```npx hardhat run scripts/deploy.js --network rinkeby```

### Don't forget to get your Alchemy key and grab your test_net private key from Metamask

##### Motivation
I built this project along with 🦄buildspace to learn Solidity and smart contract development
