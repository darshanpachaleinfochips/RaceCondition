import UIKit

var greeting = "Hello, playground"

protocol Banking{
    func withdrawAmount(amount:Double) throws;
}
enum WithdrawalError:Error{
    case insuficientAccountBalance
}
var accountBalance =  30000.0

struct ATM:Banking{
    func withdrawAmount(amount:Double) throws{
        debugPrint("Inside ATM")
        guard accountBalance > amount else { throw
            WithdrawalError.insuficientAccountBalance
        }
        //ATM calculation
        Thread.sleep(forTimeInterval: Double.random(in: 1...3))
        accountBalance -= amount
    }
    
    func printMessage(){
        debugPrint("ATM withdrawal successful, new account balance = \(accountBalance)")
    }
}
struct Bank:Banking{
    func withdrawAmount(amount:Double) throws{
        debugPrint("Inside Bank")
        guard accountBalance > amount else { throw
            WithdrawalError.insuficientAccountBalance
        }
        //Bank calculation
        Thread.sleep(forTimeInterval: Double.random(in: 1...3))
        accountBalance -= amount
    }
    func printMessage(){
        debugPrint("Bank withdrawal successful, new account balance = \(accountBalance)")
    }
}

let queue = DispatchQueue(label: "semaphoreDemo",qos:.utility,attributes: .concurrent)

let semaphore = DispatchSemaphore.init(value: 1)
//Wait Busy
//Signal
queue.async {
    //Money Withdrawal from ATM
    do{
        semaphore.wait()
        let atm = ATM()
        try atm.withdrawAmount(amount: 10000) //Withdraw 10K
        atm.printMessage()
        semaphore.signal()
    }catch WithdrawalError.insuficientAccountBalance{
        semaphore.signal()
        debugPrint("ATM withdrawal failure: The Account balance is less than the amount you want to withdraw,")
    }catch{
        semaphore.signal()
    }
}
queue.async {
    //Money Withdrawal from Bank
    do{
        semaphore.wait()
        let bank = Bank()
        try bank.withdrawAmount(amount: 25000) //Withdraw 20K
        bank.printMessage()
        semaphore.signal()
    }catch WithdrawalError.insuficientAccountBalance{
        semaphore.signal()
        debugPrint("Bank withdrawal failure: The Account balance is less than the amount you want to withdraw,")
    }catch{
        semaphore.signal()
    }
}

