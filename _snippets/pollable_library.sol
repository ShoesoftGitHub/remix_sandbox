// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.2;


// The Pollable library
library PollableLibrary
{
    // The votee struct
    struct PollVotee
    {
        // If true, that person has already voted
        bool hasVoted;
        // Address of the votee
        address voteeAddress;
        // Votee delegated to
        address delegateVotee;
        // Votees delegated from
        address[] delegateFromVotees;
        // Index of the voted option
        uint votedOptionIndex;
    }

    // This is a type for a single option.
    struct PollOption
    {
        // Short name (up to 32 bytes)
        bytes32 name;
        // Number of accumulated votes
        uint voteCount;
        // Weight of the option, how many tokens the creator held
        uint weight;
    }

    // This is the type for a poll itself
    struct Poll
    {
        // The chairperson of the poll
        address chairperson;
        // A mapping to store a votee for each voting address
        mapping(address => PollVotee) votees;
        // An array holding each votee address
        address[] voteeAddresses;
        // All options
        PollOption[] options;
        // If the poll is active
        bool isActive;
        // Name of the poll
        bytes32 name;
        // If anyone can create options
        bool anyoneCanCreateOptions;
        // Minimum amount of tokens held to create an option
        uint minimumOptionCreateAmount;
    }

}