pragma solidity ^0.8.4;

interface UniswapV2 {
    function swapExactETHForTokens(
        uint256 amountOutMin,
        address[] memory path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory);

    function swapExactTokensForTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] memory path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory);

    function getAmountsOut(uint256 amountIn, address[] memory path) external view returns (uint256[] memory);

    function getAmountsIn(uint256 amountOut, address[] memory path) external view returns (uint256[] memory);
}
