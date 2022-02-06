const main = async () => {
    const nftContractFactory = await hre.ethers.getContractFactory('MembershipEngine');


    // Step 1: This is to deploy a new contract
    
    /*
    const nftContract = await nftContractFactory.deploy();
    await nftContract.deployed();
    console.log("Contract deployed to:", nftContract.address);
    */

    //Step 2: This is to interact with deployed contract
    
     const nftContract = await nftContractFactory.attach(
         "0x1d27cf0d740a57c427A5839D13eb05c7096AEffD"
     );

    let newMembership = await nftContract.initiateTransfer(1000);

    // Wait for it to be mined.
    await newMembership.wait();

    let newMembershipRewards = await nftContract.getMembershipRewardBalance();
    console.log("Membership reward is :", newMembershipRewards);

    let ownerOfMembershipTokenId = await nftContract.ownerOfMembership(1);
    console.log("Owner of membership is :", ownerOfMembershipTokenId);

    // newMembership = await nftContract.initiateTransfer(2000);
    // newMembershipRewards = await nftContract.getMembershipRewardBalance();
    // console.log("New Membership reward is :", newMembershipRewards);

    // newMembership = await nftContract.initiateTransfer(4500);
    // newMembershipRewards = await nftContract.getMembershipRewardBalance();
    // console.log("New Membership reward is :", newMembershipRewards);
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
