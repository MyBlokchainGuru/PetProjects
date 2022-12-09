pragma solidity ^0.5.1;

// Interface with ERC20 token contract
interface ERC20Interface {
    function transfer(address to, uint256 value) external returns (bool);
}

contract SplitFunds {
    address payable public walletA;
    address payable public walletB;

    constructor(address payable _walletA, address payable _walletB) public {
        walletA = _walletA;
        walletB = _walletB;
    }

    // Split funds function
    function splitFunds(address tokenContract, uint256 value) public onlySenderWalletAOrB {
        ERC20Interface(tokenContract).transfer(walletA, value / 2);
        ERC20Interface(tokenContract).transfer(walletB, value / 2);
    }

    // Modifier to restrict access to only sender, walletA or walletB
    modifier onlySenderWalletAOrB {
        require(msg.sender == walletA || msg.sender == walletB);
        _;
    }
}
