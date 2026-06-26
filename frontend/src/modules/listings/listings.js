import { connect, writeContracts, readContracts, mountNetworkSelector, net, parseTokens, formatTokens, STATUS } from "../../shared/app.js";
mountNetworkSelector("net");
const out = (m) => (document.getElementById("out").textContent = m);
const listEl = document.getElementById("list");
let signer, wc;

async function refreshListings() {
  try {
    const rc = readContracts();
    const total = Number(await rc.marketplace.totalListings());
    let html = "";

    for (let i = 0; i < total; i++) {
      const listing = await rc.marketplace.getListing(i);
      if (Number(listing.status) !== 0) continue;
      html += `<div class="listing">
        <strong>${listing.title}</strong> · ${listing.category} · ${listing.condition}
        <div>Price: ${formatTokens(listing.priceInTokens)} ENGC</div>
        <div>Seller: ${listing.seller}</div>
        <div><small>ID: ${listing.id}</small></div>
      </div>`;
    }

    listEl.innerHTML = html || "<p class=\"muted\">No available listings found.</p>";
    out(`Loaded ${total} listings.`);
  } catch (e) {
    out(String(e.message || e));
  }
}

async function connectWallet() {
  try {
    ({ signer } = await connect());
    wc = writeContracts(signer);
    document.getElementById("who").textContent = "Connected: " + (await signer.getAddress()) + " · " + net().label;
  } catch (e) {
    out(String(e.message || e));
  }
}

document.getElementById("connect").onclick = connectWallet;
document.getElementById("create").onclick = async () => {
  try {
    if (!wc) return out("Connect your wallet first.");
    const title = document.getElementById("title").value.trim();
    const category = document.getElementById("category").value.trim();
    const condition = document.getElementById("condition").value.trim();
    const price = document.getElementById("price").value.trim();
    const imageUrl = document.getElementById("imageUrl").value.trim();
    if (!title || !category || !condition || !price) return out("Please fill title, category, condition, and price.");

    const tx = await wc.marketplace.createListing(title, category, condition, parseTokens(price), imageUrl);
    const receipt = await tx.wait();
    const event = receipt.events?.find((e) => e.event === "ListingCreated");
    const id = event?.args?.id ?? "unknown";
    out(`Created listing ${id}`);
    await refreshListings();
  } catch (e) {
    out(String(e.message || e));
  }
};

document.getElementById("refresh").onclick = refreshListings;
refreshListings();
