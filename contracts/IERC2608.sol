pragma solidity ^0.5.0;


interface IERC2608 {
    function walletOf(address user) external view returns(address);
    function precomputeWalletOf(address user) external view returns(address);
    function transferAndCall(address to, uint256 amount, bytes calldata data) external payable returns(bool);
}
