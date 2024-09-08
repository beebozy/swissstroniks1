// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract stakeEther {
    // Declare the owner
    address public owner;

    // Define mappings
    mapping(address => uint256) public balances;

    // Events
    event DepositSuccessful(address indexed depositor, uint256 amount);
    event WithdrawalSuccessful(address indexed receiver, uint256 amount);

    // Custom Errors
    error AddressZeroDetected();
    error InsufficientBalance();
    error FailedTransfer();
    error InsufficientContractBalance();

    // Modifier to check if the sender is the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    // Constructor: Set the contract deployer as the owner
    constructor() {
        owner = msg.sender;
    }

    // Stake function: Allows users to deposit Ether into the contract
    function stake() external payable {
        require(msg.sender != address(0), "Address zero cannot deposit");
        require(msg.value > 0, "You cannot deposit an amount of zero");

        balances[msg.sender] += msg.value;

        emit DepositSuccessful(msg.sender, msg.value);
    }

    // Withdraw function: Only the owner can withdraw Ether from the contract to a specific receiver
    function withdraw(uint256 amount, address payable receiver) external onlyOwner {
        require(receiver != address(0), "Address zero cannot receive");
        require(amount <= address(this).balance, "Insufficient contract balance");

        // Attempt to transfer the amount to the receiver
        (bool success, ) = receiver.call{value: amount}("");
        require(success, "Failed to transfer Ether");

        emit WithdrawalSuccessful(receiver, amount);
    }

    // Function to get contract balance (can be used for external querying)
    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
