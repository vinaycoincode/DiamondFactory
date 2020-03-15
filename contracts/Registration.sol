pragma solidity ^0.5.0;

contract df_Registration {

    uint internal _u_id =0;

   //Creating Admin only modufier
   address internal owner;
    constructor () public{
    owner = msg.sender;
    }
    modifier onlyOwner() {
        require(msg.sender == owner,"Only Owner can Call this function");
         _;
    }
    modifier Registered() {
        require(!users[msg.sender]._registered,"You have already Registerd for this User Type");
        _;
    }

    modifier onlyManufacturer() {
        require(!users[msg.sender]._ismanufacturer,"Only Manufacture has access to do this call");
        _;
    }

    modifier onlyRetailer() {
        require(!users[msg.sender]._isretailer,"Only Retailer has access to do this call");
        _;
    }
    ///Registering Users
        struct User {
        uint   _userID;
        string _userName;
        address _address;
        string _userType;
        bool _registered;
        bool _ismanufacturer;
        bool _isretailer;
        //bool _customer;
    }
    mapping(address => User) public users;
     address[] private m_Useraccts;
     address[] private c_Useraccts;
     address[] private r_Useraccts;
     event registered(address _address,string _name, string _usertype);

     function registerManufacture(string memory name)public Registered returns(uint){
            users[msg.sender] = User(_u_id++,name,msg.sender,"Manufacturer",true,true,false);
            uint ret = _u_id;
        m_Useraccts.push(msg.sender)-1;
        emit registered(msg.sender,name,"Manufacturer");
        return ret;
      }
      function registerRetailer(string memory name)public Registered returns(uint){
        users[msg.sender] = User(_u_id++,name,msg.sender,"Retailer",true,false,true);
        uint ret = _u_id;
        r_Useraccts.push(msg.sender)-1;
        emit registered(msg.sender,name,"Retailer");
        return ret;
      }
       function registerCustomer(string memory name)public Registered returns(uint){
        users[msg.sender] = User(_u_id++,name,msg.sender,"Customer",true,false,false);
        uint ret = _u_id;
        c_Useraccts.push(msg.sender)-1;
        emit registered(msg.sender,name,"Customer");
        return ret;
      }
      function getRegisteredManufacture()public view returns(address[]memory){
            return m_Useraccts;
    }
   function getRegisteredCustomer()public onlyOwner view returns(address[]memory){
        return c_Useraccts;
    }
    function getRegisteredRetailer()public view returns(address[] memory){
        return r_Useraccts;
    }
    function getRegisteredUser(address _address)public onlyOwner view returns(uint, string memory, address, string memory){
        return (users[_address]._userID, users[_address]._userName, users[_address]._address,users[_address]._userType);
    }
   function countUsers()public onlyOwner view returns (uint){
        return _u_id;
    }

    function _onlyManufacturer() external view returns(bool success){
        require(!users[msg.sender]._ismanufacturer,"Only Manufacture has access to do this call");
        return true;
    }

    function _onlyRetailer() external view returns(bool success){
        require(!users[msg.sender]._isretailer,"Only Retailer has access to do this call");
        return true;
    }

    function _isRegistered(address _address) external view returns(bool success){
        return users[_address]._registered;
    }

    function _isUserType(address _address) external view returns(string memory){
        return users[_address]._userType;
    }
   }