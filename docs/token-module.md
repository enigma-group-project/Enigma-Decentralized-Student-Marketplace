# Slice 1 — Token + Wallet (`EnigCredit.sol`)
> Owner: member1 · Branch: `feature/member1-token` · OpenZeppelin ERC-20 + Ownable.

## Implements
- `EnigCredit` ERC-20 (name EnigCredit, symbol ENGC, 18 decimals, 1,000,000 initial supply to deployer).
- `mint(to, amount)` owner-only (faculty airdrops demo credits).
- Frontend: connect wallet (identity), show ENGC balance, owner mint form.

## Tests (`test/EnigCredit.t.sol`)
metadata · initial supply · owner mint · non-owner revert · transfer.

## TODO checklist
- [ ] balance auto-refresh on account/chain change · [ ] "Switch to Sepolia" helper.

## Walkthrough

📸 Connect MetaMask + mint ENGC, step by step with screenshots: [`PROCEDURES.md` §A5b](PROCEDURES.md#a5b-token-module--connect-metamask--mint-engc-screenshot-walkthrough).
