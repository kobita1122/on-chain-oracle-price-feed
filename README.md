# On-Chain Oracle Price Feed

This repository demonstrates the industry-standard method for consuming decentralized price data within Solidity smart contracts. It is essential for DeFi applications like lending protocols, synthetic assets, and stablecoins.

## Features
- **Chainlink Integration**: Uses the `AggregatorV3Interface` for reliable data.
- **Data Validation**: Includes checks for "stale" data to prevent executing trades on outdated prices.
- **Multi-Asset Support**: Easily adaptable for any price pair (BTC/USD, Gold/USD, etc.).
- **Professional Error Handling**: Reverts on failed oracle calls to protect user funds.

## Technical Workflow
1. **Request**: The contract calls the specific proxy address for a price pair.
2. **Retrieve**: The Oracle returns the latest price, timestamp, and round ID.
3. **Validate**: The contract checks if the data is recent enough based on a heartbeat threshold.



## Setup
- Compile: `forge build`
- Test: `forge test --fork-url <YOUR_RPC_URL>` (Forking is required to interact with live Oracle proxies).
