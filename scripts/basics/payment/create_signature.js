// This is a method to cryptographically sign a message using MetaMask and web3 as
// proposed in EIP 721
/// Hashing first makes things easier
var hash = web3.utils.sha3("message to sign");
web3.eth.personal.sign(hash, web3.eth.defaultAccount, function () { console.log("Signed"); });

// This method can be used to sign messages for contracts/basics/payment/ReceiverPays.sol.
// For a contract that fulfils payments, the signed message must include:
// - The recipient’s address.
// - The amount to be transferred.
// - Protection against replay attacks.
//  - For this use nonces
//  - Optionally use the contract too, for destruct and new contract replay

// This function uses soliditySHA3 of the ethereumjs-abi library which mimics
// keccak256 of solidity applied to arguments encoded using abi.encodePacked
// recipient is the address that should be paid.
// amount, in wei, specifies how much ether should be sent.
// nonce can be any unique number to prevent replay attacks
// contractAddress is used to prevent cross-contract replay attacks
function signPayment(recipient, amount, nonce, contractAddress, callback) {
    var hash = "0x" + abi.soliditySHA3(
        ["address", "uint256", "uint256", "address"],
        [recipient, amount, nonce, contractAddress]
    ).toString("hex");

    web3.eth.personal.sign(hash, web3.eth.defaultAccount, callback);
}