import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";



const saveEtherModule = buildModule("saceEtherModule", (m) => {
 

  const saveEther= m.contract("stakeEther");

  return { saveEther};
});

export default saveEtherModule;
