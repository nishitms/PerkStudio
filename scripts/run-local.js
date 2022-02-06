const main = async () => {
    const nftContractFactory = await hre.ethers.getContractFactory('MembershipEngine');
    const nftContract = await nftContractFactory.deploy();
    await nftContract.deployed();
    console.log("Contract deployed to:", nftContract.address);

    let newMembership = await nftContract.initiateTransfer(1000);

    // Wait for it to be mined.
    await newMembership.wait();

    let newMembershipRewards = await nftContract.getMembershipRewardBalance();
    
    console.log("Membership reward is :", newMembershipRewards);

    let ownerOfMembershipTokenId = await nftContract.ownerOfMembership(0);
    
    console.log("Owner of membership is :", ownerOfMembershipTokenId);

    newMembership = await nftContract.initiateTransfer(2000);

    newMembershipRewards = await nftContract.getMembershipRewardBalance();
    
    console.log("New Membership reward is :", newMembershipRewards);
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