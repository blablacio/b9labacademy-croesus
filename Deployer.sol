/**
 *Submitted for verification at Etherscan.io on 2019-05-23
*/

pragma solidity 0.5.10;

contract Croesus {
    constructor() public {
        require(address(this).balance > 0);
    }
}

contract CroesusFactory {
    mapping (address => bool) public winners;
    
    event LogWon(address indexed sender, address indexed croesus, bytes32 braggingRights);

    function tryToWin(bytes32 braggingRights) public {
        winners[msg.sender] = true;
        emit LogWon(msg.sender, address(new Croesus()), braggingRights);
    }
}

contract Deployer {
    constructor(CroesusFactory factory, bytes32 bragger) payable public {
        address(uint160(uint256(keccak256(abi.encodePacked(byte(0xd6), byte(0x94), factory, byte(0x01)))))).transfer(msg.value);
        factory.tryToWin(bragger);
    }
}
