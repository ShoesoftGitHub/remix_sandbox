// 1. License
// SPDX-License-Identifier: GPL-3.0

// 2.A Specify Solidity Version as a version
pragma solidity ^0.8.20

// 3. The contract object
contract Coin {

    // 4. An address on the blockchain, that can mint coins.
    address public minter;

    // 5. A map of address and uint which is a balances map of each holder of the coin.
    mapping(address => uint) public balances;

    // 6. An event that will fire every time something has been sent.
    event Sent(address from, address to, uint amount);

    // 7. The constructor is run when the contract is created, it then sets
    // the creator of the contract as the minter address.
    constructor() {
        minter = msg.sender;
    }

    // 8. This creates new coins and sends them to an address.
    // It can only be called by the creator of the contract.
    function mint(address receiver, uint amount) public {
        require(msg.sender == minter);
        balances[receiver] += amount;
    }

    // 9. An error, that is returned to a caller of a function.
    // This error can be used when a balance is insufficient.
    error InsufficientBalance(uint requested, uint available);

    // 10. This function sends an amount from a caller of the function to an address.
    function send(address receiver, uint amount) public {

        // 10.1 If the amount is greater than the balance of the caller
        // it will throw an InsufficientBalance error
        if (amount > balances[msg.sender])
            revert InsufficientBalance({
                requested: amount,
                available: balances[msg.sender]
            });

        // 10.2 The amount to send is subtracted from the balance of the caller.
        balances[msg.sender] -= amount;

        // 10.3 The amount to send is added to the balance of the receiver.
        balances[receiver] += amount;

        // 10.4 The Sent event is being broadcasted.
        emit Sent(msg.sender, receiver, amount);
    }
}