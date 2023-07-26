import Web3 from "web3";
import StakingContract from "./contracts/StakingContract.json"
  const ethereum = window.ethereum;

  const web3 = new Web3(ethereum);

  // const ContractAddress = "0xfF4cAa274C92110210b26846C1a4151a317f7906";
  const ContractAddress = "0xa3236aCA68593A52A2475f3A6C6EbFA8df45CD30";
  const ContractAbi = StakingContract.abi;
  const myContract = new web3.eth.Contract(
    ContractAbi,
    ContractAddress
  );

  export default myContract;