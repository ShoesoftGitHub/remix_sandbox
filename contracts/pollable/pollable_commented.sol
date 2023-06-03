// The following contract has an automatic and transparent voting system.
// A pollable contract can create polls.
// The chariman of the contract will give rights to each address that can vote.
// An address can vote itself or delegate the vote to another address.
// At the end of the voting time, the option with the most votes is calculated.
// Vote weight can be influenced by amount of tokens held of a specified type.

// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;
import "contracts/ownable/ownable_commented.sol";
import "contracts/pollable/pollable_library_commented.sol";


/// @title Pollable contract
/// @author Shoesoft
abstract contract Pollable is Ownable {
    /**
     * @dev All current polls
     */
    PollableLibrary.Poll[] internal polls;

    /**
     * @dev Event that fires when a poll has been added
     */
    event OnAddPoll(PollableLibrary.Poll poll);

    /**
     * @dev Event that fires when a poll has been removed
     */
    event OnRemovePoll(PollableLibrary.Poll poll);

    /**
     * @dev Event that fires when a poll option is added
     */
    event OnAddPollOption(PollableLibrary.Poll poll, 
        PollableLibrary.PollOption option, address creator);

    /**
     * @dev Error that is thrown when a poll could not be found
     */
    error CannotFindPoll(bytes32 pollName);

    /**
     * @dev Error that is thrown when a poll option cannot be added
     */
    error CannotCreateOption(PollableLibrary.Poll poll, address creator);

    /**
     * @dev Returns a poll, for internal use
     */
    function getPollInternal(bytes32 pollName) internal returns (PollableLibrary.Poll storage) {
        for (uint i = 0; i < polls.length; i++) {
            if (polls[i].name == pollName) {
                return polls[i];
            }
        }
        revert(CannotFindPoll({pollName: pollName}));
    }

    /**
     * @dev Returns a poll, for external use
     */
    function getPoll(bytes32 pollName) external view returns (PollableLibrary.Poll) {
        for (uint i = 0; i < polls.length; i++) {
            if (polls[i].name == pollName) {
                return polls[i];
            }
        }
        revert(CannotFindPoll({pollName: pollName}));
    }

    /**
     * @dev Adds a poll
     */
    function addPoll(PollableLibrary.Poll poll) public onlyOwner {
        polls.push(poll);
        emit OnAddPoll(polls[polls.length - 1]);
    }

    /**
     * @dev Removes a poll by name
     */
    function removePoll(bytes32 pollName) public onlyOwner {
        int pollIndex = -1;
        for (uint i = 0; i < polls.length; i++) {
            if (polls[i].name == pollName) {
                pollIndex = i;
                break;
            }
        }
        if (pollIndex == -1) {
            revert(CannotFindPoll({pollName: pollName}));
        } else {
            PollableLibrary.Poll memory removedPoll = polls[pollIndex];
            for (uint i = pollIndex; i < polls.length-1; i++) {
                polls[i] = polls[i+1];
            }
            delete polls[polls.length-1];
            polls.length--;
            emit OnRemovePoll(removedPoll);
        }
    }

    /**
     * @dev Sets a poll active or inactive
     */
    function setPollActive(bytes32 pollName, bool isActive) public onlyOwner {
        PollableLibrary.Poll storage poll = getPollInternal(pollName);
        poll.isActive = isActive;
    }

    /**
     * @dev Returns if an address can create an option on a poll
     */
    function canAddressCreateOption(
        address creator, 
        PollableLibrary.Poll poll
    ) 
        public pure returns (bool)
    {
        // TODO: Implement interface and check balance of token here
        // return ERC20(poll.voteCurrency).balanceOf(creator) >= poll.minimumOptionCreateAmount;
        return false;
    }

    // TODO: Implement max poll options that can be added

    // TODO: Implement system where users can first vote on what options should be included in the vote
    // Or make this another poll?

    /**
     * @dev Adds a poll option to a poll
     */
    function addPollOption(
        bytes32 pollName, 
        PollableLibrary.PollOption option
    ) 
        external
    {
        PollableLibrary.Poll storage poll = getPollInternal(pollName);
        if (canAddressCreateOption(msg.sender, poll)) {
            poll.options.push(option);
            emit OnAddPollOption({poll: poll, option: option, creator: msg.sender});
        } else {
            revert(CannotCreateOption({poll: poll, creator: msg.sender}));
        }
    }

    /**
     * @dev Give a votee the right to vote on a Poll.
     * May only be called by chairperson.
     */
    function giveRightToVoteOnPoll(
        bytes32 pollName, 
        address voteeAddress
    ) 
        public 
    {
        // Get a reference to the poll
        PollableLibrary.Poll storage poll = getPollInternal(pollName);
        // If the caller is not the chairperson abort
        require(
            msg.sender == poll.chairperson,
            "Only chairperson can give right to vote."
        );
        // Set the voteWeight of the votee to 1
        poll.votees[voteeAddress].voteWeight = 1;
    }

    /**
     * @dev Delegate a voteWeight to another votee
     */
    function delegateVote(address toVoteeAddress) external {
        // Assigns a reference to the caller votee
        PollableLibrary.PollVotee storage sender = votees[msg.sender];
        // If the caller has a voteWeight of 0 abort
        require(sender.voteWeight != 0, "You have no right to vote.");
        // If the caller has already voted abort
        require(!sender.hasVoted, "You already voted.");
        // If the caller delegates the vote to itself abort
        require(toVoteeAddress != msg.sender, "Self-delegation is disallowed.");
        // Forward the delegation as long as toVoteeAddress also delegated.
        // Note: while loops are dangerous
        while (votees[toVoteeAddress].delegateVotee != address(0)) {
            // Set the toVoteeAddress to the delegated address
            toVoteeAddress = votees[toVoteeAddress].delegateVotee;
            // Check if the delegate address is not the sender
            require(toVoteeAddress != msg.sender, "Self-delegation found in delegate.");
        }
        // Store the new delegate votee in storage
        Votee storage delegateVotee_ = votees[toVoteeAddress];
        // votees cannot delegate to votees that cannot vote.
        require(delegateVotee_.voteWeight >= 1);
        // Alter the sender votee
        // Since sender is a reference, this modifies votees[msg.sender].
        sender.hasVoted = true;
        sender.delegateVotee = toVoteeAddress;
        // If the delegateVotee_ already voted, directly add to the number of votes
        if (delegateVotee_.hasVoted) {
            options[delegateVotee_.votedOptionIndex].voteCount += sender.voteWeight;
        } 
        // If the delegateVotee_ did not vote yet, add to its voteWeight.
        else {
            delegateVotee_.voteWeight += sender.voteWeight;
        }
    }

    /**
     * @dev Give a vote including delegated voteWeight
     * to an Option options[optionIndex].name.
     */
    function vote(uint optionIndex) external {
        // Store the sender as a reference
        Votee storage sender = votees[msg.sender];
        // If the sender has no weight abort
        require(sender.voteWeight != 0, "Has no right to vote.");
        // If the sender already voted abort
        require(!sender.hasVoted, "Has already voted.");
        // Alter the sender
        sender.hasVoted = true;
        sender.votedOptionIndex = optionIndex;
        // If optionIndex is out of the range of the array,
        // this will throw automatically and revert all
        // changes.
        options[optionIndex].voteCount += sender.voteWeight;
    }

    /** 
     * @dev Computes the winning option taking all
     * previous votes into account and returns the winning option index.
     */
    function calculateWinningOption() public view 
        returns (uint winningOptionIndex)
    {
        uint winningVoteCount = 0;

        // Loop all Options and return the one with the highest voteCount
        for (uint p = 0; p < options.length; p++) {
            if (options[p].voteCount > winningVoteCount) {
                winningVoteCount = options[p].voteCount;
                winningOptionIndex = p;
            }
        }
    }

    /**
     * @dev Calls calculateWinningOptions() to get the index
     * of the winner contained in the options array and then
     * returns the name of the winner
     */
    function winningOptionName() external view
        returns (bytes32 winningOptionName_)
    {
        winningOptionName_ = options[calculateWinningOption()].name;
    }

    constructor(bytes32[] memory optionNames) {
        chairperson = msg.sender;
        votees[chairperson].voteWeight = 1;
        // For each of the provided option names,
        // create a new Option struct and add it
        // to the end of the array.
        for (uint i = 0; i < optionNames.length; i++) {
            // Option({...}) creates a temporary
            // Option object and options.push(...)
            // appends it to the end of options.
            options.push(
                Option({
                    name: optionNames[i],
                    voteCount: 0
                })
            );
        }
    }
}