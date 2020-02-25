pragma solidity ^0.4.21;

contract Election {
    
    struct Candidate {
        string name;
        uint vCount;
    }
    
    struct Voter {
        bool authorized;
        bool voted;
        uint votedTo;
    }
    
    modifier only() {
        require(msg.sender == onr);
        _;
    }
    
    address public onr;
    string public electionName;
    
    mapping(address => Voter) public voters;
    Candidate[] public candidates;
    uint public totVotes;
    
    function Election(string _name) public {
        onr = msg.sender;
        electionName = _name;
    }
    
    function addCand(string _name) only public {
        candidates.push(Candidate(_name, 0));
    }

    function getNumCand() public view returns(uint) {
        return candidates.length;
    }
    
    function auth(address _p) only public {
        voters[_p].authorized = true;
    }
    
    function vote(uint _vindex) public {
        require(!voters[msg.sender].voted);
        require(voters[msg.sender].authorized);
        
        voters[msg.sender].voted = true;
        voters[msg.sender].votedTo = _vindex;
        
        candidates[_vindex].vCount += 1;
        totVotes +=1;
    }
    
    function end() only public {
        selfdestruct(onr);
    }
    
}

