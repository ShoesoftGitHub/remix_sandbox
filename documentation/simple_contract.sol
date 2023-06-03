// 1. License
// SPDX-License-Identifier: GPL-3.0

// 2.A Specify Solidity Version as a version
pragma solidity ^0.8.20

// 2.B Specify Solidity Version >= and < a version
pragma solidity >=0.4.16 <0.9.0;

// 3. Contract object, this is sort of the body of the entire document, 
// any functions come from this contract
contract myContract {
    // 4. An unsigned integer member
    uint myUInt;

    // 5. A common public setter function
    function setMyUInt(uint inMyUInt) public {
        myUInt = inMyUInt;
    }

    // 6. A common public getter function
    function getMyUInt public view returns (uint) {
        return myUInt;
    }

}