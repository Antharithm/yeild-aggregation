const { ethers } = require("ethers");
const axios = require("axios"); // request abis from etherscan
require("dotenv").config();

const provider = new ethers.providers.getDefaultProvider(
  "http://127.0.0.1:8545/"
);
const wethAddress = "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2";
const curveAddress = "0xbEbc44782C7dB0a1A60Cb6fe97d0b483032FF1C7"; // DAI/UDSC/USDT/pool
const url = `https://api.etherscan.io/api?module=contract&action=getabi&address=${curveAddress}&apikey=`;

async function main() {
  const wallet = new ethers.Wallet(process.env.PRIVATE_KEY); // local hardhat secret key
  const connectedWallet = wallet.connect(provider);

  const ERC20ABI = require("./abi.json");
  const wethContract = new ethers.Contract(wethAddress, ERC20ABI, provider);
  const name = await wethAddress.name();

  console.log("--------------");
  console.log("Contract Name:", name); // expecting 'wrapped ether'
  console.log("--------------");
}
