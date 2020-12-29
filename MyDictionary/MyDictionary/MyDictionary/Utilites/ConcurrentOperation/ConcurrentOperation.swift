//
//  ConcurrentOperation.swift
//  MyDictionary
//
//  Created by Дмитрий Чумаков on 29.12.2020.
//

import Foundation

open class ConcurrentOperation: Operation {
    
    typealias OperationCompletionHandler = (_ result: OperationResult) -> Void
    var completionHandler: (OperationCompletionHandler)?        
    
    fileprivate var state = OperationState.ready {
        willSet {
            willChangeValue(forKey: newValue.rawValue)
            willChangeValue(forKey: state.rawValue)
        }
        didSet {
            didChangeValue(forKey: oldValue.rawValue)
            didChangeValue(forKey: state.rawValue)
        }
    }
    
    open override var isReady: Bool {
        return super.isReady && state == .ready
    }
    
    open override var isExecuting: Bool {
        return state == .executing
    }
    
    open override var isFinished: Bool {
        return state == .finished
    }
    
    open override func start() {
        guard !isCancelled else {
            finish()
            return
        }
        
        if (!isExecuting) {
            state = .executing
        }
        
        main()
    }
    
    open override func cancel() {
        super.cancel()
        
        finish()
    }
    
    func finish() {
        if isExecuting {
            state = .finished
        }
    }
    
    func complete(result: OperationResult) {
        finish()
        
        if !isCancelled {
            completionHandler?(result)
        }
    }
    
}
