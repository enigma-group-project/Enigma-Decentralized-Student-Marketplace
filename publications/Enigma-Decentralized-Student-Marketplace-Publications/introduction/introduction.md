# Introduction

> Markdown mirror of §I–§IV of the final paper (Introduction, Related Research, Motivating Example & Threat Model, Why Blockchain).

## I. Introduction

Online marketplaces concentrate trust, custody, and dispute resolution in a single intermediary that charges fees. Replacing that intermediary with public smart contracts makes custody, settlement, and reputation auditable and removes a single point of failure. We present Enigma, a minimal but complete marketplace in which value, listings, escrow, and reputation are all enforced on-chain.

Enigma is engineered as four *vertical slices*, each owned by one team member and spanning a contract function set, a front-end module, and a test suite: (1) Token + Wallet, (2) Listings, (3) Escrow and Ratings, and (4) Reputation. This decomposition lets members work and be evaluated independently while sharing one deployed system.

## II. Related Research

Decentralized marketplaces such as OpenBazaar showed that listings and payments can operate without a central operator, and Ethereum made programmable escrow and tokens practical; value is standardized by EIP-20 and EIP-2612, and production security is inherited from audited libraries — OpenZeppelin being the de-facto standard. A parallel literature documents failure modes: Atzei et al. catalogue reentrancy and transaction-ordering attacks that motivate the checks-effects-interactions discipline, while Slither and Foundry provide static analysis and fuzz/invariant testing. Our contribution is not a new primitive but a teaching-oriented, fully on-chain marketplace composing token, escrow, and reputation into one reproducibly tested system of independently owned slices.

## III. Motivating Example and Threat Model

Consider two students, Alice and Bob, who have never met. Alice lists a used textbook; Bob wants to buy it with campus credits. On a conventional platform a trusted intermediary custodies Bob's payment, decides whether Alice delivered, and records reputation — a single point of control, fees, and failure. Enigma removes the intermediary: Bob's ENGC is locked in a smart-contract **escrow** the instant he purchases; Alice can verify the funds are committed; and the contract releases them to Alice only when Bob confirms delivery, or refunds Bob after a timeout if she never delivers. Every step — issuance, listing, escrow, and the resulting rating — is recorded on a public ledger that neither party, nor any platform operator, can silently alter.

### Threat model

We assume mutually distrusting buyers and sellers, a curious public (all on-chain data is world-readable), and an adversary able to submit arbitrary transactions.

- **Adversary goals:** steal escrowed funds, obtain goods without paying, mint credits without authority, or forge and inflate reputation.
- **Capabilities:** reentrant callbacks during token transfers, replayed or front-run transactions, malicious or non-compliant ERC-20 interactions, and calls from unauthorized accounts.
- **Trust assumptions:** the Ethereum consensus layer is honest; the Solidity 0.8.20 compiler and OpenZeppelin v5.1.0 libraries are trusted; *no* off-chain trusted third party arbitrates trades.
- **Defensive posture:** owner-gated issuance, checks-effects-interactions ordering with `ReentrancyGuard` and `SafeERC20`, one-rating-per-participant-per-completed-sale binding, a `Pausable` emergency stop, and checked arithmetic with explicit custom errors.

The central risk is a settlement-time violation in which a buyer or seller extracts value before the contract reaches a consistent state; escrow ordering and reentrancy guards close this window.

## IV. Why Blockchain: Suitability and Compatibility

**Why blockchain.** Community commerce — students trading goods — pairs mutually distrusting parties with frequent, low-value transactions for which a central intermediary adds fees, custody risk, and opacity. By the criteria of Wüst and Gervais, a blockchain is warranted when state must be stored, multiple mutually distrusting parties write it, no trusted third party is desired, and public verifiability is valuable — all of which Enigma meets, since balances, listings, escrow, and reputation are shared state written by untrusting buyers and sellers with no escrow operator and where auditability is the central feature.

**Suitability metrics.** The design realizes the properties that justify a public, permissionless chain: *disintermediation*, *trustlessness*, *immutability and auditability*, *transparency*, *availability*, and *interoperability* (ENGC follows EIP-20 and EIP-2612, composing with any wallet). The same escrow-plus-reputation pattern underlies resale, freelance milestones, and rental deposits; what distinguishes Enigma is rigor — built exclusively on audited standards with explicit, enforced, and reproducibly tested security.
