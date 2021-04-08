pragma solidity >=0.7.4;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

contract TokenOpenzeppelin1 is ERC20 {
    constructor() ERC20('Token name', 'TKN'){}
}

contract TokenOpenzeppelin2 is ERC20 {
    constructor() ERC20('Token name', 'TKN'){
        _mint(msg.sender, 100000);
    }
}

contract TokenOpenzeppelin3 is ERC20 {
    address public admin;
    constructor() ERC20('Token name', 'TKN'){
        admin = msg.sender;
    }

    function mint(address to, uint amount) external {
        require(msg.sender == admin, 'Admin only');
        _mint(to, amount);
    }
}

contract TokenOpenzeppelin4 is ERC20 { 
    constructor() ERC20('Token name', 'TKN'){ }

    function faucet(address to, uint amount) external { 
        _mint(to, amount);
    }
}