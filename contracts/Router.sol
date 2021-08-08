pragma solidity ^0.8.4;

import "./Interfaces/ERC20.sol";
import "./Interfaces/UniswapV2.sol";

contract Router {

    UniswapV2 public constant UNI = UniswapV2(0x0);
    UniswapV2 public constant SUSHI = UniswapV2(0x0);

    address public immutable override factory;
    address public immutable override WETH;

    constructor(address _factory, address _WETH) {
        factory = _factory;
        WETH = _WETH;
    }

    function swap(ERC20 from, ERC20 to, uint256 amount, uint256 slippage) external {
        from.transferFrom(address(this), amount);

        // @TODO FIND THE BEST EXCHANGE
    }
}
