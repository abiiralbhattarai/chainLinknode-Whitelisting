// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

interface AuthorizedRequesterInterface {
    function isAuthorizedRequester(address sender) external view returns (bool);

    function setAuthorizedRequesters(address[] calldata requesters) external;
}
