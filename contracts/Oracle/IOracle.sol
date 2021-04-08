pragma solidity >=0.7.4;

interface IOracle {
    function getData(bytes32 key)
    external
    view
    returns(bool, uint date, uint payload);
}