// Structs are complex types that can have multiple member variables
// Struct names start with an upper case letter by convention
struct MyStruct {
    // A struct member variable
    uint myStructMember;

    // Another struct member variable
    uint myOtherStructMember;

}

// A struct can be created like this
MyStruct someStruct = myStruct(0, 1);
// or
MyStruct someStruct = myStruct({
    myStructMember: 0,
    myOtherStructMember: 1
});