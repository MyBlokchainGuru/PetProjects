pragma solidity ^0.5.1;

//ERC20 Contract ABI
contract ERC20 {
    function transferFrom(address from, address to, uint256 value) external returns (bool);
    function balanceOf(address who) external view returns (uint256);
}

//ERC1155 Contract ABI
contract ERC1155 {
    function safeMint(address to, uint256 id, uint256 amount, bytes memory metadata ) external returns (bool);
    function balanceOf(address tokenHolder, uint256 tokenId) public view returns (uint balance);
    function safeTransferFrom(address from, address to, uint256 tokenId, uint256 amount, bytes memory metadata) external returns (bool);
}

contract Swap {
    address public ERC20_Token;
    address public ERC1155_Token;
    string public metadataURL = "https://example.com/metadata.json";
    uint256 public ERC20_Amount = 1000;
    
    //Constructor
    constructor(address _ERC20_Token, address _ERC1155_Token) public {
        require(address(_ERC20_Token).isContract());
        require(address(_ERC1155_Token).isContract());
        ERC20_Token = _ERC20_Token;
        ERC1155_Token = _ERC1155_Token;
    }
    
    //Swap Function
    function swap(address from) public {
        //Check if user has enough balance
        ERC20 erc20 = ERC20(ERC20_Token);
        require(erc20.balanceOf(from) >= ERC20_Amount);
        
        //Transfer from user to contract
        erc20.transferFrom(from, address(this), ERC20_Amount);
        
        //Mint ERC1155 token with metadata
        bytes memory metadata = abi.encodeWithSignature("metadataURL()", metadataURL);
        ERC1155 erc1155 = ERC1155(ERC1155_Token);
        erc1155.safeMint(from, 0, ERC20_Amount, metadata);
    }
}
