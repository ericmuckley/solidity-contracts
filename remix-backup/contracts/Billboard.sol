// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Billboard {

    address payable public owner;
    mapping (address => string) public messages;
    mapping (address => uint) public bids;


    constructor() payable {
        owner = payable(msg.sender);
    }

    modifier onlyOwner () {
       require(msg.sender == owner, "This function can only be called by the contract owner");
       _;
    }

    function withdraw() public payable onlyOwner {
        owner.transfer(address(this).balance);
    }  

    event NewBid(
        address indexed _bidder,
        uint indexed _value
    );

    event NewMessage(
        address indexed _sender,
        string indexed _message
    );

    fallback() external payable {
        bids[msg.sender] = bids[msg.sender] + msg.value;
        emit NewBid(msg.sender, msg.value);
    }

    receive () external payable {
        bids[msg.sender] = bids[msg.sender] + msg.value;
        emit NewBid(msg.sender, msg.value);
    }

    function setMessage(string memory _message) public {
        messages[msg.sender] = _message;
        emit NewMessage(msg.sender, _message);
    }

}




