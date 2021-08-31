pragma solidity ^0.8.4;

import "../Interfaces/UniswapV2.sol";
import "../SwapRouter.sol";

contract SwapRouterMock {
    function swap(
        UniswapV2[] memory swaps,
        address[] memory path,
        uint256 amount,
        uint256 slippage
    ) external returns (uint256) {
        return SwapRouter.swap(swaps, path, amount, slippage);
    }
}
