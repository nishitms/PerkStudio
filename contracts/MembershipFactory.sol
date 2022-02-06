// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./RewardsCoin.sol";

contract MembershipFactory {

    event NewMembership(uint256 membershipId, string businessName);

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() {
        // console.log("This is my MembershipFactory contract. Whoa!");
    }

    struct Membership {
        string businessName;
    }

    Membership[] public memberships;

    mapping (uint256 => address) public membershipToOwner;
    mapping (address => uint256) membershipRewards;

    function _createMembership(string memory _businessName) private returns (uint) {
        console.log("Creating new NFT from MembershipFactory");
        
        memberships.push(Membership(_businessName));
        uint256 newItemId = _tokenIds.current();
        membershipToOwner[newItemId] = msg.sender;
        
        _addNewReward(msg.sender);
        emit NewMembership(newItemId, _businessName);
        _tokenIds.increment();
        
        return newItemId;
    }

    function _addNewReward(address _address) private {
        //for now just increment the mapping
        membershipRewards[_address]++;
    }

    function _getMembershipRewards(address _address) private view returns (uint) {
        return membershipRewards[_address];
    }

    function _updateMembershipRewards(uint256 additionalRewards) internal {
        membershipRewards[msg.sender] = membershipRewards[msg.sender] + additionalRewards;
    }

    function createNewMembership() internal returns (uint) {
        return _createMembership("CrypDonalds");
    }

    function getMembershipRewardsCount() public view returns (uint) {
        return _getMembershipRewards(msg.sender);
    }
 }
