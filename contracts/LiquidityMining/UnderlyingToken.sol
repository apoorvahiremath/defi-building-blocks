pragma solidity >=0.7.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract UnderlyingToken is ERC20 {
    constructor() ERC20('Underlying Token', 'ULT'){}

    function faucet(address to, uint amount) external{
        _mint(to, amount);
    }
}