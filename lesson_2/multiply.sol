pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract multi {

	uint public sum = 1;

	constructor() public {
		require(tvm.pubkey() != 0, 101);
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
	}

	modifier checkOwnerAndAccept(uint value) {

		require(msg.pubkey() == tvm.pubkey(), 102);
      		require(value >= 1 && value <= 10, 103);
      
		tvm.accept();
		_;
	}

	function multiply(uint value) public checkOwnerAndAccept(value) {
      
		sum *= value;
	}
}
