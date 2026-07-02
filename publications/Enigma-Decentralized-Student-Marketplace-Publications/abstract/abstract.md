# Abstract

Enigma is a decentralized peer-to-peer marketplace for students, realized as three cooperating Ethereum smart contracts (EnigCredit, Marketplace, Reputation) and a dual-network web client. Participants transact in EnigCredit (ENGC), an ERC-20 credit token; listings are recorded on-chain; payments are held in escrow until the buyer confirms delivery; and completed trades yield tamper-evident participant reputation. We describe the modular "vertical slice" architecture, the security properties each contract enforces (owner-gated issuance, a checks-effects-interactions escrow, and one rating per participant per completed sale), and an evaluation on a local Foundry/Anvil chain and the public Sepolia testnet. All four slices pass their suites (31/31 tests, including fuzz and invariant tests) with no high-severity Slither findings.

**Index Terms** — blockchain, smart contracts, ERC-20, escrow, reputation, Ethereum, marketplace, decentralization
