// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Publisher {

    struct Publication {
        string title;
        string authors;
        string description;
        string hash;
    }

    mapping(address => Publication[]) public publications;
    mapping(address => uint) public pubCounts;
    address[] public correspondingAuthors;
    uint public authorCount;

    event NewPublicationEvent (
        address indexed _sender,
        string indexed _title,
        string indexed _hash
    );


    function publish(string memory _title, string memory _authors, string memory _description, string memory _hash) public {


        Publication memory pub = Publication({
            title: _title,
            authors: _authors,
            description: _description,
            hash: _hash
        });
        
        
        // if this address has never published before
        // add it to the correponding authors list
        if (publications[msg.sender].length == 0){
            correspondingAuthors.push(msg.sender);
            authorCount += 1;
        }

        pubCounts[msg.sender] += 1;
        publications[msg.sender].push(pub);

        emit NewPublicationEvent(msg.sender, _title, _hash);
    }

}




