pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract TaskManager {

   uint nTasks;
   
   struct TaskStruct {
        uint id;
        string title;
        uint32 timestamp;
        bool status;
    }
    TaskStruct[] public tasks;

	constructor() public {
      nTasks =0;
		require(tvm.pubkey() != 0, 101);
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
	}

	modifier checkOwnerAndAccept() {

		require(msg.pubkey() == tvm.pubkey(), 102);
      
		tvm.accept();
		_;
	} 

	function addTask(string title) public checkOwnerAndAccept() {
      nTasks ++;
      tasks.push(TaskStruct(nTasks, title, now, false)) ;
	}

   function deleteTask(uint id) public checkOwnerAndAccept() {
      delete tasks[id];
		
	}
    function getDescByKey(uint id) public checkOwnerAndAccept() view
    returns (string title) {
      title = tasks[id].title;
    }
     function markAsDone(uint id) public checkOwnerAndAccept() {
     
     tasks[id].status = true;
		
	}

   function getTasks() public checkOwnerAndAccept()returns (TaskStruct[]) {
        return tasks;
    }
   
   function getCountOpenTaks() public checkOwnerAndAccept() returns (uint){
      uint openTasks;

      for (uint256 i = 0; i < tasks.length; i++) {
         if (tasks[i].status)
         openTasks += 1;
      }
      return openTasks;
   }

}
