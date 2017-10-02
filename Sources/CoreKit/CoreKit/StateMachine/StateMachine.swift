//
//  StateMachine.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 29..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//



public protocol StateMachineDelegateProtocol: class {
    associatedtype StateType : Hashable
    
    func didTransition(from: StateType, to: StateType)
}


public class StateMachine <P: StateMachineDelegateProtocol> {

    private unowned let delegate: P
    private let validTransitions: [P.StateType: [P.StateType]]
    
    private var _state: P.StateType {
        didSet{
            self.delegate.didTransition(from: oldValue, to:_state)
        }
    }
    
    public var state: P.StateType {
        get {
            return self._state
        }
        set {
            self.attemptTransition(to: newValue)
        }
    }
    
    public init(initialState: P.StateType, delegate: P, validTransitions: [P.StateType: [P.StateType]]) {
        self.validTransitions = validTransitions
        self._state           = initialState
        self.delegate         = delegate
    }
    
    private func attemptTransition(to: P.StateType){
        guard
            let validNexts = self.validTransitions[self._state], validNexts.contains(to)
            else
        {
            return
        }
        self._state = to
    }
}

//public class StateMachineViewController : ViewController
//{
//    public var machine: StateMachine<StateMachineViewController>!
//
//    public enum State : Int {
//        case Initial
//        case Loading
//        case Partial
//        case Empty
//        case Error
//        case Ok
//    }
//
//    public override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let stateTransitions = [
//            State.Initial : [State.Loading],
//            State.Loading : [State.Partial, State.Empty, State.Error, State.Ok],
//            State.Partial : [State.Error, State.Ok, State.Partial],
//            State.Empty   : [State.Loading],
//            State.Error   : [State.Loading],
//            State.Ok      : [State.Loading],
//            ]
//
//        self.machine = StateMachine(initialState: .Initial, delegate: self, validTransitions: stateTransitions)
//    }
//
//    public override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//
//        if self.isViewLoaded() && self.view.window == nil {
//
//        }
//
//        self.machine = nil
//    }
//
//    public func setState(state: State) {
//        self.machine.state = state
//    }
//
//}
//
//extension StateMachineViewController : StateMachineDelegateProtocol
//{
//
//    public func didTransition(from from: State, to: State) {
//
//    }
//}
//
//
