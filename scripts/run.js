const main = async () => {
    // compile contract and generate files and artifacts
    const waveContractFactory = await hre.ethers.getContractFactory('WavePortal');
    // creates a new test network for contract
    // destroys network at the end of the contract for dev
    const waveContract = await waveContractFactory.deploy({
        value: hre.ethers.utils.parseEther('0.1'), // deploy contract funded with 0.1 ether
    });
    //wait for contract to be deployed
    await waveContract.deployed();
    //gives us the address of our contract on the blockchain
    console.log("Contract deployed to:", waveContract.address);
    
    let contractBalance = await hre.ethers.provider.getBalance(
        waveContract.address
    );

    console.log('Contract Balance:', hre.ethers.utils.formatEther(contractBalance));



    // send wave transaction
    let waveTransaction = await waveContract.wave('Test Message Yo!');
    await waveTransaction.wait() // waiting for contract changes to be mined.
    
    
    let waveTransaction2 = await waveContract.wave('Test Message TWO!!!');
    await waveTransaction2.wait() 
  

    contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
    console.log('Balance:', hre.ethers.utils.formatEther(contractBalance));
    
    let allWaves = await waveContract.getAllWaves();
    console.log(allWaves);
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