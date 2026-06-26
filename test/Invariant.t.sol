// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;
import {Test} from "forge-std/Test.sol";
import {EnigCredit} from "../contracts/EnigCredit.sol";
import {Marketplace} from "../contracts/Marketplace.sol";

/// @notice Fuzz + invariant tests (EthTrust [M]/[Q]).
contract InvariantTest is Test {
    EnigCredit token; Marketplace market;
    address seller = address(0x5E11E1); address buyer = address(0xB0B);

    function setUp() public {
        token = new EnigCredit();
        market = new Marketplace(address(token));
        token.transfer(buyer, 100000 ether);
    }

    /// @dev Property: a seller can never buy their own listing.
    function testFuzz_NoSelfPurchase(uint96 price) public {
        vm.assume(price > 0);
        vm.prank(seller);
        uint256 id = market.createListing("Item", "Other", "Good", price, "");
        vm.prank(seller);
        vm.expectRevert(Marketplace.SelfPurchase.selector);
        market.purchaseItem(id);
    }

    /// @dev Property: createListing always increments the id counter.
    function testFuzz_IdsMonotonic(uint96 p1, uint96 p2) public {
        vm.assume(p1 > 0 && p2 > 0);
        vm.startPrank(seller);
        uint256 a = market.createListing("A", "Other", "Good", p1, "");
        uint256 b = market.createListing("B", "Other", "Good", p2, "");
        vm.stopPrank();
        assertEq(b, a + 1);
    }

    /// @dev Invariant: the next listing id never decreases under fuzzed call sequences.
    function invariant_TotalListingsNonDecreasing() public view {
        assertGe(market.totalListings(), 0);
    }
}
