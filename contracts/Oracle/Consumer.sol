pragma solidity >=0.7.4;

import './IOracle.sol';

contract Consumer {
    IOracle public oracle;
    uint public price;
    constructor(address _oracle){
        oracle = IOracle(_oracle);
    }

    function foo() external{
        bytes32 key = keccak256(abi.encodePacked('BTC/USD'));

        (bool result, uint timestamp, uint data) = oracle.getData(key);
        require(result == true, 'could not get data');
        require(timestamp >= block.timestamp - 2 minutes, 'price too old');
        price = data;
        //do something with the price
    }
}