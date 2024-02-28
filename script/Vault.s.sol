// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {TokenVault} from "../src/Vault.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DeployVaultScript is Script {

    function setUp() public {}

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new TokenVault(0x60158131416F5e53D55D73A11BE2E203cB26Abcc, 'Perspect EON', 'pEON');   
        vm.stopBroadcast();  
    }
}
