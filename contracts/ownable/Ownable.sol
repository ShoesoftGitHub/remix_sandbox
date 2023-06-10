// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;


/// @title Ownable contract
/// @author Shoesoft
/**
 * @dev https://docs.openzeppelin.com/contracts/2.x/api/ownership
 * This is a snippet for an ownable contract, that orients itself at the open zeppelin contract
 * This is not the OpenZeppelin Ownable contract
 */
abstract contract Ownable {
    /**
     * @dev The owner address
     */
    address public owner;

    /**
     * @dev This event gets called when the ownership is transferred
     */
    event OnTransferOwnership(address previousOwner, address newOwner);

    /**
     * @dev This error gets thrown when an address is not the Owner
     */
    error NotOwner(address notOwnerAddress, address ownerAddress);

    /**
     * @dev This error gets thrown when an address of an owner transfer is the same as the owner
     */
    error TransferIsAlreadyOwner(address ownerAddress);

    /**
     * @dev An only owner modifier that makes it possible for functions
     * to be only called by the owner
     */
    modifier onlyOwner() {
        if (!_isOwner(msg.sender)) {
            revert NotOwner({
                notOwnerAddress: msg.sender,
                ownerAddress: owner
            });
        }
        _;
    }

    /** 
     * @dev Returns true if an address is the Owner
     * Internal version with less gas fee
     */
    function _isOwner(address inAddress) internal view returns (bool) {
        return inAddress == owner;
    }

    /**
     * @dev Returns true if an address is the Owner
     */
    function isOwner(address inAddress) public view returns (bool) {
        return inAddress == owner;
    }

    /**
     * @dev A function to transfer the ownership
     */
    function transferOwnership(address newOwner) public onlyOwner {
        if (_isOwner(newOwner)) {
            revert TransferIsAlreadyOwner({ ownerAddress: owner });
        }
        address previousOwner = owner;
        owner = newOwner;
        emit OnTransferOwnership(previousOwner, owner);
    }

    /**
     * @dev A function to renounce the ownership
     */
    function renounceOwnership() public onlyOwner {
        if (!isOwner(0x0000000000000000000000000000000000000000)) {
            transferOwnership(0x0000000000000000000000000000000000000000);
        } else {
            revert("The ownership has already been renounced.");
        }
    }

    constructor() {
        owner = msg.sender;
    }
}