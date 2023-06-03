// https://www.youtube.com/watch?v=RQzuQb0dfBM
// The receive function can be used to receive ether to a contract
receive() external payable {}
// The fallback function can be used alternatively
fallback() external payable {
    // Arbitrary logic can be implemented
    uint myUInt = 1;
}
