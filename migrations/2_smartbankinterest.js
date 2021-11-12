const SmartBankInterest = artifacts.require("SmartBankInterest");

module.exports = function (deployer) {
  deployer.deploy(SmartBankInterest);
};
