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
        string image; 
        address[] donators;
        uint256[] donations;
    }

    mapping(uint256 => Compaign) public compaigns;

    uint256 public numberOfCompaign=0;

    function createCompaign(address _owner, string memory _title, string memory _description, 
            uint256 _target, string memory _image, uint256 _deadline) public returns (uint256)
    {

        //before creating compaign check if everything is Ok!!
        require(_deadline < block.timestamp, "Deadline of compaign should be in future time!");

        Compaign storage compaign = compaigns[numberOfCompaign];

        compaign.owner = _owner;
        compaign.title = _title;
        compaign.description = _description;
        compaign.target = _target;
        compaign.image = _image;
        compaign.deadline = _deadline;

        numberOfCompaign++;
        return numberOfCompaign-1;
    }

    function donateToCompaign(uint256 _id) public payable {
        uint256 amount = msg.value;
        Compaign storage campaign = compaigns[_id];
        campaign.donators.push(msg.sender);
        campaign.donations.push(amount);

        (bool sent,) = payable(campaign.owner).call{value:amount}("");

        if(sent)
        {
            campaign.amountCollected = campaign.amountCollected+amount;
        }
        
    }

    function getDonators(uint256 _id) view public returns (address[] memory,uint256[] memory)
    {
        return (compaigns[_id].donators,compaigns[_id].donations);
    }

    function getCampaigns() public view returns (Compaign[] memory) {
        Compaign[] memory allCampaigns = new Compaign[](numberOfCompaign);

        for(uint i=0;i<numberOfCompaign;i++)
        {
            Compaign storage item = compaigns[i];
            allCampaigns[i] = item;
        }
        return allCampaigns;
    }
}