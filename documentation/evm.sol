// The Ethereum Virtual Machine or EVM is the runtim environment
// for smart contracts in Ethereum.

// Isolated
// ###############
// The EVM is sandboxed and isolated. Code running inside has no
// access to network, filesystem or other processes.
// Smart contracts has limited access to other smart contracts.

// Accounts
// ###############
// External accounts:
// External accounts are controlled by public-private key pairs
// (humans).
// The address of an external account is determined by the public key.
// Contract accounts:
// Contract accounts are controlled by the code together with the account.
// How contract addresses are created and nonces:
// The address of a contract is determined at the time of creation,
// it is derived from the creator address and number of transactions
// sent from that address, which is called nonce.
// The EVM treats both types equally, wether code is stored does not
// matter.
// Storage:
// Every account has a 256bit word to 256bit word mapping storage which
// is persistent.
// Balance:
// Every account has a balance in Ether (actually in Wei) which can
// be modified by sending transactions that include Ether.

// Transactions
// ###############
// A transaction is a message that is send from one account to another.
// It can also be sent to an empty or the same account.
// A transaction can contain binary data (the payload) and Ether.
// If the target account contains code, that code is executed and
// the payload is provided as input data.
// New contract:
// If the target account is not set (the transaction does not have a
// recipient or the recipient is set to null), the transaction
// creates a new contract.
// The address of the new contract is derived from the sender and its nonce.
// The payload of such a transaction is taken to be EVM bytecode
// and executed.
// The output data of this execution is stored aas the code of the contract.
// Thus to create a contract not the actual code is sent but code that creates it.
// Contract under construction:
// One should not call back into a contract under construction until
// its constructor has finished executing since the code is still empty.

// Gas
// ###############
// The originator of a transaction (tx.origin) has to pay gas for a 
// transaction. This gas is gradually depleted as the EVM executes the
// transaction.
// Out of gas:
// Should the gas ever be negative an out-of-gas exception
// is triggered that ends execution and reverts all modifications made
// to the state in the current call frame.
// Economic:
// This mechanism incentivizes economical use of EVM execution time.
// It compensates EVM executors (miners, stakers) for their work.
// Each block has a maximum amount of gas so it limits the amount
// of work needed to validate a block.
// Gas price:
// The originator of a transaction sets the gas price. The originator
// has to pay gas price * gas up front to the EVM executor.
// Leftover gas:
// Leftover gas is refunded to the transaction originator.
// Exception gas:
// In case of an exception that reverts changes, already used up gas
// is not refunded.
// Abuse:
// Transaction senders can not abuse the system by setting a low gas price,
// since EVM executors can choose to include a transaction or not.

// Storage, Memory and the Stack
// ###############
// The EVM has three areas where it can store data: Storage, memory and the stack.
// Storage:
// The storage is per account and it is persistent between function calls
// and transactions.
// Storage Map:
// The storage is a key-value store that maps 256-bit words to 256-bit words.
// Enumerate, Read, Initialize, Modify:
// Storage can not be enumerated from within a contract, it is 
// comparatively costly to read and even more to initialise and modify storage.
// This is why the contract should minimize what it needs to store in the 
// storage. Things like derived calculations, caching and aggregates
// should be stored outside of the contract.
// Only own storage access:
// A contract can only read and write to its own storage.
// Memory:
// Each message call has a freshly cleared instance of the memory.
// Reads and writes:
// Memory is linear and can be addressed at byte level.
// Reads are limited to a width of 256 bits, write can be either 8 bits or
// 256 bits wide.
// Expansion:
// Memory is expanded by a 256-bit word when accessing a previously
// untouched memory word (i.e. any offset within a word).
// Gas paid at expansion:
// At the time of expansion, the cost in gas must be paid.
// Scales quadratically:
// Memory is more costly the larger it grows (it scales quadratically.
// Stack:
// All computations are performed on a data area called the stack.
// Not a register machine:
// The EVM is not a register machine but a stack machine.
// Stack size:
// The stack has a maximum size of 1024 elements and contains words
// of 256 bits.
// Access to stack:
// Access to the stack is limited to the top end. It is possible to copy
// one of the topmost 16 elements to the top of the stack or swap
// the topmost element with one of the 16 elements below it.
// All other operations take the topmost two (or one, or more) elements
// from the stack and push the result onto the stack.
// It is possible to move elements to storage or memory to get deeper
// access to the stack but for that the top first has to be removed.

