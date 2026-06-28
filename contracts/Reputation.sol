// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import {Marketplace} from "./Marketplace.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

/// @title Reputation — Slice 4 (Reputation / Ratings)
/// @notice Reputation contract for the Decentralized Student Marketplace.
/// Buyers can rate sellers and sellers can rate buyers after a successful sale.
contract Reputation is ReentrancyGuard {
    Marketplace public immutable market;

    /// @notice Sum of all ratings received by a user.
    mapping(address => uint256) private ratingTotal;

    /// @notice Number of ratings received by a user.
    mapping(address => uint256) private ratingCount;

    /// @notice Tracks whether the buyer has already rated the seller.
    mapping(uint256 => bool) public buyerRatedSeller;

    /// @notice Tracks whether the seller has already rated the buyer.
    mapping(uint256 => bool) public sellerRatedBuyer;

    event RatingSubmitted(
        address indexed rater,
        address indexed rated,
        uint8 rating,
        uint256 indexed listingId
    );

    error NotSold();
    error BadRating();
    error Unauthorized();
    error AlreadyRated();

    constructor(address marketplace) {
        market = Marketplace(marketplace);
    }

    /// @notice Rate the other participant in a completed transaction.
    /// Buyer -> Seller
    /// Seller -> Buyer
    function rateUser(
        uint256 listingId,
        uint8 rating
    ) external nonReentrant {
        Marketplace.Listing memory listing = market.getListing(listingId);

        if (listing.status != Marketplace.Status.Sold)
            revert NotSold();

        if (rating < 1 || rating > 5)
            revert BadRating();

        // Buyer rates seller
        if (msg.sender == listing.buyer) {
            if (buyerRatedSeller[listingId])
                revert AlreadyRated();

            buyerRatedSeller[listingId] = true;

            ratingTotal[listing.seller] += rating;
            ratingCount[listing.seller]++;

            emit RatingSubmitted(
                msg.sender,
                listing.seller,
                rating,
                listingId
            );

            return;
        }

        // Seller rates buyer
        if (msg.sender == listing.seller) {
            if (sellerRatedBuyer[listingId])
                revert AlreadyRated();

            sellerRatedBuyer[listingId] = true;

            ratingTotal[listing.buyer] += rating;
            ratingCount[listing.buyer]++;

            emit RatingSubmitted(
                msg.sender,
                listing.buyer,
                rating,
                listingId
            );

            return;
        }

        revert Unauthorized();
    }

    /// @notice Returns the cumulative rating information.
    function getAverageRating(
        address user
    ) external view returns (uint256 total, uint256 count) {
        return (ratingTotal[user], ratingCount[user]);
    }

    /// @notice Returns the average rating scaled by 100.
    /// Example:
    /// 450 = 4.50 stars
    /// 500 = 5.00 stars
    function getAverageRatingScaled(
        address user
    ) external view returns (uint256) {
        if (ratingCount[user] == 0) {
            return 0;
        }

        return (ratingTotal[user] * 100) / ratingCount[user];
    }
}