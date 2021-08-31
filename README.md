# Router

![GitHub](https://img.shields.io/github/license/dialecticch/router)

This repository contains `SwapRouter`, a very simple router to exchange tokens for the best price on any `UniswapV2`
like AMM.

Usage is simple, all one needs to do is import the library and call the following function:

```solidity
import "@dialecticch/router/contracts/SwapRouter.sol";
import "@dialecticch/router/contracts/Interfaces/UniswapV2.sol";

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
```

The `slippage` should be provided as a basis point, so `2%` slippage would be `20`.
