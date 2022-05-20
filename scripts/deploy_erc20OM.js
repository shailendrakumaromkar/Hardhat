const hre = require("hardhat");

async function main(){
    const OmERC20 = await hre.ethers.getContractFactory("OmERC20");
    const omerc20 = await OmErc20.deploy("1000000000000000000000000000");
    await omerc20.deployed();

    console.log("Om Token is deployed", omerc20.address);

}

main()
.then(()=>process.exit(0))
.catch((error)=>{
    console.error(error);
    process.exit(1);
});

