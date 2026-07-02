# Slice 3 — Escrow and Ratings

> Markdown mirror of §VI-C of the final paper. Owner: **Member 3**.

Escrow custodies ENGC between purchase and delivery. `purchaseItem(id)` pulls the listing price via `transferFrom` into the contract — the buyer must `approve` first — and moves the listing to `Pending`; `purchaseWithPermit` performs the same authorization with an EIP-2612 signature in a single transaction. `confirmDelivery` releases the held funds to the seller and marks the listing `Sold`; `cancelPurchase` refunds the buyer after `CANCELLATION_TIMEOUT` (trustless dispute resolution). All token movements use `SafeERC20` and follow the checks-effects-interactions order under `ReentrancyGuard`, so state is updated before external calls.
