# Screenshot resources — Token + Wallet walkthrough

These images back the **"A5b — Token module: connect MetaMask & mint ENGC"** section in
[`../../PROCEDURES.md`](../../PROCEDURES.md). Drop the PNGs here using the exact filenames
below and they will render inline in the doc.

> Capture at the default MetaMask side-panel width (~960px wide) so the annotations stay readable.

| Filename | What it should show |
| --- | --- |
| `01-connect-permissions.png` | dApp **Connect wallet** → MetaMask **Permissions** tab ("See your accounts", "Use your enabled networks") |
| `02-networks-edit.png` | Permissions → **Use your enabled networks → Edit** |
| `03-edit-networks-gochain.png` | **Edit networks** list with **GoChain Testnet** ticked (this *is* your local Anvil chain — chainId 31337) → **Update** |
| `04-accounts-edit.png` | Permissions → **See your accounts → Edit** (or the **Accounts** tab → Edit accounts) |
| `05-edit-accounts-select.png` | **Edit accounts** with the account you want ticked → **Connect** |
| `06-connect-confirm.png` | MetaMask connection dialog → **Connect** button |
| `10-mint-revert-nonowner.png` | Mint attempt from a **non-owner** account (e.g. Account 1 `0x58ee…6202b`) → red `execution reverted … CALL_EXCEPTION` output |
| `11-import-add-wallet.png` | MetaMask → **Add wallet → Import an account (Via a private key)** |
| `12-import-private-key.png` | **Add wallet → Private key** field + **Import** button |
| `13-owner-imported-balance.png` | Imported owner account `0xf39F…2266`, EnigCredit balance **1,000,000 ENGC** |
| `14-mint-confirm-tx.png` | MetaMask **Transaction request** for the mint → Interacting with `0x5FbD…80aa3` (EnigCredit) → **Confirm** |
| `15-mint-success.png` | dApp shows ✅ `Minted 100 ENGC … New balance: 1000100.0 ENGC` + MetaMask **Mint · Confirmed** |
| `20-alchemy-create-app.png` | Alchemy dashboard → **Create new app** (name `Enigma-Marketplace-Sepolia`) |
| `21-alchemy-choose-chain.png` | Alchemy → **Choose chains** → Ethereum **Sepolia** |
| `22-alchemy-app-rpc.png` | Alchemy app page → **Endpoint URL** / **API Key** (the value for `$SEPOLIA_RPC_URL`) |

If a screenshot is missing, the step text still stands on its own — the images are illustrative.

## ⚠️ Redact before committing

These images go into a **public** repo. Blur / black-box any of the following before adding a PNG here
(the CONTRIBUTING reviewer checklist explicitly checks for "no PII"):

- **Alchemy / Infura API keys** and full RPC endpoint URLs (`…/v2/<API-KEY>`) — e.g. in `22-alchemy-app-rpc.png`.
- **Private keys / seed phrases** — never capture the value in the import field (`12-import-private-key.png`).
- **Real wallet addresses** holding mainnet/testnet funds, real names, emails, or browser-profile avatars.
- Local Anvil dev addresses (`0xf39F…`, `0x5FbD…`) are the well-known public test accounts — safe to show.

> If a real secret was ever visible in a capture, **rotate it** (regenerate the Alchemy key, etc.) — blurring
> the image is not enough if the original was shared anywhere.
