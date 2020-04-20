pragma solidity ^0.5.0;


interface IERC2608Wallet {
    function token() external view returns(address);

    function makeApprove(address to, uint256 amount) external;

    function makeCall(address to, uint256 value, bytes calldata data) external payable returns(bytes memory);
}
