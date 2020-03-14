pragma solidity ^0.6.1;

contract Election{

    struct Voter{
        uint  voterID;
        address voted_to;
        bool voted;
    }

    struct Candidate{
         uint candidateID;
         uint vote_count;
    }

   address chair_person;
   mapping(address=>Candidate) candidate_details;
   uint voters_count = 0;
   Voter[5] voters;
   Candidate[2] candidates;

   constructor() public{
    for(uint i=0 ; i<2 ; i++){
         candidates[i].candidateID = i; 
         candidates[i].vote_count = 0;
    } 
    chair_person = msg.sender;
    }

    
    function register() public{
        if(msg.sender!=chair_person || voters_count>5){
            revert();
        }
        voters_count++;
        voters[voters_count].voterID = voters_count;
        voters[voters_count].voted = false;
    }

    
    function vote(uint _voterID,address _voted_to) public {

       if(voters[_voterID].voted || _voterID>=5){
           revert();
       }

        candidate_details[_voted_to].vote_count+=1;
        voters[_voted] = candidate_details[_voted_to].candidateID;
        voters[_voterID].voted = true;
       
    }


    function winner() public returns(uint, uint) {
       
       uint winning_count = -1;
       uint winner;
       for(uint i=0;i<2;i++){
           if(winning_count < candidates[i].vote_count){
               winning_count = candidates[i].vote_count;
               winner = i;
           }
       }
       return( winner, winning_count);

    }
}