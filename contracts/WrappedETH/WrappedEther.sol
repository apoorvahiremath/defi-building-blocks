pragma solidity >=0.7.4;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

contract WrappedEther is ERC20{
    constructor() ERC20('Wrapped ether','WETH'){}

    function deposite() external payable {
        _mint(msg.sender, msg.value);
    }

    function withdraw(uint amount) external {
        require(balanceOf(msg.sender) >= amount, 'balance too low');
        _burn(msg.sender, amount);
        msg.sender.transfer(amount);
    }
}