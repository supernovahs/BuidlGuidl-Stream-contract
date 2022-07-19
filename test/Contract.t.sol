// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Contract.sol";
import "forge-std/Vm.sol";
import "../src/streamcontract.sol";


///     Foundry tests for the BuidlGuidl Stream Contract

///     Tests are run on forked mainnet
 

contract ContractTest is Test {

    
    
    BGstream public streamcontract;

    
///    Set  up function for tests
        
     
    function setUp() public {
        vm.prank(0x1b37B1EC6B7faaCbB9AddCCA4043824F36Fb88D8);// Setting msg.sender as supernovahs.eth
        streamcontract = new BGstream(payable(0x1b37B1EC6B7faaCbB9AddCCA4043824F36Fb88D8), 0.5 ether, 1296000, false);// Instantiating new stream , 0.5 ether every 2 weeks
        uint64 _laststreamwithdraw = streamcontract.last();
        uint _cap = streamcontract.cap();
        uint64 _frequency = streamcontract.frequency();
        address _toAddress = streamcontract.toAddress();
        assertEq(_laststreamwithdraw,block.timestamp);
        assertEq(_cap,0.5 ether);
        assertEq(_frequency,1296000);
        assertEq(_toAddress,0x1b37B1EC6B7faaCbB9AddCCA4043824F36Fb88D8);
    }

    function teststreamdeposit() public {
        streamcontract.streamDeposit{value: 0.5 ether}("Hello");

        assertEq(address(streamcontract).balance,0.5 ether);
    }

    function teststreambalance() public {
        uint64 _laststreamwithdraw = streamcontract.last();
        uint64 _timestamp = uint64(block.timestamp);
        if(_timestamp-_laststreamwithdraw > streamcontract.frequency()){
            assertEq(streamcontract.streamBalance(),0.5 ether);
        }
        else{
            assertEq(streamcontract.streamBalance(),(0.5 ether * (_timestamp-_laststreamwithdraw)) / streamcontract.frequency());
        }
    }

    function teststreamwithdraw() public {
        streamcontract.streamDeposit{value: 0.5 ether}("Hello");
        uint bal = streamcontract.streamBalance();
        uint etherbefore = address(streamcontract).balance;
        vm.prank(0x1b37B1EC6B7faaCbB9AddCCA4043824F36Fb88D8);
        streamcontract.streamWithdraw(bal,"test");
        assertEq(address(streamcontract).balance,etherbefore - bal);
    }




//     function testOptimized() public {
//         assertTrue(true);
//         uint a = streamcontract.streamBalance();
//         uint64 b = streamcontract.last();
//         uint c = streamcontract.cap();
//         console.log(
//             "last time",b
//         );
//         console.log("cap",c);
//         console.log("a",a);
//         // assertTrue(a == 0.5 ether);
//     }

//     function testOriginal() public {
//         assertTrue(true);
//         uint a = simplecontract.streamBalance();
//         uint b = simplecontract.last();
//         uint c = simplecontract.cap();
//         console.log(
//             "last time",b
//         );
//         console.log("cap",c);
//         console.log("a",a);
//         // assertTrue(a == 0.5 ether);

//     }

//    function testdeposit() public {
//        streamcontract.streamDeposit{value: 10000000000000000}("hello");
//        uint bal;
//        address stream= address(streamcontract);
//        assembly{
//            bal:= balance(stream)
//        }
//        assertTrue(bal == 10000000000000000);
//    }

//    function testwithdraw() public {
      
//        vm.deal(0x1b37B1EC6B7faaCbB9AddCCA4043824F36Fb88D8,10 ether);
//         streamcontract.streamDeposit{value: 10000000000000000}("hello");
//        vm.prank(0x1b37B1EC6B7faaCbB9AddCCA4043824F36Fb88D8);
//      streamcontract.streamWithdraw(10000000,"Buidling");
    
//    }

//    function testwithdraworiginal() public {
//        vm.deal(0x1b37B1EC6B7faaCbB9AddCCA4043824F36Fb88D8,10 ether);
//         simplecontract.streamDeposit{value: 10000000000000000}("hello");
//        vm.prank(0x1b37B1EC6B7faaCbB9AddCCA4043824F36Fb88D8);
//      simplecontract.streamWithdraw(10000000,"Buidling");
//    }
}
