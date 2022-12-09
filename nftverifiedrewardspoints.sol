pragma solidity ^0.6.0;

contract RewardsToken {
    // The token name
    string public name = "TokenA";

    // The token symbol
    string public symbol = "TA";

    // The total supply of tokens
    uint256 public totalSupply;

    // The address of the owner of the contract
    address public owner;

    // The mapping of all token balances
    mapping (address => uint256) public balanceOf;

    // The mapping of all token allowances
    mapping (address => mapping (address => uint256)) public allowed;

    // The NFT associated with this reward token
    address public nftContract;

    // The NFT token ID to be awarded when the reward conditions are met
    uint256 public nftTokenId;

    // The reward conditions
    uint256 public rewardCondition;

    // The event for when the reward is given
    event RewardGiven(address recipient, uint256 amount);
// Constructor
    constructor(uint256 _totalSupply, address _nftContract, uint256 _nftTokenId, uint256 _rewardCondition) public {
        // Set the total supply of tokens
        totalSupply = _totalSupply;
        // Set the owner of the contract
        owner = msg.sender;
        // Set the NFT address
        nftContract = _nftContract;
        // Set the NFT token ID
        nftTokenId = _nftTokenId;
        // Set the reward condition
        rewardCondition = _rewardCondition;
        // Allocate the total supply of tokens to the owner
        balanceOf[owner] = totalSupply;
    }

    // Transfer tokens from one address to another
    function transfer(address recipient, uint256 amount) public returns (bool) {
        require(balanceOf[msg.sender] >= amount, "Insufficient balance.");
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
        emit Transfer(msg.sender, recipient, amount);
        return true;
    }

    // Function to check if the reward conditions are met and to give the reward if they are
    function checkReward() public returns (bool) {
        if (balanceOf[msg.sender] >= rewardCondition) {
            // Transfer the NFT to the recipient
            ERC721(_nftContract).transferFrom(owner, msg.sender, nftTokenId);

            // Emit the RewardGiven event
            emit RewardGiven(msg.sender, nftTokenId);

            return true;
        }
        return false;
    }
}
