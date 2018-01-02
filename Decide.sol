// thx: https://medium.com/@mvmurthy/full-stack-hello-world-voting-ethereum-dapp-tutorial-part-1-40d2d0d807c2

pragma solidity ^0.4.18;
// We have to specify what version of compiler this code will compile with

contract DecisionMaker {
  /* mapping field below is equivalent to an associative array or hash.
  The key of the mapping is choice name stored as type bytes32 and value is
  an unsigned integer to store the vote count
  */

  mapping (bytes32 => uint8) public votesReceived;

  /* Solidity doesn't let you pass in an array of strings in the constructor (yet).
  We will use an array of bytes32 instead to store the list of choices
  */

  bytes32[] public choiceList;

  /* This is the constructor which will be called once when you
  deploy the contract to the blockchain. When we deploy the contract,
  we will pass an array of choices who will be contesting in the election
  */
  function DecisionMaker(bytes32[] choiceItem) public {
    choiceList = choiceItem;
  }

  // This function returns the total votes a choice has received so far
  function totalVotesFor(bytes32 choice) view public returns (uint8) {
    require(validChoice(choice));
    return votesReceived[choice];
  }

  // This function increments the vote count for the specified choice. This
  // is equivalent to casting a vote
  function voteForChoice(bytes32 choice) public {
    require(validChoice(choice));
    votesReceived[choice] += 1;
  }

  function validChoice(bytes32 choice) view public returns (bool) {
    for(uint i = 0; i < choiceList.length; i++) {
      if (choiceList[i] == choice) {
        return true;
      }
    }
    return false;
  }
}