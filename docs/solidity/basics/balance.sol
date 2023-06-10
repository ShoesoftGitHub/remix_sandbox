// https://www.youtube.com/watch?v=RQzuQb0dfBM
// The balance of an address can be checked with balance
address myAddress;
uint balance = myAddress.balance;
// It is also possible to get the balance of the own contract
uint balance = address(this).balance;