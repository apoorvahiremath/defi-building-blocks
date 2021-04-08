pragma solidity >=0.7.4;

interface IFlashloanUser {
    function flashloanCallback(
        uint amount,
        address token,
        bytes memory data
    )external;
}