// SPDX-License-Identifier: MIT
pragma solidity 0.8.1;
 
//import "https://github.com/0xcert/ethereum-erc721/src/contracts/tokens/nf-token-metadata.sol";
//import "https://github.com/0xcert/ethereum-erc721/src/contracts/ownership/ownable.sol";
 
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/introspection/IERC165.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";

contract MyPub is ERC721URIStorage {

    uint256 public counter;

    constructor () ERC721 ("OpenPub", "OPUB"){
        counter = 0;
    }

    function publish(string memory tokenURI) public returns (uint256) {
        uint256 pubId = counter;
        _safeMint(msg.sender, pubId);
        _setTokenURI(pubId, tokenURI);
        counter = counter + 1;
        return pubId;
    }

}