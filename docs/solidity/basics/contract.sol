// Contracts are classes and at the same time the code that runs at a blockchain address.
// Contracts have 3 types of stored data:
// - storage which is persistent
// - memory which is instanced for each message call
// - stack

// https://www.geeksforgeeks.org/solidity-abstract-contract/
// abstract contracts are contracts that either:
// - have at least 1 function without implementation that is implemented in a derived contract
abstract contract Base {
    function MyFunc() public virtual;
}
contract Derived is Base {
    function MyFunc() public override {};
}
// If a derived contract does not implement incomplete functions it is also marked abstract
abstract contract Derived is Base {
}
// - arguments are not provided for all base class constructors
// - are not intended to be created directly
// This contract will never be created but only serves as a parent contract.
abstract contract Base {
    function MyFunc() public virtual;
}
contract Derived is Base {
}
// An instance of an abstract contract can hold a derived contract
Base cont = new Derived();

// https://leftasexercise.com/2021/09/05/a-deep-dive-into-solidity-contract-creation-and-the-init-code/
// https://medium.com/upstate-interactive/creating-a-contract-with-a-smart-contract-bdb67c5c8595
