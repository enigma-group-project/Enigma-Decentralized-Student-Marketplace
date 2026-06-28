// Network config. GitHub Actions can replace the Sepolia placeholders during deployment.
// Local development falls back to the hardcoded values below.
export const NETWORKS = {
  anvil: {
    label: "Local Anvil (dev)", chainId: 31337, rpcUrl: "http://127.0.0.1:8545", explorer: "",
    addresses: { EnigCredit: "0x5fbdb2315678afecb367f032d93f642f64180aa3", Marketplace: "0xe7f1725e7734ce288f8367e1bb143e90bb3f0512", Reputation: "0x9fe46736679d2d9a65f0992f2272de9f3c7fa6e0" },
  },
  sepolia: {
    label: "Sepolia (hosted demo)", chainId: 11155111, rpcUrl: "https://ethereum-sepolia-rpc.publicnode.com", explorer: "https://sepolia.etherscan.io",
    addresses: {
      EnigCredit: "0x2F5be2bE888eAC7109a3DEa25b1bbdbC582716dA",
      Marketplace: "0xC3B7fFfa9cBEc0A06C910324aE903b6BcffE6b62",
      Reputation: "0x3683B4e6C636101c5F5863C2e6D5fBe1AB1D7DF8",
    },
  },
};
export const DEFAULT_NETWORK = "anvil";
