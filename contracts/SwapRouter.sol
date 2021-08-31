pragma solidity ^0.8.0;

import "./Interfaces/ERC20.sol";
import "./Interfaces/UniswapV2.sol";

/// @title SwapRouter
/// @dev A simple wrapper that selects the exchange with the best price and trades tokens on it.
///      Currently only works for exchanges compatible with the `UniswapV2` interface.
/// @author Dialectic
library SwapRouter {
    /// @dev Emitted after a trade occurs.
    /// @param exchange The exchange tokens were swapped through.
    /// @param input The input token.
    /// @param output The received token.
    /// @param amountIn The amount of input tokens traded.
    /// @param amountOut The amount of output tokens received.
    event Swapped(address indexed exchange, address indexed input, address indexed output, uint256 amountIn, uint256 amountOut);

    /// @dev Swaps tokens through a specified path on the best exchange.
    /// @param swaps The exchanges to choose from.
    /// @param path The path for the swap.
    /// @param amount The amount of tokens to sell.
    /// @param slippage The max slippage in basis points.
    /// @return The amount of tokens received.
    function swap(
        UniswapV2[] memory swaps,
        address[] memory path,
        uint256 amount,
        uint256 slippage
    ) internal returns (uint256) {
        (UniswapV2 swap, uint256 amountOut) = dataForBestExchange(swaps, path, amount);

        ERC20(path[0]).approve(address(swap), amount);

        uint256[] memory amountsOut = swap.swapExactTokensForTokens(
            amount,
            (amountOut * (1000 - slippage)) / 1000,
            path,
            address(this),
            block.timestamp + 180
        );

        uint256 out = amountsOut[amountsOut.length - 1];
        emit Swapped(address(swap), path[0], path[path.length - 1], amount, out);
        return out;
    }

    function dataForBestExchange(
        UniswapV2[] memory swaps,
        address[] memory path,
        uint256 amount
    ) private view returns (UniswapV2, uint256) {
        UniswapV2 bestExchange;
        uint256 bestAmount;

        uint256 length = swaps.length;
        for (uint256 i = 0; i < length; i++) {
            uint256 out = amountOutFor(swaps[i], path, amount);
            if (out > bestAmount) {
                bestExchange = swaps[i];
                bestAmount = out;
            }
        }

        return (bestExchange, bestAmount);
    }

    function amountOutFor(
        UniswapV2 exchange,
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
