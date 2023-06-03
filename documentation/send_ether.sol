// https://www.youtube.com/watch?v=RQzuQb0dfBM
// It is possible to send ether to another address using the call method
function transfer(address payable _to) public payable {
    (bool sent, ) = _to.call{value: msg.value}("");
    require(sent, "Failed!");
}