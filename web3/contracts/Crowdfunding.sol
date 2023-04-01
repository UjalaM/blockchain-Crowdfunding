// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Crowdfunding 
{
    struct Compaign{
        string title;
        string description;
        address owner;
        uint256 target;
        uint256 amountCollected;
        uint256 deadline;
        string imgage; 
        uint256 amount;
        address[] donators;
        uint256[] donations;
    }

    mapping(uint256 => Compaign) public compaigns;

    uint256 public numberOfCompaign=0;

    function createCompaign(address _owner, string memory _title, uint256 _deadline) public returns (uint256)
    {

        //before creating compaign check if everything is Ok!!
        require(_deadline < block.timestamp, "Deadline of compaign should be in future time!");

        Compaign storage compaign = compaigns[numberOfCompaign];

        compaign.owner = _owner;

        numberOfCompaign++;
        return numberOfCompaign-1;
    }
}