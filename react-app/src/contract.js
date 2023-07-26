import Web3 from "web3";
import StakingContract from "./contracts/StakingContract.json"
  const ethereum = window.ethereum;

  const web3 = new Web3(ethereum);

  const ContractAddress = "0x2A5a33A2cFbC11C15Cf1697019d58AD8Caf70886";
  const ContractAbi = StakingContract.abi;
  const myContract = new web3.eth.Contract(
    ContractAbi,
    ContractAddress
  );

  export default myContract;