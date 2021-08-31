pragma solidity ^0.8.4;

interface ERC20 {
    function transferFrom(address, uint256) external returns (bool);

    function approve(address, uint256) external returns (bool);
}
