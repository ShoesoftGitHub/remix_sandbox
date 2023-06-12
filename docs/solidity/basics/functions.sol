// Functions are declared like:
// {function keyword}{function name}{arguments}{virtual}{access modifier}
// {state mutability attribute or payable attribute}{custom modifiers}
// {returns keyword}{(return type 1 return name 1, ...)}
// {function body}
// Function names start with a lower case letter by convention
function myFunction(uint inArg1, uint inArg2) public view returns (uint outUInt1, uint outUInt2) {}
// Return values do not have to be named
function myFunction() returns (uint, string) {
    return (0, "a");
}
// Multiple return values can be assigned to a tuple
(a, b) = myFunc();

// Arguments can be passed by name in arbitrary order
myFunc({arg2: 0, arg1: 1});
// Argument names can be omitted
function myFunc(uint) {}

// A function can be called internally, causing it to jump and not clear the memory,
// which is efficient
myFunc()

// A function can also be called externally via the this. keyword or a contract name MyContract.
// this way a message call will be used instead of a jump.
// Functions can not be called via this in the constructor.
this.myFunc()
// Functions of other contracts have to be called externally.
// It is possible to set the amount of Wei or gas sent with the call.
// This is discouraged. Any Wei sent to a contract like this is stored in the contract.
otherContract.otherFunc{value: 10, gas: 10000}());
// Calls to other contracts make it possible to exploit reentrancy

// https://docs.alchemy.com/docs/solidity-payable-functions
// A payable function is a function that can receive and send Ether,
// a payable function stores Ether in the contract's balance.
function myFunc(uint amount) external payable {}
// A payable function can have a costs attribute which defines its price
function myFunc(uint amount) external payable costs(1 ether) {}

// A virtual function
function myFunc() public virtual {}
// A function override
function myFunc() public override {}
// The super keyword calls a the function implementation of a superior class
function myFunc() public override {
    super.myFunc();
}
// External functions cannot call super