// https://medium.com/upstate-interactive/solidity-override-vs-virtual-functions-c0a5dfb83aaf
// virtual functions are functions that can be overriden in child contracts
contract Base {
    // A base virtual function
    function myFunc() virtual public {}
}

contract Derived is Base {
    // A function override
    function myFunc() override public {}
    // A function can be both virtual and overridden
    function myFunc() virtual override public {}
    // If a contract inherits multiple contracts that both have the function
    // the override has to be specified
    function myFunc() override(Base1, Base2) public {}
}

// All functions in interface contracts are considered virtual