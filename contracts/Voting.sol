//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.4.0 < 0.8.0;

contract Voting {

    struct vote{
        address voterAddress;
        bool choice;
    }

    struct voter{
        string voterName;
        bool voted;
    }

    uint public voterCount=0;
    uint public voteCount=0;
    uint public totalVote=0;
    address electionCommission;
    string electionName;


    enum Status {Create, Start , End}
    Status public status;


    event voterAdded(address voterAddress);
    event votingStart(address voterAddress);
    event electionEnd();
    event result(uint voteCount);


    mapping(address => voter) public registeredVoter;
    mapping(uint => vote) public voted;

    modifier onlyElectionCommission(){
        require(msg.sender == electionCommission);
        _;
    }

    modifier _currentStatus(Status _status){
        require(status ==_status);
        _;
    }

    constructor(string memory _electioName){
        electionCommission = msg.sender;
        electionName =_electioName;
        status = Status.Create;
    }


    function addVoter(address _voterAddress, string memory _voterName) public _currentStatus(Status.Create) onlyElectionCommission{

        voter memory v;
        v.voterName=_voterName;
        v.voted=false;

        registeredVoter[_voterAddress] = v; 
        voterCount++;
        emit voterAdded (_voterAddress);
    }
    
    function startVoting() public _currentStatus(Status.Create) onlyElectionCommission{
        status = Status.Start;
    }

    function voterVote(bool _choice) public _currentStatus(Status.Start) returns (bool) {

        bool finish= false;

        //require(registeredVoter[electionCommission].vote=false);
        if (bytes(registeredVoter[msg.sender].voterName).length !=0 && !registeredVoter[msg.sender].voted)  
        {
            registeredVoter[msg.sender].voted = true;

            vote memory v;
            v.choice=_choice;
            v.voterAddress=msg.sender;

            if(_choice){
                voteCount++;
            }

            voted[totalVote]= v;
            totalVote++;
            finish=true;

        }

        //status= Status.End;

    emit votingStart(msg.sender);
        return finish;

    }
            function endVoting() public _currentStatus(Status.Start) onlyElectionCommission {
                
               status = Status.End;
                //return voteCount;
                 emit result(voteCount);
            }
}