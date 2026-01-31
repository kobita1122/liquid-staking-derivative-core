# Liquid Staking Derivative (LSD) Core

This repository provides an expert-level foundation for building a Liquid Staking protocol. It handles the minting of derivative tokens in exchange for native assets and manages the "exchange rate" logic that reflects accrued staking rewards.



## Key Architecture
* **Exchange Rate Logic**: Instead of rebasing (changing balances), this contract uses a value-accruing model where the `stAsset` becomes worth more of the underlying asset over time.
* **Oracle Integration**: Designed to receive reward data from off-chain validators to update the internal pool state.
* **Standardized Interface**: The receipt token is a standard ERC-20, making it instantly compatible with DEXs and Lending protocols.

## Technical Specifications
* **Asset**: Native Token (e.g., ETH, MATIC, or custom).
* **Derivative**: stAsset (Liquid Staked Asset).
* **Yield Mechanism**: Reward Socialization across all pool participants.

## Setup
1. `npm install`
2. `npx hardhat compile`
3. Run `node scripts/simulate_staking.js` to see the exchange rate increase.
