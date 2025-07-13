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

    function test_RegisterSocialMedia() public {
        address socialMedia1 = address(0x1234567890123456789012345678901234567890);
        address socialMedia2 = address(0x0987654321098765432109876543210987654321);
        
        vm.prank(socialMedia1);
        contentStorage.registerSocialMedia();
        
        vm.prank(socialMedia2);
        contentStorage.registerSocialMedia();
        
        vm.prank(socialMedia1);
        assertTrue(contentStorage.isSocialMediaRegistered());
        
        vm.prank(socialMedia2);
        assertTrue(contentStorage.isSocialMediaRegistered());
    }

    function test_GetRegisteredSocialMedias() public {
        address socialMedia1 = address(0x1234567890123456789012345678901234567890);
        address socialMedia2 = address(0x0987654321098765432109876543210987654321);
        
        vm.prank(socialMedia1);
        contentStorage.registerSocialMedia();
        
        vm.prank(socialMedia2);
        contentStorage.registerSocialMedia();
        
        address[] memory registered = contentStorage.getRegisteredSocialMedias();
        assertEq(registered.length, 2);
        assertEq(registered[0], socialMedia1);
        assertEq(registered[1], socialMedia2);
    }

    function test_SocialMediaNotRegistered() public {
        address unregisteredSocialMedia = address(0x1111111111111111111111111111111111111111);
        
        vm.prank(unregisteredSocialMedia);
        assertFalse(contentStorage.isSocialMediaRegistered());
    }

    function test_RevertDuplicateSocialMediaRegistration() public {
        address socialMedia = address(0x1234567890123456789012345678901234567890);
        
        vm.prank(socialMedia);
        contentStorage.registerSocialMedia();
        
        vm.prank(socialMedia);
        vm.expectRevert(abi.encodeWithSelector(ContentStorage.socialMediaAlreadyRegistered.selector, socialMedia));
        contentStorage.registerSocialMedia();
    }
}
