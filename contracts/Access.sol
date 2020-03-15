pragma solidity ^0.5.0;

contract df_Access{
   address public CEO;
   mapping (address => bool) public admins;
   bool public paused = false;
   uint256 internal conversionrateManufacture = 2;
   uint256 internal conversionrateRetail = 2;

modifier onlyCEO(){
    require(msg.sender==CEO,"Access to DF - CEO only");
    _;
    }

modifier onlyAdmin() {
    require(admins[msg.sender],"Access to DF - Admins only");
      _;
    }

///Modifier to allow actions only when the contract IS NOT paused
modifier whenNotPaused() {
      require(!paused,"Contract is active and available for calls");
      _;
    }

modifier onlyAdminOrCEO() {
      require(admins[msg.sender] || msg.sender == CEO, "Access to only Admins or CEO");
      _;
    }

///Modifier to allow actions only when the contract Is paused
    modifier whenPaused {
      require(paused,"Contract is paused");
      _;
    }

function setCEO(address _newCEO) external onlyCEO {
      require(_newCEO != address(0),"Address is Zero address. Require Valid address");
      CEO = _newCEO;
    }

    function setAdmin(address _newAdmin, bool isAdmin) external onlyCEO {
      require(_newAdmin != address(0),"Address is Zero address. Require Valid address");
      admins[_newAdmin] = isAdmin;
    }

    ///  Creating Pause function; so that any bug hits smart contract can be paused
    /// instead of being self-destructed
    function pause() external onlyAdminOrCEO whenNotPaused {
      paused = true;
    }

    function unpause() external onlyCEO whenPaused {
       paused = false;
    }
}