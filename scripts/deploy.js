// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

// deploy.js
async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contracts with the account:", deployer.address);

   // Deploy StakingToken contract
  const stakingToken = await ethers.deployContract("StakingToken");
  await stakingToken.waitForDeployment();
  console.log("StakingToken deployed to:", await stakingToken.getAddress());


  // Deploy StakingContract contract
  const addr = await stakingToken.getAddress()
  // const stakingcontract = await ethers.deployContract("StakingContract", [addr]);
  const stakingcontract = await ethers.deployContract("StakingContract", []);
  await stakingcontract.waitForDeployment();
  console.log("StakingContract deployed to:", await stakingcontract.getAddress());
}

// Run the deployment script
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
