// https://www.tutorialspoint.com/solidity/solidity_function_modifiers.htm
// Modifiers are used to modify the behaviour of a function, for example to 
// add a prerequisite.
// The function body is inserted where the _ is in the modifier.
modifier onlyOwner {
    require(msg.sender == owner);
    _;
}