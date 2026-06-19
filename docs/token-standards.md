# Token Standards Matrix & This Prototype's Classification

> From **Ethereum-Token-v2026.pdf** §"Architectural Selection".

| Standard | Spectrum | Data structure | Use case |
|----------|----------|----------------|----------|
| **ERC-20** (fungible) | identical, divisible | `mapping(address=>uint256)` | currencies, **utility/credit tokens** |
| **ERC-721** (non-fungible) | unique | `mapping(uint256=>address)` | unique credentials, deeds |
| **ERC-1155** (multi-token) | hybrid batches | `mapping(uint256=>mapping(address=>uint256))` | gaming inventories |

## How this prototype maps
- **Classification:** **ERC-20** — `EnigCredit (ENGC)` is the marketplace's medium of exchange (built on OpenZeppelin `ERC20` + `Ownable`). The `Marketplace` contract is a custom escrow/ratings contract that *uses* the ERC-20 via `IERC20`.
- **Native implementation via OpenZeppelin:** `ERC20.sol` (transfers/balances/allowances) + `Ownable.sol` (mint authority) + `ReentrancyGuard.sol` (escrow safety). The lesson's "secure inheritance" pattern.
- **Implemented baseline:** OZ `ERC20Burnable` (mint+burn) + `ERC20Permit` (**ERC-2612**, gasless approvals) + `SafeERC20` (safe external calls) + `Pausable` (emergency stop).
- **If extended further:** ERC-4626 if credits became yield-bearing; ERC-1155 if listings became batched on-chain assets; ERC-5679 standardized mint/burn.

Specs: ERC-20 https://ethereum.org/en/developers/docs/standards/tokens/erc-20/ · EIP-20 defines ERC-20.
