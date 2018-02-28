pragma solidity ^0.4.20;



contract Owned{
    address public Owner;
    
    modifier OnlyOwner{
    if(msg.sender != Owner) throw;
    _;
}
event LogNewOwner(address Owner, address NewOwner);

function Owned() {
    Owner = msg.sender;
}

function ChangeOwner(address NewOwner)
OnlyOwner
returns(bool success)
{
     if(NewOwner == 0) throw;
     Owner = NewOwner;
     LogNewOwner(Owner,NewOwner);
     return true;
    
}
}