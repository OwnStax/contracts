// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract ContentStorage {
    mapping(address => string[]) private contentsOfUser;
    mapping(address => mapping(bytes32 => bool)) private userContentHashes;
    mapping(address => bool) private registeredSocialMedias;
    address[] private socialMediaList;

    function addContent(string memory content) public {
        bytes32 contentHash = keccak256(abi.encodePacked(content));
        
        if (doesContentExist(msg.sender, content)) {
            revert contentExists(msg.sender, content);
        }
        
        contentsOfUser[msg.sender].push(content);
        userContentHashes[msg.sender][contentHash] = true;
    }

    function getContentsOfUser() public view returns (string[] memory) {
        return contentsOfUser[msg.sender];
    }

    function doesContentExist(address user, string memory content) public view returns (bool) {
        bytes32 contentHash = keccak256(abi.encodePacked(content));
        return userContentHashes[user][contentHash];
    }

    function registerSocialMedia() public {
        if (isSocialMediaRegistered()) {
            revert socialMediaAlreadyRegistered(msg.sender);
        }
        registeredSocialMedias[msg.sender] = true;
        socialMediaList.push(msg.sender);
    }

    function unregisterSocialMedia() public {
        if (!isSocialMediaRegistered()) {
            revert socialMediaNotRegistered(msg.sender);
        }
        registeredSocialMedias[msg.sender] = false;
        
        // Remove from socialMediaList
        for (uint i = 0; i < socialMediaList.length; i++) {
            if (socialMediaList[i] == msg.sender) {
                // Replace with last element and pop
                socialMediaList[i] = socialMediaList[socialMediaList.length - 1];
                socialMediaList.pop();
                break;
            }
        }
    }

    function isSocialMediaRegistered() public view returns (bool) {
        return registeredSocialMedias[msg.sender];
    }

    function getRegisteredSocialMedias() public view returns (address[] memory) {
        return socialMediaList;
    }

    error contentExists(address user, string content);
    error socialMediaAlreadyRegistered(address socialMedia);
    error socialMediaNotRegistered(address socialMedia);
}
