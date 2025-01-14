// SPDX-License-Identifier: UNLICENSED
pragma solidity =0.8.13;

import "forge-std/Test.sol";

contract AccountParamsTest is Test {

    function testDealConcrete() public {
        vm.deal(address(505), 256);
        assertEq(address(505).balance, 256);
    }

    function testDealSymbolic(uint256 value) public {
        vm.deal(address(328), value);
        assertEq(address(328).balance, value);
    }

    function testEtchConcrete() public {
        bytes memory code = bytes("this should be EVM bytecode");
        vm.etch(address(124), code);
        assertEq(address(124).code, code);
    }

    function testEtchSymbolic(bytes calldata code) public {
        vm.etch(address(124), code);
        assertEq(address(124).code, code);
    }

    function testNonceSymbolic(uint64 newNonce) public {
       uint64 oldNonce = vm.getNonce(address(this));
       vm.assume(newNonce > oldNonce);
       vm.setNonce(address(this), newNonce);
       assert(vm.getNonce(address(this)) == newNonce);
    }

    function test_GetNonce_true() public {
       uint64 nonce = vm.getNonce(address(this));
       assert(nonce == 0);
    }

    function test_GetNonce_false() public {
       uint64 nonce = vm.getNonce(address(100));
       assertEq(nonce, 10);
    }

    function testFail_GetNonce_true() public {
       uint64 nonce = vm.getNonce(address(0));
       assertEq(nonce, 10);
    }

    function testFail_GetNonce_false() public {
       uint64 nonce = vm.getNonce(address(this));
       assertGt(nonce, 0);
    }

    function test_Nonce_ExistentAddress() public {
       vm.setNonce(address(this), 100);
       uint64 nonce = vm.getNonce(address(this));
       assert(nonce == 100);
    }

    function test_Nonce_NonExistentAddress() public {
       vm.setNonce(address(100), 100);
       uint64 nonce = vm.getNonce(address(100));
       assert(nonce == 100);
    }
}