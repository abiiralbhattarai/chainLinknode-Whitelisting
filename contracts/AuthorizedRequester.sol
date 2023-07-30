// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "./interfaces/AuthorizedRequesterInterface.sol";

abstract contract AuthorizedRequester is AuthorizedRequesterInterface {
    mapping(address => bool) private s_authorizedRequesters;

    event AuthorizedRequestersAddedd(address[] requesters, address changedBy);

    /**
     * @notice Sets the requester
     * @param requesters The addresses of the authorized requester
     */
    function setAuthorizedRequesters(
        address[] calldata requesters
    ) external override validateAuthorizedRequesterSetter {
        require(requesters.length > 0, "Must have at least 1 requester");
        for (uint256 i = 0; i < requesters.length; i++) {
            require(
                s_authorizedRequesters[requesters[i]] == false,
                "Must not have duplicate requesters"
            );
            s_authorizedRequesters[requesters[i]] = true;
        }
        emit AuthorizedRequestersAddedd(requesters, msg.sender);
    }

    /**
     * @notice Use this to check if authorized
     * @param requester The address of the Chainlink node
     * @return The authorization status of the node
     */
    function isAuthorizedRequester(
        address requester
    ) public view override returns (bool) {
        return s_authorizedRequesters[requester];
    }

    /**
     * @notice customizable guard of who can update the authorized requester list
     * @return bool whether requester can update authorized requester list
     */
    function _canSetAuthorizedRequesters() internal virtual returns (bool);

    /**
     * @notice validates the requester is an authorized requester
     */
    function _validateIsAuthorizedRequester(address requester) internal view {
        require(isAuthorizedRequester(requester), "Not authorized requester");
    }

    /**
     * @notice prevents non-authorized addresses from calling this method
     */
    modifier validateAuthorizedRequester(address requester) {
        _validateIsAuthorizedRequester(requester);
        _;
    }

    /**
     * @notice prevents non-authorized addresses from calling this method
     */
    modifier validateAuthorizedRequesterSetter() {
        require(
            _canSetAuthorizedRequesters(),
            "Cannot set authorized requesters"
        );
        _;
    }
}
