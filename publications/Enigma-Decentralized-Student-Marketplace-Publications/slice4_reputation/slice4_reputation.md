# Slice 4 — Reputation

> Markdown mirror of §VI-D of the final paper. Owner: **Member 4**.

The `Reputation` contract maintains an on-chain rating ledger intentionally decoupled from escrow, following the single-responsibility principle.

**Architecture.** Two functions are exposed: `rateUser(listingId, rating)` allows the verified buyer of a completed trade to submit a 1–5 star rating for the seller exactly once per listing; `getAverageRating(user)` returns the raw accumulator pair `(total, count)`, leaving division to the client to avoid integer truncation and save gas. State is stored in three mappings: `ratingTotal[seller]`, `ratingCount[seller]`, and `listingRated[listingId]`. Authentication is performed by reading `Marketplace.getListing(id)` and verifying `msg.sender == listing.buyer` and `listing.status == Status.Sold`.

**Threat model.** Four attack vectors are addressed. (1) *Rating manipulation:* the `NotBuyer` guard checks `msg.sender` against `listing.buyer`, recorded atomically during `purchaseItem`. (2) *Double rating:* the `listingRated` flag and `AlreadyRated` revert prevent score inflation via the CEI pattern. (3) *Reentrancy:* the `nonReentrant` modifier from OpenZeppelin's `ReentrancyGuard` guards the external `getListing` call. (4) *Unsold listing rating:* the `NotSold` guard ensures ratings only attach to completed trades.

**Trade-off evaluation.** Storing `(total, count)` and computing averages client-side preserves precision and saves ~5,000 gas over on-chain division, while a standalone `Reputation` contract enables independent upgrades and cleaner CODEOWNERS boundaries. Cross-contract authentication via `getListing` is trustless, needing no oracle or relayer. Measured cost is **120,280 gas** (`rateUser`, Anvil forge test); the premium over a ~65,000 estimate reflects the cross-contract call and loading string fields into memory.
