# Basic Sample Hardhat Project

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
- contract state will not be persisted in between
```npx hardhat run scripts/run.js```

## Deploy
This will deploy contract to the Rinkeby test network
```npx hardhat run scripts/deploy.js --network rinkeby```
