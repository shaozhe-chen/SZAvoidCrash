# SZAvoidCrash
一、unrecognized selector sent to instance 造成crash的防护

二、KVO的Crash防护：
    1. 添加监听：可避免因为写错keypath，被监听对象没有该属性，导致的crash
    2. 添加监听：可以避免多次添加监听，相同的observer和keypath只会添加一次监听
    3. 移除监听：避免多次移除监听，导致的crash
    4. 移除监听：避免因为写错keypath，被监听对象没有该属性，导致的crash
    5. 监听自释放，当监听对象dealloc时，不需要手动调用removeObserver:forKeyPath:去释放
    
三、NSTimer处理：
    1. NSTimer在target dealloc之后，自动销毁定时器，无需手动销毁。
    2. NSTimer避免与target循环引用
