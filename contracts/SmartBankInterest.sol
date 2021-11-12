pragma solidity >=0.7.0 <0.9.0;


interface cETH {
       
    function mint() external payable; 
    function redeem(uint redeemTokens) external returns (uint);
    
    function exchangeRateStored() external view returns (uint); 
    function balanceOf(address owner) external view returns (uint256 balance);
}


contract SmartBankInterest {


    uint totalContractBalance = 0;
    
    address COMPOUND_CETH_ADDRESS = 0x859e9d8a4edadfEDb5A2fF311243af80F85A91b8;
    cETH ceth = cETH(COMPOUND_CETH_ADDRESS);

    function getContractBalance() public view returns(uint){
        return totalContractBalance;
    }
    
    mapping(address => uint) balances;
    mapping(address => uint) depositTimestamps;
    
    function addBalance() public payable {
        balances[msg.sender] = msg.value;
        totalContractBalance = totalContractBalance + msg.value;
        depositTimestamps[msg.sender] = block.timestamp;
        
        ceth.mint{value: msg.value}();        
    }
    
    function getBalance(address userAddress) public view returns(uint256) {
        return ceth.balanceOf(userAddress) * ceth.exchangeRateStored() / 1e18;
    }
    
    function withdraw() public payable { 
        
        address payable withdrawTo = payable(msg.sender);
        uint amountToTransfer = getBalance(withdrawTo);
        
        totalContractBalance = totalContractBalance - amountToTransfer;
        balances[msg.sender] = 0;
        ceth.redeem(amountToTransfer);
    }
    
    function addMoneyToContract() public payable {
        totalContractBalance += msg.value;
    }
    
}
