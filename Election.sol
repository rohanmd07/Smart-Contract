/* There is an Election in which there are 2 candidates and 5 voters(candidates included).
   Every voter cast their vote to a particular candidate by passing a particular integer value
   but before voting, a Chair Person registers that voter only then he/she is allowed to vote.
   For every transaction, there is some amount of ether charged as price*/
   
  /*This program is written in solidity.
  Please use "solidity.readthedocs.io/en/v0.6.1" for reference*/
   
pragma solidity ^0.6.1;        // declares the version of solidity language
         
contract Election{        

    struct Voter{             // voters' credentials
        uint  voterID;
        address voted_to;
        bool voted;
    }
 
    struct Candidate{         // Candidates' credentials
         uint candidateID;
         uint vote_count;
    }

   address chair_person;                             // head of the election commission
   mapping(address=>Voter) voter_details;
   uint voters_count = 0;
   Voter[5] voters;
   Candidate[2] candidates;
                       
   constructor() public{
    for(uint i=0 ; i<2 ; i++){
         candidates[i].vote_count = 0;
    } 
    chair_person = msg.sender;                      // msg.sender is the address of the one who is calling the function
    }                                               // here that is the chair person

    
    function register(address _voter_addr) public{                             
        if(msg.sender!=chair_person || voters_count>5){    // only chairperson is allowed to register voters
            revert();
        }
        voters_count++;        
        voter_details[_voter_addr] = voters[voters_count];
        voters[voters_count].voterID = voters_count;
        voters[voters_count].voted = false;
    }

    
   function vote(uint _voted_to) public {                        // voting by the voters
       
       Voter storage voter = voter_details[msg.sender];
       if(_voted_to>2 || voter.voterID>5 || voter.voted){
           revert();
       }

        candidates[_voted_to].vote_count+=1;
        voters[voter.voterID].voted_to = _voted_to; 
        voters[voter.voterID].voted = true;
       
    }


    function reveal_winner() public view returns(uint, uint) {      // finding the winner of the elction
       uint winning_count = 0;
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
