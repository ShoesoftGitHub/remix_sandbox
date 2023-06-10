// A blockchain is a globally shared transactional database.
// Reading:
// Everyone can read the database by participating in the network.

// Changing:
// If someone wants to change something in the database,
// a transaction has to be created that has to be accepted by everyone.
// Changes could be f.e. changing two values at the same time.

// Changes are complete:
// A transaction implies that a change is either not done at all
// or completely applied. This ensures that a value that is
// subtracted from one account is always added to the other or
// the process is reverted.
// Only one transaction can alter the database at the same time.

// Cryptographic signature:
// A transaction is always cryptographically signed by the sender (creator).
// Modifications to the database can be guarded like this.
// F.e. a check that a person is holding the keys to an account ensures
// that only that person can transfer money from it.

// Blocks:
// The problem of a case where two transactions with the same change
// are happening is solved via blocks.
// An order of the transactions is selected globally, they
// are bundled into blocks and then executed and distributed
// among all participating nodes.
// If two transactions contradict each other, the latter one
// will be rejected and not become part of the block.

// Blocks sequence:
// Blocks form a linear sequence in time, hence the term "blockchain".
// Blocks are added to the chain at regular intervals, they might
// be subject to change in the future though.

// Mining:
// The "order selection mechanism", called "mining", may make it
// happen that blocks are reverted, but only at the tip of the chain.
// The more blocks are added on top of a block the less likely it is
// for it to be reverted.

// Transaction inclusion:
// Transactions are not guaranteed to be included in the next block, it
// is up to the miners to determine this.

// Scheduling future calls:
// To schedule future calls of a contract, a smart contract automation tool or 
// an oracle service can be used.