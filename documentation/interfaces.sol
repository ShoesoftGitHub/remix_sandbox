// https://www.tutorialspoint.com/solidity/solidity_interfaces.htm
// Interfaces are abstract contracts that contain only virtual functions
// An interface does not have a constructor or state variables
interface MyInterface {
    // Functions can not be implemented and only be external
    function myFunc() external;

    // An interface can have enums which can be accessed with {interface_name}.{enum_name}
    enum MyEnum {ONE, TWO, THREE}

    // An interface can have structs which can be accessed with {interface_name}.{struct_name}
    struct MyStruct {
        uint myUInt;
    }
}

// Interfaces can inherit from interfaces
interface MyChildInterface is MyInterface {}

// Interfaces can be inherited from
contract Implemented is MyInterface {
    // An interface function can be implemented without the override keyword
    function myFunc() external {}
}