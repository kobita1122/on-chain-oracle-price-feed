// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {AggregatorV3Interface} from "https://github.com/smartcontractkit/chainlink/blob/master/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

/**
 * @title PriceConsumer
 * @dev Securely fetches and validates real-time price data from Chainlink Oracles.
 */
contract PriceConsumer {
    AggregatorV3Interface internal immutable priceFeed;
    uint256 public constant STALE_PRICE_THRESHOLD = 3600; // 1 hour

    /**
     * Network: Ethereum Mainnet
     * Aggregator: ETH/USD
     * Address: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
     */
    constructor(address _priceFeed) {
        priceFeed = AggregatorV3Interface(_priceFeed);
    }

    /**
     * @notice Returns the latest price and validates for staleness.
     * @return price The current asset price with 8 decimals.
     */
    function getLatestPrice() public view returns (int256) {
        (
            uint80 roundId,
            int256 price,
            uint256 startedAt,
            uint256 updatedAt,
            uint80 answeredInRound
        ) = priceFeed.latestRoundData();

        require(price > 0, "Negative price data");
        require(updatedAt != 0, "Incomplete round");
        require(answeredInRound >= roundId, "Stale price");
        require(block.timestamp - updatedAt <= STALE_PRICE_THRESHOLD, "Price too old");

        return price;
    }

    /**
     * @notice Returns the decimals of the price feed (usually 8 or 18).
     */
    function getDecimals() public view returns (uint8) {
        return priceFeed.decimals();
    }
}
