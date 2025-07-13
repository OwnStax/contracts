// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract ContentStorage {
    mapping(address => string[]) private contentsOfUser;

    function addContent(address user, string memory content) public {
        contentsOfUser[user].push(content);
    }

    function getContentsOfUser(address user) public view returns (string[] memory) {
        return contentsOfUser[user];
    }
}
