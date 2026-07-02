# System Architecture and Threat Mitigations

> Markdown mirror of §V of the final paper.

Enigma comprises three Solidity 0.8.20 contracts on the audited OpenZeppelin v5.1.0 library set — `EnigCredit` (ERC-20), `Marketplace` (listings and escrow), and `Reputation` — with a vanilla ethers.js front end targeting a local Anvil chain (chainId 31337) or Sepolia (11155111) at runtime; reads use a JSON-RPC provider and writes are wallet-signed.

**Security by standards.** Security is inherited from standards rather than hand-rolled: each primitive reuses an audited OpenZeppelin module, and ENGC is a standard ERC-20 with EIP-2612 `permit` for off-chain approvals. The threat mitigations of the threat model (owner-gated issuance, CEI ordering with `ReentrancyGuard`/`SafeERC20`, one-rating-per-participant-per-sale binding, a `Pausable` stop, and checked arithmetic) are realized directly atop these audited modules, and verified in CI by unit, fuzz, and invariant tests alongside Slither static analysis.

| Threat | Mitigation |
| --- | --- |
| Unauthorized credit issuance | `Ownable` owner-only `mint`; faucet capped + rate-limited |
| Settlement-time value extraction (reentrancy) | escrow custody + CEI ordering, `ReentrancyGuard`, `SafeERC20` |
| Reputation forgery / inflation | one rating per completed sale, bound to the verified buyer |
| Operating during an incident | `Pausable` emergency stop |
| Arithmetic overflow | Solidity 0.8 checked arithmetic + explicit custom errors |
