// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StakingToken {
    string public name = "Staking Token";
    string public symbol = "STT";
    uint8 public decimals = 8;
    uint256 public totalSupply = 500_000_000 * 10**uint256(decimals);

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor() {
        balanceOf[msg.sender] = totalSupply; // mint 500m (total supply) tokens to the deployer's address
    }

    // function to transfer funds
    function transfer(address to, uint256 value)  public returns (bool) {
        require(to != address(0), "Invalid recipient");
        require(value <= balanceOf[msg.sender], "Insufficient balance");

        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;

        emit Transfer(msg.sender, to, value);
        return true;
    }

    // function to increase allowance
    function approve(address spender, uint256 value) public returns (bool) {
        allowance[address(this)][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    // returns balance 
    function balance(address addr) public  view returns (uint256) {
        return balanceOf[addr];
    }

    // transfer on behalf of an account to another account
    function transferFrom(
        address from,
        address to,
        uint256 value
    ) public returns (bool) {
        require(from != address(0), "Invalid sender");
        require(to != address(0), "Invalid recipient");
        require(value <= balanceOf[from], "Insufficient balance");
        require(value <= allowance[from][to], "Allowance exceeded");

        balanceOf[from] -= value;
        balanceOf[to] += value;
        allowance[from][msg.sender] -= value;

        emit Transfer(from, to, value);
        return true;
    }

}

