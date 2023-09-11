// SPDX-License-Identifier: GPL-3.0
        
pragma solidity >=0.4.22 <0.9.0;

// This import is automatically injected by Remix
import "remix_tests.sol"; 

// This import is required to use custom transaction context
// Although it may fail compilation in 'Solidity Compiler' plugin
// But it will work fine in 'Solidity Unit Testing' plugin
import "remix_accounts.sol";
// <import file to test>
import "contracts/Soulbound.sol";

// File name has to end with '_test.sol', this file can contain more than one testSuite contracts
contract SoulboundTokenTest {

    Soulbound soulbound;
    address owner;

    /// 'beforeAll' runs before all other tests
    function beforeAll() public {
        owner = TestsAccounts.getAccount(0); // 첫 번째 계정을 owner로 설정합니다.
        soulbound = new Soulbound(); // Soulbound 컨트랙트를 배포합니다.
    }

    function shouldMintASoulboundToken() public {
        soulbound.safeMint(owner, "https://test.com/0");
        Assert.equal(soulbound.ownerOf(0), owner, "Owner should own the token ID 0");
    }

    // safeTransferFrom을 시도할 때 거절됨
    function shouldRevertWhenTryingToTransferViaSafeTransferFrom() public {
        soulbound.safeMint(owner, "https://test.com/0");
        try soulbound.safeTransferFrom(owner, TestsAccounts.getAccount(1), 0) {
            Assert.ok(false, "Expected to revert");
        } catch (bytes memory) {
            Assert.ok(true, "Expected to revert");
        }
    }

    // transferFrom을 시도할 때 거절됨
    function shouldRevertWhenTryingToTransferViaTransferFrom() public {
        soulbound.safeMint(owner, "https://test.com/0");
        try soulbound.transferFrom(owner, TestsAccounts.getAccount(1), 0) {
            Assert.ok(false, "Expected to revert");
        } catch (bytes memory) {
            Assert.ok(true, "Expected to revert");
        }
    }
}
    