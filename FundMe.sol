// SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
contract FundMe{
    address public owner;

    address [] public funders;
    
    uint public CurrentBalance=0;

    int public usePrice;

    function findPrice() internal{
        usePrice = getLatestPrice();
    }

    mapping(address => uint256) public AccountBook;

    constructor(){
        owner = msg.sender;
    }


    AggregatorV3Interface internal priceFeed=AggregatorV3Interface(0x9326BFA02ADD2366b30bacB125260Af641031331);

    function getLatestPrice() internal view returns (int) {
        (
            /*uint80 roundID*/,
            int price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/) = priceFeed.latestRoundData();
        return price;
    }

    function fund() payable public{
        uint money = msg.value;
        uint minVal = 10 ** 16;
        require(money>=minVal, "INSUFFICIENT DEPOSIT AMOUNT");
        AccountBook[msg.sender] = money;
        funders.push(msg.sender);
        findPrice();
        CurrentBalance+=money;
    }
    modifier OnlyOwner{
        require(msg.sender == owner,"adminstrator ID not found");
        _;
    }

    function withdraw(uint amnt) payable OnlyOwner public{

        require(amnt<= CurrentBalance, "Amount requested exceeds deposited");

        CurrentBalance-=amnt;

        for(uint i = funders.length-1;i>=0;i++){
            if(amnt==0){
                break;
            }
            if(AccountBook[funders[i]]>amnt){
                AccountBook[funders[i]]-=amnt;
                amnt=0;
            }
            else{
                amnt -= AccountBook[funders[i]];
                AccountBook[funders[i]] = 0;
            }
        }




        require(amnt==0, "insufficient funds across accounts");

        payable(msg.sender).transfer(amnt);
    }



}   
