# Slice 2 — Listings

> Markdown mirror of §VI-B of the final paper. Owner: **Member 2**.

The `Marketplace` contract records item listings. `createListing` stores a `Listing` (seller, ENGC price, item metadata, status); `getListing(id)` and `totalListings()` expose listings to the UI. Input validation rejects empty metadata (`EmptyTitle`) and non-positive prices (`BadPrice`), and each listing is assigned a monotonically increasing identifier. A seller may cancel an `Available` listing (`cancelListing`), and listing creation is guarded by `whenNotPaused`.
