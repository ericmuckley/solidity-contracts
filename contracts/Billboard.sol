// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Billboard {

    string public message;
    uint public nChanges;
    uint public currentBid;
    address payable public owner;


    constructor() payable {
        owner = payable(msg.sender);

        nChanges = 0;
        currentBid = 0;
        message = 'Hello, this is the billboard.';
    }


    // modifier for ensuring that certain contracts
    // can only be executed by the owner address
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner may use this method");
        _;
    }

    modifier validateBidAmount() {
        require(msg.value > currentBid, "Payment must be greater than the largest previous payment");
        _;
    }


    event Payment(
        address indexed _donor,
        uint256 _value
    );


    // fallback function in case someone sends ETH
    // directly to the contract
    fallback() external payable {
        setMessage("message set by ", 0);
    }
    receive() external payable {
        setMessage("no message sent", 0);
    }


    function setMessage(string memory _message, uint256 _bid) public payable {

        //address(this).transfer(msg.value);

        //require(msg.value > currentBid, 'Bid is not high enough');

        //(bool success,) = owner.call{value: msg.value}("");
        //require(success, "Failed to send money");
        //require (msg.value == exactAmount);

        owner.transfer(msg.value);
        //(bool success,) = admin.call{value: msg.value, gas: _gas}("");

        //require(success, "Failed to send bid with sufficient gas");

        message = _message;
        nChanges += 1;
        currentBid = msg.value;

        emit Payment(msg.sender, _bid);

    }



    function withdraw() public onlyOwner {
        // get the amount of Ether stored in this contract
        uint amount = address(this).balance;

        (bool success, ) = owner.call{value: amount}("");
        require(success, "Failed to send Ether");
    }


}




