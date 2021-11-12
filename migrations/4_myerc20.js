const MyErc20 = artifacts.require("MyErc20");

module.exports = function (deployer) {
  deployer.deploy(MyErc20);
};
