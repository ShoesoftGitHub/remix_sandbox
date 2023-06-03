// An error is a message that can be read from a web end that interacts with a contract
// to give more detailed information about a function cancel
// Errors start with an upper case letter by convention
error MyError(uint param1, uint param2);

// Errors can be broadcast with the revert statement
function myFunc(uint inParam1, uint inParam2) public {
    revert MyError({
        param1: InParam1,
        param2: InParam2
    });
}