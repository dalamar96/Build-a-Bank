const SmartBankAccountAllCoin = artifacts.require("SmartBankAccountAllCoin");

module.exports = function (deployer) {
  deployer.deploy(SmartBankAccountAllCoin);
};
