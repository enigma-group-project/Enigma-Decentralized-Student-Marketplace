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
      EnigCredit: "0x0e8e20790364724905390c7BfF1eb1B97116B1db",
      Marketplace: "0xf3d595a1920c995F8d643FF045BF9BF10EA0d51E",
      Reputation: "0x637b577921b4eA27cd31913489D2f243B9e997B0",
    },
  },
};
export const DEFAULT_NETWORK = "anvil";
