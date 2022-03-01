// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Donate {

  uint public totalDonated; // the amount of donations
  uint public nDonations; // number of times a donation has been recieved
  address payable owner; // contract creator's address

  //contract settings
  constructor() {
    owner = payable(msg.sender); // setting the contract creator
    nDonations = 0;
    totalDonated = 0;

  }


  // this is a fallback function in case someone sends eth 
  // to the contract without explicitly calling a function
  //fallback () external payable {}




  //public function to make donate
  function donate(uint donationAmount) public payable returns (bool) {
    require(donationAmount <= address(this).balance);
    //require(msg.value == donationAmount);
    (bool success,) = owner.call{value: donationAmount}("");
    require(success, "Failed to send money");
    nDonations += 1;
    totalDonated += msg.value;
    return true;

  }


}