// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "./ConfirmedOwnerWithProposal.sol";

/**
 * @title The ConfirmedOwner contract
 * @notice A contract with helpers for basic contract ownership.
 */
contract ConfirmedOwner is ConfirmedOwnerWithProposal {
    function __ConfirmedOwner_init(address newOwner) internal onlyInitializing {
        __ConfirmedOwner_init_unchained(newOwner);
    }

    function __ConfirmedOwner_init_unchained(
        address newOwner
    ) internal onlyInitializing {
        __ConfirmedOwnerWithProposal_init(newOwner, address(0));
    }

    /**
     * @dev This empty reserved space is put in place to allow future versions to add new
     * variables without shifting down storage in the inheritance chain.
     */
    uint256[49] private __gap;
}
