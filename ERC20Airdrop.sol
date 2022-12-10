pragma solidity ^0.5.0;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol";
import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/utils/ReentrancyGuard.sol";
import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";

contract Airdrop is ReentrancyGuard {
    // Use the SafeMath library for safe arithmetic operations
    using SafeMath for uint256;

    // Define the token contract address
    address tokenAddress;

    // Define the owner's wallet address
    address owner;

    // Define the recipient wallets
    address[] recipients;

    // Constructor to initialize the contract with the owner's wallet address
    constructor(address _owner) public {
        // Set the owner's wallet address
        owner = _owner;
    }

    // Function to set the token contract address
    function setToken(address _tokenAddress) public {
        // Use the ReentrancyGuard to prevent reentrancy attacks
        ReentrancyGuard.preventReentrancy();

        // Check that the caller is the owner
        require(msg.sender == owner, "Only the owner can set the token contract address");

        // Set the token contract address
        tokenAddress = _tokenAddress;
    }

    // Function to add recipient wallet addresses
    function addRecipient(address _recipient) public {
        // Use the ReentrancyGuard to prevent reentrancy attacks
        ReentrancyGuard.preventReentrancy();

        // Check that the caller is the owner
        require(msg.sender == owner, "Only the owner can add recipient wallet addresses");

        // Add the recipient wallet address to the array
        recipients.push(_recipient);
    }

    // Function to perform the airdrop
    function airdrop() public {
        // Use the ReentrancyGuard to prevent reentrancy attacks
        ReentrancyGuard.preventReentrancy();

        // Check that the caller is the owner
        require(msg.sender == owner, "Only the owner can perform the airdrop");

        // Check that the token contract address has been set
        require(tokenAddress != address(0), "Token contract address not set");

        // Create a reference to the token contract
        ERC20 token = ERC20(tokenAddress);

        // Loop through the recipient wallet addresses
        for (uint i = 0; i < recipients.length; i++) {
            // Airdrop the token to the recipient's wallet
            token.transfer(recipients[i], 1000);
        }
    }
}
