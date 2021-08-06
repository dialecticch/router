pragma solidity ^0.8.4;

contract Router {
    address public immutable override factory;
    address public immutable override WETH;

    constructor(address _factory, address _WETH) {
        factory = _factory;
        WETH = _WETH;
    }

    function swap(address from, address to, uint256 slippage) external {

    }
}
