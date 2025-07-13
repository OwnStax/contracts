// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import { ContentStorage } from "../src/ContentStorage.sol";

contract ContentStorageTest is Test {
    ContentStorage public contentStorage;

    function setUp() public {
        contentStorage = new ContentStorage();
    }

    function test_AddAndGetContentsOfUser() public {
        contentStorage.addContent("content1");
        contentStorage.addContent("content2");
        contentStorage.addContent("content3");
        
        // assert content 1, 2, 3 are in the contents of the user
        assertEq(contentStorage.getContentsOfUser()[0], "content1");
        assertEq(contentStorage.getContentsOfUser()[1], "content2");
        assertEq(contentStorage.getContentsOfUser()[2], "content3");
    }
}
