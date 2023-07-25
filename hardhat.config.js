require("@nomicfoundation/hardhat-toolbox");

require('dotenv').config();

module.exports = {
  solidity: '0.8.0',
  networks: {
    goerli: {
      url: `https://goerli.infura.io/v3/${process.env.INFURA_PROJECT_ID}`,
      accounts: {
        mnemonic: process.env.MNEMONIC,
      },
    },
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY,
  },
};

// /** @type import('hardhat/config').HardhatUserConfig */
// module.exports = {
//   solidity: "0.8.0",
//   networks: {
//     ganache: {
//       url: "http://localhost:8545", // URL to your Ganache instance
//       chainId: 1337, // Chain ID of Ganache (default is 1337)
//       gasPrice: 20000000000, // Gas price for transactions (optional)
//       accounts: {
//         mnemonic: "keen accident inform thumb source lens candy weather dilemma right mystery diary", // Mnemonic of your Ganache accounts
//       },
//     },
//   },
// };



