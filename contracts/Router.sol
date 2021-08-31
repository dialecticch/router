pragma solidity ^0.8.4;

import "./Interfaces/ERC20.sol";
import "./Interfaces/UniswapV2.sol";

library SwapRouter {

    function swap(UniswapV2[] swaps, address[] memory path, uint256 amount, uint256 slippage) internal {
        (UniswapV2 swap, uint256 amountOut) = dataForBestExchange(swaps, path, amount);

        swap.swapExactTokensForTokens(
            amount,
            (amountOut * (1000 - slippage)) / 1000,
            path,
            address(this),
            block.timestamp + 180
        );
    }

    function dataForBestExchange(UniswapV2[] swaps, address[] memory path, uint256 amount) private view returns (UniswapV2, uint256) {
        UniswapV2 bestExchange;
        uint256 bestAmount;

        uint256 length = swaps.length;
        for (uint256 i = 0; i < length; i++) {
            out = amountOutFor(swaps[i], path, amount);
            if (out > bestAmount) {
                bestExchange = swaps[i];
                bestAmount = out;
            }
        }

        return (bestExchange, bestAmount);
    }

    function amountOutFor(
        Uniswap exchange,
        address[] memory path,
        uint256 amountIn
    ) private view returns (uint256) {
        try exchange.getAmountsOut(amountIn, path) returns (uint256[] memory amountsOut) {
            return amountsOut[amountsOut.length - 1];
        } catch {
            return 0;
        }
    }

}
