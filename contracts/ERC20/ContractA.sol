pragma solidity >=0.7.4;

import '@openzeppelin/contracts/token/ERC20/IERC20.sol';

interface ContractB{
    function deposite(uint amount) external;
    function withdraw(uint amount) external;
}

contract ContractA{
    IERC20  public token;
    ContractB public contractB;

    constructor(address _token, address _contractB){
        token = IERC20(_token);
        contractB = ContractB(_contractB);
    }

    function deposite(uint amount) external {
        token.transferFrom(msg.sender, address(this), amount);

        token.approve(address(contractB), amount);
        contractB.deposite(amount);
    }

    function withdraw(uint amount) external {
        token.transfer(msg.sender, amount);

        contractB.withdraw(amount);
    }
}