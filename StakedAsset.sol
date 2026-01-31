// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract StakedAsset is ERC20, Ownable, ReentrancyGuard {
    uint256 public totalUnderlying;

    event Staked(address indexed user, uint256 amount, uint256 shares);
    event RewardsDistributed(uint256 amount);

    constructor() ERC20("Staked Token", "stTKN") Ownable(msg.sender) {}

    // Calculate how much underlying 1 share is worth
    function getExchangeRate() public view returns (uint256) {
        if (totalSupply() == 0) return 1e18;
        return (totalUnderlying * 1e18) / totalSupply();
    }

    function stake() external payable nonReentrant {
        require(msg.value > 0, "Cannot stake 0");
        
        uint256 sharesToMint;
        if (totalSupply() == 0) {
            sharesToMint = msg.value;
        } else {
            sharesToMint = (msg.value * totalSupply()) / totalUnderlying;
        }

        totalUnderlying += msg.value;
        _mint(msg.sender, sharesToMint);
        
        emit Staked(msg.sender, msg.value, sharesToMint);
    }

    // Called by a restricted 'Reporter' or 'Oracle' to reflect staking rewards
    function distributeRewards() external payable onlyOwner {
        totalUnderlying += msg.value;
        emit RewardsDistributed(msg.value);
    }

    function withdraw(uint256 _shares) external nonReentrant {
        uint256 amountToReturn = (_shares * totalUnderlying) / totalSupply();
        
        _burn(msg.sender, _shares);
        totalUnderlying -= amountToReturn;
        
        payable(msg.sender).transfer(amountToReturn);
    }
}
