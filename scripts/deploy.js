const hre = require("hardhat");

// const tokens = (n) => {
//   return ethers.utils.parseUnits(n.toString(), 'ether')
// }

async function main() {

  // Deploy YieldAggregator
  const YieldAggregator = await ethers.getContractFactory('YieldAggregator')
  const yieldAggregator = await YieldAggregator.deploy()
  await yieldAggregator.deployed()

  console.log(`Deployed YieldAggregator Contract at: ${yieldAggregator.address}`)
  console.log(`Finished.`)
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
