// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Burnable} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

/// @title EnigCredit (ENGC) — Slice 1 (Token + Wallet)  [STUDENT TEMPLATE]
/// @notice Implement TODO(member1). Baseline: ERC20 + ERC20Burnable + ERC20Permit + Ownable.
///         burn/burnFrom (Burnable) and permit/nonces (Permit) are inherited — implement mint.
contract EnigCredit is ERC20, ERC20Burnable, ERC20Permit, Ownable {
    constructor()
        ERC20("EnigCredit", "ENGC")
        ERC20Permit("EnigCredit")
        Ownable(msg.sender)
    {
        _mint(msg.sender, 1_000_000 * 10 ** decimals());
    }
    function mint(address to, uint256 amount) external onlyOwner {
        // TODO(member1): _mint(to, amount);
        revert("TODO(member1): implement mint");
    }
}
