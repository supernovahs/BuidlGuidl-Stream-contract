// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "./Contract.sol";
import "forge-std/Vm.sol";
import "../src/streamcontract.sol";


///     Foundry tests for the BuidlGuidl Stream Contract
///      supernovahs.eth
///     Tests are run on forked mainnet
 

contract ContractTest is Test {

    
    
    BGstream public streamcontract;

    
///    Set  up function for tests
        
     
    function setUp() public {
        vm.prank(0x1b37B1EC6B7faaCbB9AddCCA4043824F36Fb88D8);// Setting msg.sender as supernovahs.eth
        streamcontract = new BGstream(payable(0x1b37B1EC6B7faaCbB9AddCCA4043824F36Fb88D8), 0.5 ether, 1296000, false);// Instantiating new stream , 0.5 ether every 2 weeks
        uint _laststreamwithdraw = streamcontract.last();
        uint _cap = streamcontract.cap();
        uint _frequency = streamcontract.frequency();
        address _toAddress = streamcontract.toAddress();
        assertEq(_laststreamwithdraw,1658313252);
        assertEq(_cap,0.5 ether);
        assertEq(_frequency,1296000);
        assertEq(_toAddress,0x1b37B1EC6B7faaCbB9AddCCA4043824F36Fb88D8);
    }

// Should be able to deposit correctly
    function teststreamdeposit() public {
        streamcontract.streamDeposit{value: 0.5 ether}("Hello");

        assertEq(address(streamcontract).balance,0.5 ether);
    }

    // Should deposit using receive function directly 

    function testdepositdirectly() public payable {
        address(streamcontract).call{value: 0.5 ether}("");
    }

    // If timestamp -lastwithdraw> frequency,
    function teststreambalance() public {
        uint _laststreamwithdraw = streamcontract.last();
        uint _timestamp = 1660991652;
        if(_timestamp-_laststreamwithdraw > streamcontract.frequency()){
            assertEq(streamcontract.streamBalance(),0.5 ether);
        }
        else{
            assertEq(streamcontract.streamBalance(),(0.5 ether * (_timestamp-_laststreamwithdraw)) / streamcontract.frequency());
        }
    }
// Should be able to withdraw correctly
    function teststreamwithdraw() public {
        streamcontract.streamDeposit{value: 0.5 ether}("Hello");
        uint bal = streamcontract.streamBalance();
        uint etherbefore = address(streamcontract).balance;
        vm.prank(0x1b37B1EC6B7faaCbB9AddCCA4043824F36Fb88D8);
        streamcontract.streamWithdraw(bal,"test");
        assertEq(address(streamcontract).balance,etherbefore - bal);// Checking correct balance after withdraw
    }

    // Should not be able to withdraw
    function testFailstreamwithdraw() public {
        streamcontract.streamDeposit{value: 0.5 ether}("BuidlGuidl");
        uint bal = streamcontract.streamBalance();
        uint etherbefore = address(streamcontract).balance;
        vm.prank(0x1b37B1EC6B7faaCbB9AddCCA4043824F36Fb88D8);
        streamcontract.streamWithdraw(bal+1,"test");// Trying to Withdraw 1 extra wei
        
    }



//  
}
