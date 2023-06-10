// https://www.tutorialspoint.com/solidity/solidity_enums.htm
// Enums can be defined
enum MyEnum {ONE, TWO, THREE}
// An enum variable can be declared
MyEnum enm;
// An enum variable can be set
enm = MyEnum.ONE;
// Enums can be cast to uint
uint enmUInt = uint(enm);