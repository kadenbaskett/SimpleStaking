// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC4626.sol";

contract TokenVault is ERC4626 {
    // a mapping that checks if a user has deposited the token
    mapping(address => uint256) public shareHolder;

    constructor(address _token, string memory _name, string memory _symbol) ERC4626(IERC20Metadata(_token)) ERC20(_name, _symbol) {}

    function _deposit(uint _assets) public {
        // checks that the deposited amount is greater than zero.
        require(_assets > 0, "Deposit less than Zero");
        // calling the deposit function from the ERC-4626 library to perform all the necessary functionality
        deposit(_assets, msg.sender);
        // Increase the share of the user
        shareHolder[msg.sender] += _assets;
    }

    function _withdraw(uint _shares, address _receiver) public {
        require(_shares > 0, "withdraw must be greater than Zero");
        require(_receiver != address(0), "Zero Address");
        require(shareHolder[msg.sender] > 0, "Not a share holder");
        require(shareHolder[msg.sender] >= _shares, "Not enough shares");
        
        // uint256 percent = (10 * _shares) / 100;
        // uint256 assets = _shares + percent;
        redeem(_shares, _receiver, msg.sender);
        shareHolder[msg.sender] -= _shares;
    }

    function shareValueOfUser(address _user) public view returns (uint256) {
        return shareHolder[_user];
    }
}