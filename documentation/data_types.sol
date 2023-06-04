// Variables are declared like {type}{access modifier}{state mutability attribute}{storage type}{name}
// Variable names start with a lower case letter by coding convention
// Access modifier and state mutability attribute can be omitted.

// An unsigned integer
uint myUInt;

// An address, that is a 160 bit type to store addresses of contracts or the hash
// of a public half of a key pair, belonging to an external account
address myAddress;

// A public variable, that can be automatically accessed from outside the contract,
address public myPublicAddress;
// The compiler generates a getter function like this:
function myPublicAddress_() external view returns (address) { return myPublicAddress; }

// A map, that maps uints to addresses
// It is not possible to get a list of all keys or values of a mapping
mapping(address => uint) myMapping;
// A getter function created by a public mapping looks like this:
function myPublicMapping_(address account) external view returns (uint) {
    return myPublicMapping[account];
}

// An event is an object that can be emitted.
// Ethereum clients, such as web applications can listen to events emitted on the blockchain.
// The listener receives the arguments.
event myEvent(address from, address to, uint amount);
// This is sample web3.js code that listens to an event:
Coin.Sent().watch({}, '', function(error, result) {
    if (!error) {
        console.log("Coin transfer: " + result.args.amount +
            " coins were sent from " + result.args.from +
            " to " + result.args.to + ".");
        console.log("Balances now:\n" +
            "Sender: " + Coin.balances.call(result.args.from) +
            "Receiver: " + Coin.balances.call(result.args.to));
    }
})

// The msg variable is a special global variable that contains properties
// that allow access to the blockchain.
msg
// msg.sender is always the address where the current (external) function call came from.
// It can also be the creator of a contract.
msg.sender

// An error object allows to provide more information to a caller about why an operation failed.
error myError(uint myArgument, uint mySecondArgument);
// Errors are used with the revert statement which unconditionally reverts and aborts all
// changes. It is similar to the require statement but allows to provide an error and
// additional data to the caller, front-end application or block explorer.
revert myError({
    myArgument: myLocalVariable,
    mySecondArgument: myOtherLocalVariable
});

// Arrays are dynamically sizable and can be used to store multiple variables
uint[] public myUIntArray;
// Arrays can be accessed with []
uint myUInt = myUIntArray[0];
// push adds something to the end of an array
myUIntArray.push(0);
// pop removes something from the end of an array
myUIntArray.pop();

// https://stackoverflow.com/questions/33839154/in-ethereum-solidity-what-is-the-purpose-of-the-memory-keyword
// The memory keyword can be used to explicitly say that a variable should be stored in memory
// This can be used to make a struct, array or mapping be stored in memory since it is stored
// in storage by default.
uint memory myMemoryUInt;
// The storage keyword can be used to explicitly say that a variable should be stored in storage
// This can be used to make references
uint storage myStorageUInt;

// constant state variables need their value assigned at compile time
uint public constant myPublicConstUInt = 1;
// immutable state variables need their value assigned at least at construction
uint public immutable myImmutableUInt;
constructor() {
    myImmutableUInt = 1;
}