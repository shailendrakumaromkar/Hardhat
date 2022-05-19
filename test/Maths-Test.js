const { expect } = require("chai");
const { ethers } = require("hardhat");


describe("Maths calculation", function(){
    it("add 2 numbers", async function() {
        const Maths= await ethers.getContractFactory("Maths");
        const maths = await Maths.deploy();
        await maths.deployed();

        const res = await maths.add(8,4);
    await res.wait();

        expect(await maths.res()).to.equal(12);
    });
})