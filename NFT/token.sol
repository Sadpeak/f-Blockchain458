
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;


contract token {

    struct Tool {
       string name;
       string material;
       bool onSale;
       uint price;
    }

    Tool[] tokensArr;
    mapping(uint => uint) tokenToOwner;


    constructor() public {
        require(tvm.pubkey() != 0, 101);
        require(msg.pubkey() == tvm.pubkey(), 102);

        tvm.accept();
    }

    function createToken(string name, string material) public {
       tvm.accept();
      
      for (uint i = 0; i < tokensArr.length; i++) {
                require(name != tokensArr[i].name, 110);
            }
      

      tokensArr.push(Tool(name, material, false, 0));
      uint keyAsLastNum = tokensArr.length - 1;
      tokenToOwner[keyAsLastNum] = msg.pubkey();
    }

   function onSale(uint tokenID, uint price) public {
       require(msg.pubkey() == tokenToOwner[tokenID], 111);
       tvm.accept();
       tokensArr[tokenID].onSale = true;
       tokensArr[tokenID].price = price;
   }
    
}
