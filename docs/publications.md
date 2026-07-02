# 📄 Publications

## Enigma: A Decentralized Student Marketplace with Token Wallet, On-Chain Escrow, and Reputation

A 2-page **IEEE** conference paper describing the system, written as **modular LaTeX**: `main.tex`
consolidates one folder per section, with a **section per slice owned by each member** — so everyone
edits only their part.

### Read / review (no LaTeX needed)
Every section has a Markdown mirror:

- [Abstract](https://github.com/enigma-group-project/Enigma-Decentralized-Student-Marketplace/blob/main/publications/Enigma-Decentralized-Student-Marketplace-Publications/abstract/abstract.md) · [Introduction](https://github.com/enigma-group-project/Enigma-Decentralized-Student-Marketplace/blob/main/publications/Enigma-Decentralized-Student-Marketplace-Publications/introduction/introduction.md) · [Architecture](https://github.com/enigma-group-project/Enigma-Decentralized-Student-Marketplace/blob/main/publications/Enigma-Decentralized-Student-Marketplace-Publications/architecture/architecture.md)
- [Slice 1 — Token + Wallet (M1)](https://github.com/enigma-group-project/Enigma-Decentralized-Student-Marketplace/blob/main/publications/Enigma-Decentralized-Student-Marketplace-Publications/slice1_token/slice1_token.md) · [Slice 2 — Listings (M2)](https://github.com/enigma-group-project/Enigma-Decentralized-Student-Marketplace/blob/main/publications/Enigma-Decentralized-Student-Marketplace-Publications/slice2_listings/slice2_listings.md)
- [Slice 3 — Escrow + Ratings (M3)](https://github.com/enigma-group-project/Enigma-Decentralized-Student-Marketplace/blob/main/publications/Enigma-Decentralized-Student-Marketplace-Publications/slice3_escrow/slice3_escrow.md) · [Slice 4 — Reputation (M4)](https://github.com/enigma-group-project/Enigma-Decentralized-Student-Marketplace/blob/main/publications/Enigma-Decentralized-Student-Marketplace-Publications/slice4_reputation/slice4_reputation.md)
- [Evaluation](https://github.com/enigma-group-project/Enigma-Decentralized-Student-Marketplace/blob/main/publications/Enigma-Decentralized-Student-Marketplace-Publications/evaluation/evaluation.md) · [Conclusions](https://github.com/enigma-group-project/Enigma-Decentralized-Student-Marketplace/blob/main/publications/Enigma-Decentralized-Student-Marketplace-Publications/conclusions_future_work/conclusions_future_work.md) · [References](https://github.com/enigma-group-project/Enigma-Decentralized-Student-Marketplace/blob/main/publications/Enigma-Decentralized-Student-Marketplace-Publications/references/references.md)

### Source & compiled PDF
- **LaTeX source + README:** [`publications/` folder](https://github.com/enigma-group-project/Enigma-Decentralized-Student-Marketplace/tree/main/publications/Enigma-Decentralized-Student-Marketplace-Publications)
- **Compiled PDF:** builds in CI on every push — download the latest **`enigma-paper-pdf`** artifact from
  the [Build paper workflow](https://github.com/enigma-group-project/Enigma-Decentralized-Student-Marketplace/actions/workflows/build-paper.yml). *(Overleaf: upload the folder, set the main document to `main.tex`.)*

### Evaluation: gas and latency

Per-operation cost, **measured** via `forge test --gas-report` (avg per call) — all four slices implemented; the earlier engineering estimates are replaced by measured figures.

| Operation | Gas (measured) | Latency | Notes |
| --- | ---: | ---: | --- |
| `createListing` | ~248,900 | ~12 s | SSTORE-heavy write (struct + strings) |
| `purchaseItem` | ~111,800 | ~12 s | escrow `transferFrom` |
| `confirmDelivery` | ~65,600 | ~12 s | release to seller |
| `rateUser` | ~80,700 | ~12 s | rating storage |
| `mint` | ~38,700 | ~12 s | owner issuance |
| `transfer` | ~51,400 | ~12 s | ERC-20 value move |
| `burn` | ~33,900 | ~12 s | supply burn |
| `faucet` | ~53,600 | ~12 s | demo top-up |

> Latency ≈ one block confirmation: **Sepolia ~12 s**, **local Anvil < 1 s** (mines on demand). Gas is network-independent.

### Per-section ownership
| Section | Owner | Status |
| --- | --- | --- |
| Slice 1 — Token + Wallet | Member 1 | **complete** (10/10 tests, Anvil + Sepolia) |
| Slice 2 — Listings | Member 2 | **complete** (ListingsTest passing) |
| Slice 3 — Escrow + Ratings | Member 3 | **complete** (EscrowTest passing, incl. `purchaseWithPermit`) |
| Slice 4 — Reputation | Member 4 | **complete** (ReputationTest passing; measured 120,280 gas `rateUser`) |

> All four slices pass their suites — **32/32 tests** including fuzz/invariant (`Invariant.t.sol`) — with no high-severity Slither findings.
