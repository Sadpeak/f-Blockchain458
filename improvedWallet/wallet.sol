
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;


contract wallet {

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

    function sendValueWithCommisison(address dest, uint128 amount, bool bounce) public view checkOwnerAndAccept() {
        dest.transfer(amount, bounce, 1);
    }

   function sendValueWithoutCommision(address dest, uint128 amount, bool bounce) public view checkOwnerAndAccept() {
        dest.transfer(amount, bounce, 0);
    }

   function sendAllValue(address dest, uint128 amount, bool bounce) public view checkOwnerAndAccept() {       
        dest.transfer(amount, bounce, 160);
    }
}
