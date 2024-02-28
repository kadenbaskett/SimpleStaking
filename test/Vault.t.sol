// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import { Test } from "forge-std/Test.sol";
import { TokenVault } from "../src/Vault.sol";
import { EON } from "../src/Eon.sol";

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract TokenizedVaultTest is Test {
    TokenVault vault;
    EON eon;

    function setUp() public {
        eon = new EON();
        eon.mint(address(this), 10000);
        vault = new TokenVault(address(eon), 'Perspect EON', 'pEON');
    }

    function testVault() public {
        eon.approve(address(vault), 10000);
        vault._deposit(10000);

        uint256 userBalance = vault.shareValueOfUser(address(this));
        assertEq(userBalance, 10000);
        assertEq(vault.totalAssets(), 10000);

        assertEq(ERC20(vault).balanceOf(address(this)), 10000);

        vault._withdraw(5000, address(this));

        uint256 userBalanceAfterWithdraw = vault.shareValueOfUser(address(this));
        assertEq(userBalanceAfterWithdraw, 5000);
        assertEq(vault.totalAssets(), 5000);
    }

       function testERC20() public {
        assertEq(vault.name(), 'Perspect EON');
        assertEq(vault.symbol(), 'pEON');
    }
}
