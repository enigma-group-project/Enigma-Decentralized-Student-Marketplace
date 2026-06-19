// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {IERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/IERC20Permit.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import {Pausable} from "@openzeppelin/contracts/utils/Pausable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/// @title Marketplace — Slice 2 (Listings) + Slice 3 (Escrow & Ratings)  [STUDENT TEMPLATE]
/// @notice Implement every TODO(memberN). Baseline: SafeERC20, Pausable, ReentrancyGuard + CEI, ERC-2612 permit.
contract Marketplace is ReentrancyGuard, Pausable, Ownable {
    using SafeERC20 for IERC20;

    enum Status { Available, Pending, Sold, Cancelled }
    struct Listing {
        uint256 id; address seller; address buyer;
        string title; string category; string condition;
        uint256 priceInTokens; string imageUrl;
        Status status; uint256 purchaseTimestamp;
    }
    IERC20  public immutable token;
    uint256 public nextListingId;
    uint256 public constant CANCELLATION_TIMEOUT = 5 minutes;
    mapping(uint256 => Listing) public listings;
    mapping(address => uint256) private ratingTotal;
    mapping(address => uint256) private ratingCount;
    mapping(uint256 => bool)    public  listingRated;

    event ListingCreated(uint256 indexed id, address indexed seller, string title, uint256 priceInTokens);
    event ItemPurchased(uint256 indexed id, address indexed buyer);
    event DeliveryConfirmed(uint256 indexed id, address indexed seller, uint256 amount);
    event PurchaseCancelled(uint256 indexed id, address indexed buyer);
    event RatingSubmitted(address indexed rater, address indexed rated, uint8 rating, uint256 indexed listingId);

    error EmptyTitle(); error BadPrice(); error NotAvailable(); error SelfPurchase();
    error NotPending(); error NotBuyer(); error TimeoutNotReached(); error NotSold();
    error AlreadyRated(); error BadRating();

    constructor(address token_) Ownable(msg.sender) { token = IERC20(token_); }

    function pause() external onlyOwner { _pause(); }
    function unpause() external onlyOwner { _unpause(); }

    // Slice 2 · Listings (member2)
    function createListing(string calldata title, string calldata category, string calldata condition, uint256 priceInTokens, string calldata imageUrl)
        external whenNotPaused returns (uint256 id)
    {
        // TODO(member2): validate (EmptyTitle/BadPrice); id = nextListingId++; store Available Listing; emit ListingCreated.
        revert("TODO(member2): implement createListing");
    }
    function getListing(uint256 id) external view returns (Listing memory) { return listings[id]; }
    function totalListings() external view returns (uint256) { return nextListingId; }

    // Slice 3 · Escrow & Ratings (member3)
    function purchaseItem(uint256 id) external nonReentrant whenNotPaused {
        // TODO(member3): checks (Available, not self); set Pending; token.safeTransferFrom into escrow; emit ItemPurchased.
        revert("TODO(member3): implement purchaseItem");
    }
    function purchaseWithPermit(uint256 id, uint256 deadline, uint8 v, bytes32 r, bytes32 s) external nonReentrant whenNotPaused {
        // TODO(member3): IERC20Permit(address(token)).permit(msg.sender,address(this),price,deadline,v,r,s); then purchase logic.
        revert("TODO(member3): implement purchaseWithPermit");
    }
    function confirmDelivery(uint256 id) external nonReentrant {
        // TODO(member3): require Pending + buyer; Sold; token.safeTransfer(seller); emit DeliveryConfirmed.
        revert("TODO(member3): implement confirmDelivery");
    }
    function cancelPurchase(uint256 id) external nonReentrant {
        // TODO(member3): require Pending + buyer + timeout; reset; token.safeTransfer(buyer); emit PurchaseCancelled.
        revert("TODO(member3): implement cancelPurchase");
    }
    function rateUser(uint256 id, uint8 rating) external nonReentrant {
        // TODO(member3): require Sold + buyer + 1..5 + not rated; record; emit RatingSubmitted.
        revert("TODO(member3): implement rateUser");
    }
    function getAverageRating(address user) external view returns (uint256 total, uint256 count) {
        return (ratingTotal[user], ratingCount[user]);
    }
}
