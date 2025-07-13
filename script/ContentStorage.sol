// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {ContentStorage} from "../src/ContentStorage.sol";

contract ContentStorageScript is Script {
    ContentStorage public contentStorage;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        contentStorage = new ContentStorage();
        vm.stopBroadcast();
    }
}
