var Registration = artifacts.require("df_Registration");
var DiamondToken = artifacts.require("diamondsToken");
// var Access = artifacts.require(" df_Access");
// var DiamondToken = artifacts.require("diamondsToken");
// var DiamondOps = artifacts.require("diamondOperations");

// module.exports = async(deployer) => {
//   let Registration = await deployer.deploy(Registration);
//   let Access = await deployer.deploy(Access);
//   let DiamondToken = await deployer.deploy(DiamondToken);
//   let DiamondOps = await deployer.deploy(DiamondOps);
//   let setAddress = await DiamondOps.setAddress(
//   Registration.address,Access.address,DiamondToken.address);
  
// };

module.exports = function(deployer) {
  deployer.deploy(DiamondToken, Registration.address);
};
