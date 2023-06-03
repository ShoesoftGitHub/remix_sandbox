// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.2;


contract Ownable
{
    address public owner;

    event onTransferOwnership(address previousOwner, address newOwner);
    
    error notOwner(address notOwnerAddress, address ownerAddress);
    
    error transferIsAlreadyOwner(address ownerAddress);
    
    modifier onlyOwner() {
        if(!_isOwner(msg.sender)) {
            revert notOwner({
                notOwnerAddress: msg.sender,
                ownerAddress: owner
            });
        }
        _;
    }

    function _isOwner(address inAddress) internal view returns (bool) {
        return inAddress == owner;
    }

    function isOwner(address inAddress) public view returns (bool) {
        return inAddress == owner;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        if(_isOwner(newOwner)) {
            revert transferIsAlreadyOwner({ ownerAddress: owner });
        }
        address previousOwner = owner;
        owner = newOwner;
        emit onTransferOwnership(previousOwner, owner);
    }

    function renounceOwnership() public onlyOwner {
        if(!isOwner(0x0000000000000000000000000000000000000000)) {
            transferOwnership(0x0000000000000000000000000000000000000000);
        } else {
            revert("The ownership has already been renounced.");
        }
    }

    constructor()
    {
        owner = msg.sender;
    }

}