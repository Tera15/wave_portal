// SPDX-License-Identifier: UNLICENSED

// the version of solidity compiler we want to use.
// make sure it's the same as in the hardhat.config file
pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {
    // state variable that lives with the contract on the blockchain forever.
    uint256 totalWaves;
    uint256 private seed;

    // Event is an inhertitable member of a contract. An event is emitted, it stores the arguments passed in transaction logs. 
    // Stored on the blockchain; accessible from using the address of contract till contract is present on blockchain.
    // An event generated is not accessible from within contracts, not event the one which have created and emitted them.
    event NewWave(address indexed from, uint256 timestamp, string message);
    
    // Like a struct in Rust or an interface in TS... 
    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
    }

    Wave[] waves;

    // mapping to associate an address with data -> in this case a number;
    // mapping has access to every single address on the entire network, wether or not they've heard of our app.
    mapping(address => uint256) public lastWavedAt;

    constructor() payable { // payable tells the blockchain that our contract can pay out to users.
        console.log("Contract has been constructed");
        seed = (block.timestamp + block.difficulty) % 100; // contracts are publicly visible, block.timestamp and block.difficulty are fairly random
    }                                                     //  so we use those to make a random number

    // almost like cloud functions from AWS but compute power comes from miners
    function wave(string memory _message) public { // public allows function to be called on the blockchain.
        // make sure timestamp is at least 15 minutes after the users last attempt.
        require (
            lastWavedAt[msg.sender] + 15 minutes < block.timestamp,
            "Wait 15m"
        );
        lastWavedAt[msg.sender] = block.timestamp;
        totalWaves += 1;
        console.log("%s has waved!", msg.sender);// msg.sender is the wallet of the person whom called the function -- can use for auth like things
        
        waves.push(Wave(msg.sender, _message, block.timestamp));
   

        // creates new seed for each wave
        seed = (block.difficulty + block.timestamp + seed) % 100; // randomish number but could be an attack vector because not fully random
        // solidity doesn't have a native random number which is a strenght of blockchain, but also kinda annoying for an app like this.

        if (seed <= 50) {
            console.log("%s won!", msg.sender);
            uint256 prizeAmmount = 0.0001 ether;
            // checks to see if condition is true, if it is NOT it will quit the function and cancel the transaction
            require ( // Make sure balance is greater than prize ammount else cancel transaction.
                prizeAmmount <= address(this).balance,
                "Trying to withdraw more money than the contract has."
            );
            (bool success,) = (msg.sender).call{value: prizeAmmount}("");
            // if fail, exit transaction
            require(success, "Failed to withdraw money from the contract.");
        }
        // emiting event that was defined earlier on line 17
        emit NewWave(msg.sender, block.timestamp, _message); 
    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("we have %d total waves", totalWaves);
        return totalWaves;
    }
}