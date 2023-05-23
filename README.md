# RaceCondition

Dispatch SemaPhore(Signals)
    SemaPhore is considered to be single to avoid any accident or unwanted situations like traffic signals on road or railway track signals. If a train locomotive pilot does not get proper signal then trains can collapse at platforms.
    //Consider trains as Thread A and Thread B 
    //Platform as Resource (variable, class or file)
    //Accident as Race Conditions.
    //Train Signal as Dispatch Semaphore
Here both threads need to perform some operation on that resource like read, write or update.
If both threads access the same resource at the same time then an accident happens.

In Programming this accident is called Race Conditions.

Race Condition
    Race condition is a situation where there are multiple tasks that are executed at the same time.
    Example : We have a banking system and ATM and Bank are two options to withdraw money from a bank and account balance is a shared resource. When using a concurrent queue we are trying to execute these operations with minimum account check still we  will get unexpected output.
    
