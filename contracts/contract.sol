// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RecyclingRewardSystem {

    // Define a simple ERC20-like token structure
    string public name = "Recycling Reward Token";
    string public symbol = "RRT";
    uint8 public decimals = 18;
    
    // Mapping to store token balances of each user
    mapping(address => uint256) private balances;
    
    // Total supply of tokens
    uint256 public totalSupply;

    // Address of the contract owner (admin)
    address public owner;
    
    // Event to log recycling action
    event Recycle(address indexed user, uint256 rewardAmount);
    
    // Event for token minting
    event TokensMinted(address indexed to, uint256 amount);

    // Constructor to set the owner of the contract
    constructor() {
        owner = msg.sender;
    }

    // Modifier to restrict functions to only the contract owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can mint tokens");
        _;
    }

    // Function to mint new tokens (only callable by the owner)
    function mintTokens(address to, uint256 amount) external onlyOwner {
        require(to != address(0), "Invalid address");
        require(amount > 0, "Amount must be greater than zero");

        balances[to] += amount;
        totalSupply += amount;
        emit TokensMinted(to, amount);
    }

    // Function to allow users to recycle and claim reward tokens
    function recycle(uint256 amount) public {
        require(amount > 0, "Amount must be greater than zero");

        // Mint new tokens as a reward for recycling
        // mintTokens(msg.sender, amount);

        // Emit the Recycle event
        emit Recycle(msg.sender, amount);
    }

    // Function to check the balance of an address
    function balanceOf(address account) public view returns (uint256) {
        return balances[account];
    }
}
