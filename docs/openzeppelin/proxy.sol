1. Introduction
https://docs.openzeppelin.com/contracts/4.x/api/proxy
A proxy contract is a contract, that allows all of the logic to be stored on a
logic contract and then forward calls to it.

2. Why Delegating Proxies?
Proxies are used to implement upgradeability and to reduce gas costs.

3. EIP-1967
https://eips.ethereum.org/EIPS/eip-1967
A proxy contract implements EIP-1967 storage slots, to store storage data so that 
it cannot clash with the logic contract and at the same time be standardized
so that a block explorer for example knows where to look for it.

4. delegatecall
Proxies use delegatecall to call the underlying logic contract.

5. Persistent State
Proxies can have a persistent state, both storage and balance.

6. Storage Use Clash
Proxies usually save the address of the logic contract in a specific storage slot
that is guaranteed to never be allocated by the compiler.

7. Why EIP-1967?
EIP-1967 provides standard storage slots for block explorers and logic contracts to 
operate with.
F.e. in a block explorer the end user wants it to show the ABI of the logic contract
and not the proxy.
Logic contracts can act upon the fact that they are proxied, they can trigger
a code update.

