pragma solidity >=0.7.4;

import "./UnderlyingToken.sol";
import "./LPToken.sol";
import "./GovernanceToken.sol";

contract LiquidityPool is LPToken{
    mapping (address=>uint) public checkPoints;
    UnderlyingToken public underlyingToken;
    GovernanceToken public governanceToken;
    uint constant public REWARD_PAR_BLOCK = 1;

    constructor(address _underlyingToken, address _governanceToken){
        underlyingToken = UnderlyingToken(_underlyingToken);
        governanceToken = GovernanceToken(_governanceToken);
    }

    function deposite(uint amount) external{
        if(checkPoints[msg.sender] == 0){
            checkPoints[msg.sender] = block.number;
        }
        _distributeReward(msg.sender);
        underlyingToken.transferFrom(msg.sender, address(this), amount);
        _mint(msg.sender, amount);
    }

    function _distributeReward(address beneficiary) internal{
        uint checkpoint = checkPoints[beneficiary];
        if(block.number - checkpoint > 0){
            uint distributionAmount = balanceOf(beneficiary) * (block.number - checkpoint) * REWARD_PAR_BLOCK;
            governanceToken.mint(beneficiary, distributionAmount);
            checkPoints[beneficiary] = block.number;
        }
    }

    function withdraw(uint amount) external {
        require(balanceOf(msg.sender)>= amount, "not enought tokens");
        _distributeReward(msg.sender);
        underlyingToken.transfer(msg.sender, amount);
        _burn(msg.sender, amount);
    }

}