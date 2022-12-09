pragma solidity ^0.5.12;

contract RewardsTokenA {

    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    mapping (address => uint256) public balanceOf;
    mapping (address => mapping (address => uint256)) public allowance;

    // constructor
    constructor() public {
        name = "TokenA";
        symbol = "TA";
        decimals = 18;
        totalSupply = 100000000000000000;
        balanceOf[msg.sender] = totalSupply;
    }

    // transfer
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value && _value > 0);
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    // approve
    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    // transfer from
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_value <= allowance[_from][msg.sender]);
        allowance[_from][msg.sender] -= _value;
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(_from, _to, _value);
        return true;
    }

    // airdrop
    function airdrop(address _to, uint256 _value) public returns (bool success) {
        require(_value > 0);
        balanceOf[_to] += _value;
        emit Transfer(address(0), _to, _value);
        return true;
    }
// redeem
    function redeem(address _to, uint256 _value) public returns (bool success) {
        require(_value == 10000);
        balanceOf[_to] -= _value;
        emit Redeem(_to, _value);
        return true;
    }

    // airdrop nft
    function airdropNFT(address _to) public returns (bool success) {
        require(balanceOf[_to] == 10000);
        balanceOf[_to] = 0;
        emit AirdropNFT(_to);
        return true;
    }

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    event Redeem(address indexed _to, uint256 _value);
    event AirdropNFT(address indexed _to);
}