// Instruction set
// ###############
// The EVM instruction set is kept minimal in order to avoid
// incorrect or inconsistent implementations which could cause
// consensus problems.
// Data type:
// All instructions operate on 256-bit words or on slices of memory
// or other byte arrays.
// Operators:
// Usual arithmetic, bit, logical and comparison operations are present.
// Conditional and unconditional jumps are possible.
// Block properties:
// Contracts can access relevant properties of the current block like
// its number and timestamp.

// Message calls
// ###############
// Contracts can call other contracts or send Ether to non-contract
// accounts by the means of message calls.
// Similar to transactions
// Message calls are similar to transactions, that have a source, a target,
// data payload, Ether, gas and return data.
// Each transaction consists of a top-level message call which in turn can 
// create further message calls.
// Gas control:
// A contract can decide how much of its remaining gas should be sent with
// an inner message call and how much it wants to retain.
// Should an out-of-gas exception happen in the inner call, or any other exception,
// this will be signaled by an error value put onto the stack, only
// the gas sent together with the call is used up.
// The calling contract causes a manual exception by default in such situations,
// so that exceptions "bubble up" the call stack.
// Calldata:
// The called contract which can be same as the caller will receive a 
// freshly cleared instance of memory and has access to the call payload
// which will be provided in a separate area called the calldata.
// After it has finished execution, it can return data which will be stored
// at a location in the caller's memory preallocated by the caller.
// All such calls are fully synchronous.
// Call depth:
// Calls are limited to a depth of 1024 which means that for more complex
// operations loops should be preferred over recursive calls.
// Gas forwarding:
// Only 63/64th of the gas can be forwarded in a messaage call, which
// causes a depth limit of a little less than 1000 in practice.

// Delegatecall and Libraries
// ###############
// A delegatecall is like a message call though the code at the target address
// is executed at the current address, so msg.sender and msg.value do not change.
// Take code:
// A contract can dynamically load code from another address at runtime.
// Storage, current address and balance still refer to the calling contract,
// only the code is taken from the called address.
// Library:
// Libraries are implemented this way, reusable code that can be a applied
// to the storage of a contract.

// Logs
// ###############
// Logs are used to implement events, they are a specially indexed data
// structure that maps all the way up to the block level.
// Access:
// Contracts can not access log data after it has been created, but it
// can be efficiently accessed from outside the blockchain, i.e. a web app.
// Storage:
// Part of the log data is stored in bloom filters, this makes it possible
// to search for the data in an efficient and cryptographically secure way.
// Network peers that do not download the whole blockchain (light clients)
// can still find these logs.

// Create
// ###############
// Contracts can create other contracts using a special opcode (without using
// the zero address transaction method).
// The only difference between these create calls and normal message calls
// is that the payload data is executed and the result stored as code
// and the caller / creator receives the address of the new contract on the stack.

// Deactivate and Self-destruct
// ###############
// The only way to remove code from the blockchain is when a contract
// at that address performs the selfdestruct operation.
// When calling selfdestruct, the remaining Ether stored at that address
// is sent to a designated address and then the code is removed from the state.
// Dangerous:
// Removing a contract in theory sounds like a good idea but it is potentially
// dangerous, f.e. if someone sends Ether to removed contracts.
// Retained:
// Even if a contract is removed by selfdestruct it is still part of the
// history of the blockchain and probably retained by most Ethereum nodes.
// Other ways:
// Even if a contract does not contain a call to selfdestruct it can
// still perform that operation using delegatecall or callcode.
// Deactivation:
// If you want to deactivate a contract it should rather be disabled
// by changing an internal state so that functions revert.

// Precompiled Contracts
// ###############
// The addresses between 1 and including 8 contain "precompiled contracts"
// that can be called as any other contract.
// Behaviour:
// The behaviour and gas consumption is not defined by EVM code stored at
// the addresses, the do no contain code.
// Instead it is implemented in the EVM execution environment itself.
// Different chains:
// Different EVM-compatible chains might use a different set of 
// precompiled contracts.
// New contracts might even be added to the Ethereum main chain in the future.
// They can always be expected to be in the range between 1 and 0xffff inclusive.