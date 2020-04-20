// const { expectRevert } = require('openzeppelin-test-helpers');
// const { expect } = require('chai');

const ERC2608 = artifacts.require('ERC2608');

contract('ERC2608', function ([_, addr1]) {
    describe('ERC2608', async function () {
        it('should be ok', async function () {
            this.token = await ERC2608.new();
        });
    });
});
