// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "./MembershipNFT.sol";

contract MembershipEngine is MembershipNFT {
    uint rewardsRatio = 10;
    constructor() {
        console.log("This is my MembershipEngine contract. Whoa!");
    }

    function initiateTransfer(uint256 _amount) public {
        
        console.log("Received a transaction request for %s", _amount);
        //first check if this owner is a member
        if (getMembershipRewardsCount() == 0) {
            console.log("Creating a new membership NFT for this owner..");
            makeMembershipNFT();
        }

        //then add rewards to this owner according to the ratio
        _updateMembershipRewards(_amount);
    }

}