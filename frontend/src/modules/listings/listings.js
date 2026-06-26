import { connect, writeContracts, readContracts, mountNetworkSelector, net, parseTokens, formatTokens } from "../../shared/app.js";
mountNetworkSelector("net");
const out = (m) => (document.getElementById("out").textContent = m);
const val = (id) => document.getElementById(id).value.trim();
let signer, wc;

document.getElementById("connect").onclick = async () => {
  try {
    ({ signer } = await connect());
    wc = writeContracts(signer);
    document.getElementById("who").textContent = "Connected: " + (await signer.getAddress()) + " · " + net().label;
  } catch (e) {
    out(String(e.message || e));
  }
};

document.getElementById("create").onclick = async () => {
  try {
    if (!wc) throw new Error("Connect a wallet first.");
    const title = val("title");
    const category = val("category");
    const condition = val("condition");
    const price = val("price");
    const imageUrl = val("imageUrl");
    if (!title || !category || !condition || !price) throw new Error("Fill out title, category, condition, and price.");

    out("Posting listing…");
    const tx = await wc.marketplace.createListing(title, category, condition, parseTokens(price), imageUrl);
    const receipt = await tx.wait();
    const id = receipt.events?.find((e) => e.event === "ListingCreated")?.args?.id;
    out(`✅ listing posted ${id !== undefined ? `#${id}` : "(created)"}`);
    refreshListings();
  } catch (e) {
    out(String(e.message || e));
  }
};

document.getElementById("refresh").onclick = refreshListings;

async function refreshListings() {
  try {
    const rc = readContracts();
    const total = Number(await rc.marketplace.totalListings());
    const listEl = document.getElementById("list");
    listEl.innerHTML = "";
    if (total === 0) {
      listEl.textContent = "No listings yet.";
      return;
    }

    for (let i = 0; i < total; i++) {
      const listing = await rc.marketplace.getListing(i);
      const status = ["Available", "Pending", "Sold", "Cancelled"][Number(listing.status)];
      const price = formatTokens(listing.priceInTokens);
      const buyer = listing.buyer === "0x0000000000000000000000000000000000000000" ? "none" : listing.buyer;
      listEl.insertAdjacentHTML(
        "beforeend",
        `<div class="listing"><strong>${listing.title}</strong> · ${listing.category} · ${listing.condition} · ${price} ENGC<br/>seller: ${listing.seller}<br/>buyer: ${buyer}<br/>status: ${status}</div>`
      );
    }
    out(`Loaded ${total} listing${total === 1 ? "" : "s"}.`);
  } catch (e) {
    out(String(e.message || e));
  }
}

refreshListings();
