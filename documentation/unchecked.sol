// https://ethereum.stackexchange.com/questions/113221/what-is-the-purpose-of-unchecked-in-solidity
// When wrapping an arithmetic operation in unchecked it prevents 
// from throwing overflow / underflow errors
// This can save gas.
unchecked {
    c = a - b;
}