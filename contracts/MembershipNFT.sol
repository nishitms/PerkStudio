// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "./MembershipFactory.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract MembershipNFT is MembershipFactory, ERC721URIStorage {

    constructor() ERC721 ("PerkStudio", "PSM") {
        // console.log("This is my Membership NFT contract. Woah!");
    }

    function makeMembershipNFT() internal {
        // Get the latest tokenId, which the factory created.
        uint256 nftTokenId = createNewMembership();

        // Actually mint the NFT to the sender using msg.sender.
        _safeMint(msg.sender, nftTokenId);

        // Set the NFTs data.
        _setTokenURI(nftTokenId, "{CompanyName:'CryptDonalds'}}");
        console.log("An NFT w/ ID %s has been minted to %s", nftTokenId, msg.sender);
    }

    function ownerOfMembership(uint256 _tokenId) public view returns (address _owner) {
        return membershipToOwner[_tokenId];
    }
}