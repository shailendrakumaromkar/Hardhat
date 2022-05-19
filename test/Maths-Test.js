const {expect, assert } = require("chai");
const {ethers } = require("hardhat");

describe("Maths", function(){
    it("add 2 numbers", async function(){
        const Maths = await ethers.getContractFactory("Maths");
        const maths = await Maths.deploy();
        await maths.deployed();

        const sum = await maths.add(3,6);
        console.log("printing before wait : ", sum);
        await sum.wait();
        console.log("printing after wait : ", sum);
        //expect(await res).to.equal(9);
//assert.equal(await maths.getRes(),9, "added correctly");
        assert.equal(sum,9, "added correctly");
    })
})