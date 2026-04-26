// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

contract ERC20 {
    string public name;
    string public symbol;
    uint256 public totalSupply;
    uint8 public decimals = 18;

    address public owner;

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    constructor(
        string memory _name,
        string memory _symbol,
        uint256 _totalSupply
    ) {
        name = _name;
        symbol = _symbol;
        totalSupply = _totalSupply;
        owner = msg.sender;

        balanceOf[msg.sender] = _totalSupply;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "not owner");
        _;
    }
    event Transfer(address indexed from, address indexed to, uint256 amount);

    function transfer(address _to, uint256 _amount) public returns (bool) {
        require(_to != address(0), "invalid address");
        require(balanceOf[msg.sender] >= _amount, "NOT ENOUGH BALANCE");
        balanceOf[msg.sender] -= _amount;
        balanceOf[_to] += _amount;
        emit Transfer(msg.sender, _to, _amount);
        return true;
    }

    function mint(address _to, uint256 _amount) public onlyOwner {
        require(_to != address(0), "invalid address");
        balanceOf[_to] += _amount;
        totalSupply += _amount;
        emit Transfer(address(0), _to, _amount);
    }

    function burn(uint256 _amount) public {
        require(balanceOf[msg.sender] >= _amount, "no enough balance");

        balanceOf[msg.sender] -= _amount;
        totalSupply -= _amount;
        emit Transfer(msg.sender, address(0), _amount);
    }

    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 amount
    );

    function approve(address spender, uint256 amount) public returns (bool) {
        require(spender != address(0), "invalid address");
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public returns (bool) {
        require(to != address(0), "invalid address");
        require(balanceOf[from] >= amount, "not enough balance");
        require(allowance[from][msg.sender] >= amount, "not allowed");

        balanceOf[from] -= amount;
        balanceOf[to] += amount;

        allowance[from][msg.sender] -= amount;
        emit Transfer(from, to, amount);
        return true;
    }
}

