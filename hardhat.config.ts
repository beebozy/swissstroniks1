import { HardhatUserConfig } from "hardhat/config";
import { vars } from "hardhat/config";

import "@nomicfoundation/hardhat-toolbox";



// Fetching the private key from environment variables
const PRIVATE_KEY = vars.get("PRIVATE_KEY");;

// Hardhat configuration
//contract address  0x0e01d7F1C09cC063D3d40983D871d6d6297356B8
// verify 0xD3Bf935b00647732888D785C2674965fd803F8b9
const config: HardhatUserConfig = {
  defaultNetwork: "swisstronik",
  solidity: "0.8.24",
  networks: {
    swisstronik: {
      url: "https://json-rpc.testnet.swisstronik.com/",
      accounts: [`0x${PRIVATE_KEY}`], // Concatenate with "0x"
    },
  },
};

export default config;
