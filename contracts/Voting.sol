//SPDX-License-Identifier:GPL-3.0

pragma solidity >=0.4.0 <0.8.1;

contract Voting {

    struct vote{
        address voterAddress;
        bool choice;
    }

    struct voter{
        string voterName;
        bool voted;
    }

    enum State { Created, Start, End }
    State public state;

    event voterAdded(address voterAddress, string voterName);
    event votingStart();
    event votingEnd(uint finalResult);
    event voteDone(address voter);

    uint totalVote;
    uint countVote;
    uint finalResult;
    uint totalVoter;
    address chairPerson;
    string electionName;

    mapping(address => voter) public voterRegister;
    mapping(uint => vote) public votes;


    constructor(address _chairPersonAddress, string memory _electionName ){
        chairPerson =_chairPersonAddress;
        electionName = _electionName;
        state = State.Created;

    }

    modifier onlyChairPerson () {
        require (msg.sender ==chairPerson);
        _;
    }

    modifier status(State _state){
        require(state ==_state);
        _;
    }

    function addVoter(address _voterAddress,string memory _voterName) public status(State.Created) onlyChairPerson {
        voter memory v;
        v.voterName = _voterName;
        v.voted= false;

        voterRegister[_voterAddress]=v;
        totalVoter++;


    emit voterAdded( _voterAddress,  _voterName);

    }   


    function startVoting() public status (State.Created) onlyChairPerson{
       state = State.Start;
       emit votingStart();
    }


    function doVoting(bool _choice) public returns (bool){
        bool done=false;
        vote memory v;
        if (!voterRegister[msg.sender].voted && 
            bytes(voterRegister[msg.sender].voterName).length!=0)
    {
         voterRegister[msg.sender].voted = true;
         v.choice=_choice;
         v.voterAddress=msg.sender;
            totalVote++;

            if(_choice){
                countVote++;
            }

            votes[totalVote]=v;
            totalVote++;
            done=true;
    }   
        emit voteDone(msg.sender);
        return done;
    }

    function votingFinish() public status(State.Start) onlyChairPerson{
        state = State.End;
    }


    function result() public status(State.End) onlyChairPerson {
        finalResult = countVote;

        emit votingEnd(finalResult);
    }
}