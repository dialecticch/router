import { ethers, network } from "hardhat";
import { expect } from "chai";

const whale = "0x000000000000000000000000000000000000dead"
const token = "0xdbdb4d16eda451d0503b854cf79d55697f90c8df"

const swaps = [
    "0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D", // Uniswap
    "0xd9e1cE17f2641f24aE83637ab66a2cca9C378B9F" // Sushiswap
];

const path = [
    token,
    "0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2",
    "0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48" // USDC
]

describe("SwapRouter", function () {
    let router;

    let amount = 10**10*8;

    before(async function () {
        router = await (await ethers.getContractFactory("SwapRouterMock")).deploy();

        await network.provider.request({
            method: "hardhat_impersonateAccount",
            params: [whale],
        });

        let signer = await ethers.provider.getSigner(whale);

        let erc20 = await ethers.getContractAt("ERC20", token, signer);
        await erc20.transfer(router.address, amount);
    })

    it("should allow swapping", async function () {
        expect(router.swap(swaps, path, amount, 20)).to.not.be.reverted;
    })
})