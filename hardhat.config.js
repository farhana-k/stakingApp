require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.0",
  networks: {
    ganache: {
      url: "http://localhost:8545", // URL to your Ganache instance
      chainId: 1337, // Chain ID of Ganache (default is 1337)
      gasPrice: 20000000000, // Gas price for transactions (optional)
      accounts: {
        mnemonic: "keen accident inform thumb source lens candy weather dilemma right mystery diary", // Mnemonic of your Ganache accounts
      },
    },
  },
};
