const Migrations = artifacts.require('./Migrations.sol');
const ERC2608 = artifacts.require('./ERC2608.sol');

module.exports = function (deployer) {
    deployer.deploy(Migrations);
    deployer.deploy(ERC2608);
};
