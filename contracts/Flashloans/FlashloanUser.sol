pragma solidity >=0.7.4;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./IFlashloanUser.sol";
import "./FlashloanProvider.sol";

contract FlashloanUser is IFlashloanUser{

    function startFlashloan(
        address flashloan,
        uint amount,
        address token
    )external{
        FlashloanProvider(flashloan).executeFlashloan(
            address(this),
            amount,
            token,
            bytes('')
        );
    }

    function flashloanCallback(
        uint amount,
        address token,
        bytes memory data
    )override
    external{
        //do some arbiterage, liquidation, etc..

        //Reimburse borrowed money
        IERC20(token).transfer(msg.sender, amount);
    }
}