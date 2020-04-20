pragma solidity ^0.5.0;

import "@openzeppelin/contracts/ownership/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./IERC2608Wallet.sol";


contract ERC2608Wallet is Ownable, IERC2608Wallet {
    address private _token = msg.sender;

    modifier onlyOwnerOrToken {
        require(msg.sender == owner() || msg.sender == _token);
        _;
    }

    function() external payable {
    }

    function token() external view returns(address) {
        return _token;
    }

    function makeApprove(address to, uint256 amount) external onlyOwnerOrToken {
        IERC20(_token).approve(to, amount);
    }

    function makeCall(address to, uint256 value, bytes calldata data) external payable onlyOwnerOrToken returns(bytes memory) {
        if (to != address(0)) {
            (bool success, bytes memory result) = to.call.value(value)(data);
            assembly {
                switch success
                    case 0 { revert(add(result, 32), returndatasize) }
            }
            return result;
        }
    }
}
