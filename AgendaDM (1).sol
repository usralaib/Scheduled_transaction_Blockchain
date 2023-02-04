pragma solidity >=0.8.0 <0.9.0;

contract TimeEnp {

uint256 public timestamp;
constructor() public {
    timestamp = block.timestamp;
}

struct ScheduledTransaction {
    address receiver;
    uint256 amount;
    bool completed;
    uint256 executionDate;
}

ScheduledTransaction[] public scheduledTransactions;

function scheduleTransaction(address _receiver, uint256 _amount, uint256 _executionDate) public {
    scheduledTransactions.push(ScheduledTransaction(_receiver, _amount, false, _executionDate));
}

function executeScheduledTransactions() public payable {
    for (uint i = 0; i < scheduledTransactions.length; i++) {
    ScheduledTransaction storage transaction = scheduledTransactions[i];
    if (transaction.executionDate <= block.timestamp && !transaction.completed) {
    require(msg.value == transaction.amount * 1e18, "Please insert transaction.amount eth to send");
    address payable receiver = payable(transaction.receiver);
    receiver.transfer(transaction.amount * 1e18);
    transaction.completed = true;
}
    }
}
}