// https://subscription.packtpub.com/book/application-development/9781788831383/7/ch07lvl1sec81/the-view-constant-and-pure-functions
// The special modifiers constant, pure, and view, also known as
// state mutability attributes, define what changes are allowed within the
// global Ethereum state.
// The use of these modifiers is the reduction of gas prices, as they give promises
// to what can actually be changed and would use gas.

// https://coinsbench.com/7-lets-learn-solidity-constant-variables-1f894c33c63a
// The constant keyword specifies a variable that can not be changed, once it is initialized.
// Variables outside of a contract must be constant.
uint public constant myConstUInt;
// https://stackoverflow.com/questions/45867572/solidity-return-function-why-the-constant
// A constant function should not change the state (not fully enforced yet)
function myConstFunction public constant returns (uint) {
    return 0;
}

// https://www.educative.io/answers/what-is-a-view-function-in-solidity
// A view function is a function that only reads but does never alter and future interactions
// with a contract (it replaces constant).
// A view function can only call other view and pure functions.
function myViewFunction public view return (uint) {
    return 0;
}

// https://www.educative.io/answers/what-are-pure-functions-in-solidity
// A pure function is like a view function except that it can only use local
// variables and arguments.
function myPureFunction public pure return (uint) {
    return 0;
}