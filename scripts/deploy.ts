import { ethers, upgrades } from "hardhat";

const linkTokenAddress = "0x779877A7B0D9E8603169DdbD7836e478b4624789";

async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Contract Deployer Address:", await deployer.getAddress());
  const deployerAddress = await deployer.getAddress();
  const operatorFactory = await ethers.getContractFactory("Operator");

  const operatorContractDeploy: any = await upgrades.deployProxy(
    operatorFactory,
    [
      linkTokenAddress,
      deployerAddress,
    ],
    {
      initializer: "__Operator_init",
    }
  );

  await operatorContractDeploy.waitForDeployment();
  const deployedAddress: any = await operatorContractDeploy.getAddress();
  console.log(`Operator Contract Address:${deployedAddress}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
