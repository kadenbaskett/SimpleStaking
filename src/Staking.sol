// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract StakingContract is Ownable {
    mapping(address => uint256) public stakes;

    event Staked(address indexed staker, uint256 amount);
    event Unstaked(address indexed staker, uint256 amount);
    event Withdrawn(address indexed recipient, uint256 amount);

    constructor() Ownable(msg.sender) {}

    function stake() external payable {
        uint256 amount = msg.value;
        require(amount > 0, "Amount must be greater than 0");

        stakes[msg.sender] += amount;

        emit Staked(msg.sender, amount);
    }

    function unstake(uint256 _amount) external {
        require(_amount > 0 && _amount <= stakes[msg.sender], "Invalid unstake amount");

        payable(msg.sender).transfer(_amount);

        stakes[msg.sender] -= _amount;

        emit Unstaked(msg.sender, _amount);
    }

    function getStakeBalance(address _staker) external view onlyOwner returns (uint256) {
        return stakes[_staker];
    }

    function withdraw(address payable _recipient, uint256 _amount) external onlyOwner {
        require(_recipient != address(0), "Invalid recipient address");
        require(_amount <= address(this).balance, "Insufficient balance");

        _recipient.transfer(_amount);

        emit Withdrawn(_recipient, _amount);
    }
}
