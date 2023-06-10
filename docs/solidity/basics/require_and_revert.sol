// The require keyword is used to make a function require a condition, if it fails
// all previous changes are reverted and no gas is consumed
function myFunc() {
    require(someCondition());
}
// A require statement can also return a string about what went wrong
function myFunc() {
    require(someCondition(), "The condition X was not met.");
}

// The revert statement works like the require statement only that it works together with an error
function myFunc() {
    revert(myError({
        myErrorParam1: someParam,
        myErrorParam2: someOtherParam
    }));
}