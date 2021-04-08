pragma solidity >=0.7.4;

import '@openzeppelin/contracts/token/ERC721/ERC721Holder.sol';
import '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import '@openzeppelin/contracts/token/ERC721/IERC721.sol';

interface ContractBNFT {
        function deposite(uint tokenId) external;
        function withdraw(uint tokenId) external;
}
contract ContractANFT is ERC721Holder{
    IERC721 public token;
    ContractBNFT public contractB;
    
    constructor(address _token, address _contractB){
        token = IERC721(_token);
        contractB = ContractBNFT(_contractB);
    }

    function deposite(uint tokenId) external {
        token.safeTransferFrom(msg.sender, address(this), tokenId);

        token.approve(address(contractB), tokenId);
        contractB.deposite(tokenId);
    }

    function withdraw(uint tokenId) external{
        contractB.withdraw(tokenId);
        token.safeTransferFrom(address(this), msg.sender, tokenId);
    }
}
