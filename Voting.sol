// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

contract Voting {
    struct Candidate {
        address candidateAddress;
        uint256 voteCount;
    }

    // Define an Appropriate Data Type to Track If Voter has Already Voted
    mapping(address => bool) public hasVoted;

    // Array to store candidates
    Candidate[] public candidates;

    // Adds New Candidate by taking candidate address
    function addCandidate(address _candidateAddress) public {
        require(_candidateAddress != address(0), "Invalid candidate address");
        candidates.push(
            Candidate({candidateAddress: _candidateAddress, voteCount: 0})
        );
    }

    // Removes Already Added Candidate taking candidate address
    function removeCandidate(address _candidateAddress) public {
        for (uint256 i = 0; i < candidates.length; i++) {
            if (candidates[i].candidateAddress == _candidateAddress) {
                if (i != candidates.length - 1) {
                    candidates[i] = candidates[candidates.length - 1];
                }
                candidates.pop();
                return;
            }
        }
    }

    // Retrieves All Candidates for Viewing
    function getAllCandidates() public view returns (Candidate[] memory) {
        return candidates;
    }

    // Allows Voter to Cast a Vote for a Single Candidate taking voter address and candidate address
    function castVote(address _voterAddress, address _candidateAddress) public {
        require(!hasVoted[_voterAddress], "You have already voted");

        for (uint256 i = 0; i < candidates.length; i++) {
            if (candidates[i].candidateAddress == _candidateAddress) {
                candidates[i].voteCount++;
                hasVoted[_voterAddress] = true;
                return;
            }
        }

        revert("Invalid candidate address");
    }
}
