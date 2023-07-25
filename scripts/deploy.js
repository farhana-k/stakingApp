const hre = require("hardhat");

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const stakingcontract = await ethers.deployContract("StakingContract", []);

  await stakingcontract.waitForDeployment();

  console.log("StakingContract deployed to:", await stakingcontract.getAddress());

}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });