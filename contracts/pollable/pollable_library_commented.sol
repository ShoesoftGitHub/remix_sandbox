// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;


/// @title Pollable library
/// @author Shoesoft
library PollableLibrary {
    /**
     * @dev The type of a poll
     */
    enum PollType { 
        GENERAL, 
        ADD_POLLMASTER, KEEP_POLLMASTER, REMOVE_POLLMASTER, 
        APPROVE_CITIZEN, KEEP_CITIZEN, REMOVE_CITIZEN
    }

    /**
     * @dev The votee struct
     */
    struct PollVotee {
        // Address of the votee
        address voteeAddress;
        // Votee delegated to
        address delegateVotee;
        // Votees delegated from
        address[] delegateFromVotees;
        // How often that person has voted
        uint8 numVotes;
        // Indices of the voted options
        uint64[] votedOptions;
    }

    /** 
     * @dev This is a type for a single option.
     */
    struct PollOption {
        // Short name (up to 32 bytes)
        bytes32 name;
        // Number of accumulated votes
        uint64 voteCount;
        // Weight of the option, how many tokens the creator held
        uint weight;
    }

    /**
     * @dev This is a settings struct for a poll
     */
    struct PollSettings {
        // If anyone can create options
        bool anyoneCanCreateOptions;
        // Minimum amount of tokens held to create an option
        uint minimumOptionCreateAmount;
        // How many options each votee can create
        uint8 amountOptionsCreatable;
        // How many options each votee can vote for
        uint8 maxVotableOptions;
        // Amount of winning options that will be picked
        uint8 amountWinners;
        // If option weight should influence winning
        bool optionWeightInfluencesWinning;
        // Factor how much the option weight influences winning
        /**
         * @dev value between 0 and 100 correlates to 0.0 to 1.0
         */
        uint8 optionWeightInfluenceFactor;
    }

    /**
     * @dev This is the type for a poll itself
     */
    struct Poll {
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
        // Settings of the poll
        PollSettings settings;
    }
}