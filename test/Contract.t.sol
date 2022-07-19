// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Contract.sol";
import "forge-std/Vm.sol";
import "../src/streamcontract.sol";

contract ContractTest is Test {

   
    BGstream public streamcontract;
    original public simplecontract;
    function setUp() public {
        vm.prank(0x1b37B1EC6B7faaCbB9AddCCA4043824F36Fb88D8);
        streamcontract = new BGstream(payable(0x1b37B1EC6B7faaCbB9AddCCA4043824F36Fb88D8), 0.5 ether, 1296000, false);
        simplecontract = new original(payable(0x1b37B1EC6B7faaCbB9AddCCA4043824F36Fb88D8), 0.5 ether, 1296000, false);

    }

    function testOptimized() public {
        assertTrue(true);
        uint a = streamcontract.streamBalance();
        uint64 b = streamcontract.last();
        uint c = streamcontract.cap();
        console.log(
            "last time",b
        );
        console.log("cap",c);
        console.log("a",a);
        // assertTrue(a == 0.5 ether);
    }

    function testOriginal() public {
        assertTrue(true);
        uint a = simplecontract.streamBalance();
        uint b = simplecontract.last();
        uint c = simplecontract.cap();
        console.log(
            "last time",b
        );
        console.log("cap",c);
        console.log("a",a);
        // assertTrue(a == 0.5 ether);

    }

   function testdeposit() public {
       streamcontract.streamDeposit{value: 10000000000000000}("hello");
       uint bal;
       address stream= address(streamcontract);
       assembly{
           bal:= balance(stream)
       }
       assertTrue(bal == 10000000000000000);
   }

   function testwithdraw() public {
      
       vm.deal(0x1b37B1EC6B7faaCbB9AddCCA4043824F36Fb88D8,10 ether);
        streamcontract.streamDeposit{value: 10000000000000000}("hello");
       vm.prank(0x1b37B1EC6B7faaCbB9AddCCA4043824F36Fb88D8);
     streamcontract.streamWithdraw(10000000,"Buidling");
    
   }

   function testwithdraworiginal() public {
       vm.deal(0x1b37B1EC6B7faaCbB9AddCCA4043824F36Fb88D8,10 ether);
        simplecontract.streamDeposit{value: 10000000000000000}("hello");
       vm.prank(0x1b37B1EC6B7faaCbB9AddCCA4043824F36Fb88D8);
     simplecontract.streamWithdraw(10000000,"Buidling");
   }
}
