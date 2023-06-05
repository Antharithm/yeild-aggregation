const hre = require("hardhat");

// const tokens = (n) => {
//   return ethers.utils.parseUnits(n.toString(), 'ether')
// }

async function main() {

  // Deploy YeildAggregator
  const YeildAggregator = await ethers.getContractFactory('YeildAggregator')
  const yeildAggregator = await YeildAggregator.deploy()
  await yeildAggregator.deployed()

  console.log(`Deployed YeildAggregator Contract at: ${yeildAggregator.address}`)
  console.log(`Finished.`)
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
