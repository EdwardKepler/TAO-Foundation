{\rtf1\ansi\ansicpg1252\cocoartf1504\cocoasubrtf830
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\margl1440\margr1440\vieww10800\viewh8400\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\fs24 \cf0 pragma solidity ^0.4.20;\
import "./Listing.sol";\
import "./Owned.sol";\
\
    contract Offering is Owned\{\
    // Smart Contract For Tokenized Asset Offerings -TAO Foundation [Edward Kepler]\
    // Smart Contract For Tokenized Asset Offering [TMO]\
    // Offering Address   0xca35b7d915458ef540ade6068dfe2f44e8fa733c\
    address public offering;\
    uint    public duration;\
    uint    public goal;\
    \
    uint    public fundsRaised;\
    bool    public refundSent;\
    bool    public tokenHolder;\
    string  public token1;\
    uint public stake;\
    \
	//"TokenizedAssetOffering": \{\
	//	"OfferingType": "TAO\'94,\
	//	"OfferingAddress": "0xca35b7d915458ef540ade6068dfe2f44e8fa733c",\
	//	"AssetType": "Jewelry",\
	//	"LandName": "Ring",\
	//	"Dimension": "20in\'92",\
	//	"Bought": "4/23/2018",\
	//	"PhotosOfAsset": "www.nm.org",\
	//	"AssetOwners": \{\
	//		"AssetOwner": "Edward Kepler"\
	//	\},\
	//	"Appraisal": "2,000,000",\
	//	"AppraisorName": "James Lilly",\
	//	"AppraisorDate": "01/23/2018",\
	//	"CertificateOfOwnership": " www.iiio.com",\
	//	"CertificateOfAuthenticity": "www.iiio.com",\
	//	"Tokenization": "TAO",\
	//	"EstimateOfAssetValuation": "2,000,000",\
	//	"PercentageForTokenization": "5%",\
	//	"FundraisingTarget": "$1,000,000",\
	//	"SettlementDate": "5/23/2018",\
	//	"Rollover": "Yes",\
	//	"ExitOption": "NA",\
	//	"FundingPlan": "NA",\
	//\}\
//\}"\
    \
    \
    struct FunderStruct \{\
    address funder;\
    uint    amount;\
    \}\
    FunderStruct[] funderStructs;\
      modifier onlyOwner \{\
      require(msg.sender == offering);\
      _;\
       \}\
           // [TAO] Tokenized Asset Offering \
           // [TRO] Tokenized Land Offering\
           // Tokenized - [TAO,TBO,TCO,TDO,TEO,TGO,TKO,TLO,TMO,TPO,TRO,TSO,TTO]\
           \
          \
    function fundingSuccessful() public constant returns(bool isSuccess)\{\
    return(fundsRaised >= goal);\
    \}\
    function fundingFailed() public constant returns(bool isFailed)\{\
    return(fundsRaised < goal && block.number > duration);\
    \}\
          \
    event LogContribution(address sender, uint amount);\
    event LogWithdrawl(address funder , uint amount);\
    event LogRefund(address sender , uint amount);\
    event LogFoundation(address foundation , uint fundingFee);\
    \
    function Offering(uint _fundingDuration,uint _fundingGoal, string _token, uint _stake) public payable\{\
    //Create Offering\
    offering = 0xca35b7d915458ef540ade6068dfe2f44e8fa733c;\
    owner = Owned.owner;\
    token1 = _token;\
    duration = block.number + _fundingDuration;\
    goal = _fundingGoal;\
    stake = _stake;\
    \}\
    \
    function contribute() public payable returns(bool success)\{\
     //Contribute To Offering\
     if(msg.value==0) throw;\
     if(fundingSuccessful()) throw;\
     if(fundingFailed()) throw;\
     fundsRaised +=msg.value;\
     FunderStruct memory newFunder;\
     newFunder.funder = msg.sender;\
     newFunder.amount = msg.value;\
     funderStructs.push(newFunder);\
     LogContribution(msg.sender, msg.value);\
     return true;\
    \
     \}\
\
   function withdrawlFees() public payable returns(bool success)\
   \{\
   //withdrawFees - Owner Only \
   uint foundationFee;\
   uint fundingAmount;\
   uint finalAmount;\
   if(msg.sender != owner) throw;\
   if(!fundingSuccessful()) throw;\
   if(tokenHolder == true)\
   \{\
   fundingAmount = this.balance;    \
   foundationFee = (fundingAmount * 5)/100;\
   finalAmount = (fundingAmount - foundationFee);\
   owner.transfer(foundationFee);\
   LogFoundation(owner,foundationFee);\
   return true;\
   \}\
   fundingAmount = this.balance;    \
   foundationFee = (fundingAmount * 10)/100;\
   finalAmount = (fundingAmount - foundationFee);\
   owner.transfer(foundationFee);\
   LogFoundation(owner,foundationFee);\
   return true;\
   \}\
\
 \
   function withdrawFunds() public payable returns(bool success)\{\
   // WithdrawFunds - Offering Originator Only\
   uint fundingAmount;\
   if(msg.sender != offering) throw;\
   if(!fundingSuccessful()) throw;\
   fundingAmount = this.balance;\
   offering.transfer(fundingAmount);\
   LogFoundation(offering,fundingAmount);\
   return true;\
   \}\
   \
\
   \
   \
    \
   \
   \
 \
\
   \
\}}