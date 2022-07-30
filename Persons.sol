// SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;

contract Persons{

    mapping (string => uint256) public NetWorthCheck;

    struct Person{
        uint256 money;
        string name;
    }


    Person[] public person;
    
    function newPerson(uint dollars, string memory names) public{
        if(person.length>0){
            bool found = true;
            for(uint i=0;i<person.length;i++){
                
                if(keccak256(bytes(names))==keccak256(bytes(person[i].name))){
                    uint256 currentVal= person[i].money;
                    person[i].money = currentVal+dollars;
                    NetWorthCheck[names] = currentVal+dollars;
                    found = false;
                }
            }
            if(found){
                    
                person.push(Person(dollars,names));
                NetWorthCheck[names] = dollars;
            }
        }
        else{
            person.push(Person(dollars,names));
            NetWorthCheck[names] = dollars;
        }
    }


}
