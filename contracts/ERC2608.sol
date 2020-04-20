pragma solidity ^0.5.0;

import "@openzeppelin/contracts/ownership/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/Create2.sol";
import "./IERC2608.sol";
import "./ERC2608Wallet.sol";


contract ERC2608 is ERC20, IERC2608 {

    mapping(address => address) private _walletOf;

    function walletOf(address user) public view returns(address) {
        return address(_walletOf[user]);
    }

    function transferAndCall(address to, uint256 amount, bytes memory data) public payable returns(bool) {
        IERC2608Wallet wallet = _getWalletOrCreateIfNeeded(msg.sender);
        _transfer(msg.sender, address(wallet), amount);
        wallet.makeApprove(to, amount);
        wallet.makeCall.value(msg.value)(to, msg.value, data);
    }

    function _getWalletOrCreateIfNeeded(address user) internal returns(IERC2608Wallet) {
        address wallet = _walletOf[user];
        if (wallet == address(0)) {
            wallet = Create2.deploy(bytes32(uint256(user)), type(ERC2608Wallet).creationCode);
            _walletOf[user] = wallet;
        }
        return IERC2608Wallet(wallet);
    }
}
