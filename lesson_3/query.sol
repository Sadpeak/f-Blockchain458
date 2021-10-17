pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract Query {

	string[] public queryNames;

	constructor() public {
		require(tvm.pubkey() != 0, 101);
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
	}

	modifier checkOwnerAndAccept() {

		require(msg.pubkey() == tvm.pubkey(), 102);
      
		tvm.accept();
		_;
	} 

	function addName(string name) public checkOwnerAndAccept() {
      
		queryNames.push(name);
	}

   function next() public checkOwnerAndAccept() {
      
		delete queryNames[0];
	}

   function getQuery() public checkOwnerAndAccept returns (string[]) {
        return queryNames;
    }
}
