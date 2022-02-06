const main = async () => {
    const nftContractFactory = await hre.ethers.getContractFactory('MembershipNFT');
    const nftContract = await nftContractFactory.deploy();
    await nftContract.deployed();
    console.log("Contract deployed to:", nftContract.address);

    let newMembership = await nftContract.makeMembershipNFT();

    // Wait for it to be mined.
    await newMembership.wait();

    let newMembershipRewards = await nftContract.getMembershipRewardsCount();
    
    console.log("Membership reward is :", newMembershipRewards);
  };
  
  const runMain = async () => {
    try {
      await main();
      process.exit(0);
    } catch (error) {
      console.log(error);
      process.exit(1);
    }
  };
  
  runMain();