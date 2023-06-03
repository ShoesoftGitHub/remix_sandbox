// An event is being cast and relies on the blockchain, contracts can listen to events to
// react to them
// Events start with an uppercase letter by convention
event MyEvent(uint param1, uint param2);

// Events can be emitted
function myFunc(uint inParam1, uint inParam2) public {
    emit MyEvent(inParam1, inParam2);
}

// https://ethereum.stackexchange.com/questions/8658/what-does-the-indexed-keyword-do
// Event arguments can be declared as indexed
// It is possible to filter by indexed arguments in the event log
event MyEvent(uint indexed param1);