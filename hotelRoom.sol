// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract HotelRoom {
    event Occupy (
        address _occupant,
        uint256 _value
    );
    address payable public owner;
    enum Statuses{Vacant,Occupy}
    Statuses public currentStatus;

    constructor() {
        owner = payable(msg.sender);
        currentStatus = Statuses.Vacant;
    }
    modifier onlyWhileVacant() {
        require(currentStatus == Statuses.Vacant,"Currently Ocuupied");
        _;
    }
    modifier costs(uint256 _amount) {
          require(msg.value >= _amount,"Not enough ether provided");
          _;
    }

    function Book() payable public onlyWhileVacant costs(2 ether){
        currentStatus = Statuses.Occupy;

        (bool sent , bytes memory data) = owner.call{value : msg.value}("");
        require(sent);

        emit Occupy(msg.sender,msg.value);

    }
}
