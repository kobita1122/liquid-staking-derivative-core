const hre = require("hardhat");

async function main() {
  const StakedAsset = await hre.ethers.getContractFactory("StakedAsset");
  const lsd = await StakedAsset.deploy();

  await lsd.waitForDeployment();
  console.log(`LSD Contract deployed to: ${await lsd.getAddress()}`);
}

main().catch((error) => {
  console.error(error);
  process.exit(1);
});
