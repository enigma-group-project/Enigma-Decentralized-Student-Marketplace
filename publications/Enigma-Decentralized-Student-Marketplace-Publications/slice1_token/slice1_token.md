# Slice 1 — Token and Wallet

> Markdown mirror of §VI-A of the final paper. Owner: **Member 1**.

`EnigCredit` is an ERC-20 token (name *EnigCredit*, symbol *ENGC*, 18 decimals) deriving from OpenZeppelin `ERC20`, `ERC20Burnable`, `ERC20Permit`, and `Ownable`. The constructor mints a 1,000,000 ENGC initial supply to the deployer, who becomes the owner. Issuance is restricted: `mint(to, amount)` is guarded by `onlyOwner` so only the faculty/owner account can airdrop demo credits, and non-owner calls revert. Standard `transfer` and `approve` provide the value movement and allowances consumed by the escrow slice; `permit` (EIP-2612) enables gasless approvals. The front-end token module connects a wallet, displays the live ENGC balance, and exposes the owner-only mint form.

A public, capped `faucet()` provides self-serve demo top-ups (1,000 ENGC per claim, 1-hour per-wallet cooldown) without granting arbitrary minting.
