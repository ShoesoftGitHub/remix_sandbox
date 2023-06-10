// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;


/// @title Pollable library
/// @author Shoesoft
library PollableLibrary {
    /**
     * @dev The votee struct
     */
    struct PollVotee {
        address voteeAddress;
        address delegateVotee;
        address[] delegateFromVotees;
        uint8 numVotes;
        uint64[] votedOptions;
    }

    /** 
     * @dev This is a type for a single option.
     */
    struct PollOption {
        bytes32 name;
        uint64 voteCount;
        uint weight;
    }

    /**
     * @dev This is a settings struct for a poll
     */
    struct PollSettings {
        bool anyoneCanCreateOptions;
        uint minimumOptionCreateAmount;
        uint8 amountOptionsCreatable;
        uint8 maxVotableOptions;
        uint8 amountWinners;
        bool optionWeightInfluencesWinning;
        /**
         * @dev value between 0 and 100 correlates to 0.0 to 1.0
         */
        uint8 optionWeightInfluenceFactor;
    }

    /**
     * @dev This is the type for a poll itself
     */
    struct Poll {
        address chairperson;
        mapping(address => PollVotee) votees;
        address[] voteeAddresses;
        PollOption[] options;
        bool isActive;
        bytes32 name;
        PollSettings settings;
    }
}