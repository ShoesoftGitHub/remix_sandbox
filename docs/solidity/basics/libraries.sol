// https://jeancvllr.medium.com/solidity-tutorial-all-about-libraries-762e5a3692f9
// A library is a different kind of smart contract that
// contains reusable code.
// A library can be deployed on the blockchain once and then used
// by other contracts.
// Libraries can contain structs, enums and view-only helper function but dont have 
// a storage. They can be used to save gas, cant hold ether and have
// no inheritance features and cant be destroyed.
// A library can not have fallback or payable functions.
// Libraries can store constant variables.

// Embedded Library: If a library only has internal functions a smart contract will
// embed it thus making function calls as jumps instead of delegate calls
// Linked Library: If a library contains public or external functions
// it needs to be deployed, which will generate a unique address that needs to be linked
// with the calling contract.
library MyLibrary {

    // A struct member
    struct MyStruct {
        uint myUInt;
    }

    // An enum member
    enum MyEnum {ONE, TWO, THREE}

    // A constant member
    uint constant constInt = 0;

    // An internal function
    function myInternalFunc() internal {}

    // An external function
    function myExternalFunc() external {}

    // A non implemented function, it can only be external or public
    function MyFunction() public;

    // A modifier that can only be used in the library
    modifier myModifier() { _; }

}

// Libraries can be imported
import MyLibrary from "library-file.sol"
// or
import "library-file.sol"
// or
import {MyLibrary1, MyLibrary2} from "library-file.sol"

// A library can be attached to a data type inside of a contract
// This should essentially be used with data types that are the first
// parameter of the library's functions but it does not have to be
contract MyContract {
    using MyLibrary for uint;
    // It is also possible to attach a library to all data types
    using MyLibrary for *;
    // It is also possible to use a library struct as the first parameter
    using MyLibrary for MyLibrary.MyStruct;

    // A library function can be called from the library
    MyLibrary.MyFunction();
    // A library struct can be created from the library
    MyLibrary.MyStruct myS = MyLibrary.MyStruct();
}