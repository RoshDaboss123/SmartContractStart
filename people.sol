// SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;
import "./Persons.sol";


contract People{

    Persons[] public peoples;

    function newPeople(uint worth, string memory name) public{
        Persons p = new Persons();
        p.newPerson(worth,name);
    }


    function getPeople(uint i) public view returns(Persons){
        return peoples[i];
    }


}
