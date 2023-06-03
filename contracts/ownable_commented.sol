// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.2;


// https://docs.openzeppelin.com/contracts/2.x/api/ownership
// This is a snippet for an ownable contract, that orients itself at the open zeppelin contract
contract Ownable
{
    // The owner address
    address public owner;

    // This event gets called when the ownership is transferred
    event onTransferOwnership(address previousOwner, address newOwner);

    // This error gets thrown when an address is not the Owner
    error notOwner(address notOwnerAddress, address ownerAddress);

    // This error gets thrown when an address of an owner transfer is the same as the owner
    error transferIsAlreadyOwner(address ownerAddress);

    // An only owner modifier that makes it possible for functions to be only called
    // by the owner
    modifier onlyOwner() {
        if(!_isOwner(msg.sender)) {
            revert notOwner({
                notOwnerAddress: msg.sender,
                ownerAddress: owner
            });
        }
        _;
    }

    // Returns true if an address is the Owner
    // Internal version with less gas fee
    function _isOwner(address inAddress) internal view returns (bool) {
        return inAddress == owner;
    }

    // Returns true if an address is the Owner
    function isOwner(address inAddress) public view returns (bool) {
        return inAddress == owner;
    }

    // A function to transfer the ownership
    function transferOwnership(address newOwner) public onlyOwner {
        if(_isOwner(newOwner)) {
            revert transferIsAlreadyOwner({ ownerAddress: owner });
        }
        address previousOwner = owner;
        owner = newOwner;
        emit onTransferOwnership(previousOwner, owner);
    }

    // A function to renounce the ownership
    function renounceOwnership() public onlyOwner {
        if(!isOwner(0x0000000000000000000000000000000000000000)) {
            transferOwnership(0x0000000000000000000000000000000000000000);
        } else {
            revert("The ownership has already been renounced.");
        }
    }

    constructor()
    {
        // Set the Owner to the contract creator in the constructor
        owner = msg.sender;
    }

}