//
//  SKCircularProgressNode.swift
//  CoreKit-iOS
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import SpriteKit.SKShapeNode



public class SKCircularProgressNode: SKShapeNode {

    private struct Constants {
        static let radius: CGFloat = 32
        static let color = SKColor.darkGray
        static let backgroundColor = SKColor.lightGray
        static let width: CGFloat = 2.0
        static let progress: CGFloat = 0.0
        static let startAngle: CGFloat = .pi
        static let actionKey = "_SKCircularProgressNodeCountdownActionKey"
    }
    
    /// the radius of the progress node
    public var radius: CGFloat = Constants.radius {
        didSet {
            self.updateProgress(node: self.timeNode, progress: self.progress)
        }
    }

    //the active time color
    public var color: SKColor = Constants.color {
        didSet {
            self.timeNode.strokeColor = self.color
        }
    }
    
    //the background color of the timer (to hide: use clear color)
    public var backgroundColor: SKColor = Constants.backgroundColor {
        didSet {
            self.strokeColor = self.backgroundColor
        }
    }
    
    ///the line width of the progress node
    public var width: CGFloat = Constants.width {
        didSet {
            self.timeNode.lineWidth = self.width
            self.lineWidth          = self.width
        }
    }
    
    //the current progress of the progress node end progress is 1.0 and start is 0.0
    public var progress: CGFloat = Constants.progress {
        didSet {
            self.updateProgress(node: self.timeNode, progress: self.progress)
        }
    }
    
    // the start angle of the progress node
    public var startAngle: CGFloat = Constants.startAngle {
        didSet {
            self.updateProgress(node: self.timeNode, progress: self.progress)
        }
    }
    
    private let timeNode = SKShapeNode()
    
    public init(radius: CGFloat, color: SKColor, backgroundColor: SKColor, width: CGFloat, progress: CGFloat) {
        self.radius          = radius
        self.color           = color
        self.backgroundColor = backgroundColor
        self.width           = width
        self.progress        = progress
        
        super.init()
        
        self._init()
    }
    
    override init() {
        super.init()
        
        self._init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self._init()
    }
    

    private func _init() {
        self.timeNode.lineWidth   = self.width
        self.timeNode.strokeColor = self.color
        self.timeNode.zPosition   = 10
        self.timeNode.position    = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        self.addChild(self.timeNode)
        self.updateProgress(node: self.timeNode, progress: self.progress)
        
        self.lineWidth   = self.width
        self.strokeColor = self.backgroundColor
        self.zPosition   = self.timeNode.zPosition
        
        self.updateProgress(node: self)
    }
    
    private func updateProgress(node: SKShapeNode, progress: CGFloat = 0.0) {
        let progress   = 1.0 - progress
        let endAngle   = self.startAngle + progress*CGFloat(2.0 * .pi)
        #if os(iOS) || os(tvOS) || os(watchOS)
        node.path      = UIBezierPath(arcCenter: CGPoint.zero,
                                      radius: self.radius,
                                      startAngle: self.startAngle,
                                      endAngle: endAngle,
                                      clockwise: true).cgPath
        
        #endif
    }
    
    /*!
     The countdown method counts down from a time interval to zero,
     and it calls a callback on the main thread if its finished
     
     :param: time     The time interval to count
     :param: progressHandler   An optional callback method (always called on main thread)
     :param: callback An optional callback method (always called on main thread)
     */
    public func countdown(time: TimeInterval = 1.0, completionHandler: VoidBlock?) {
        self.countdown(time: time, progressHandler: nil, completionHandler: completionHandler)
    }
    
    public func countdown(time: TimeInterval = 1.0, progressHandler: VoidBlock?, completionHandler: VoidBlock?) {
        self.stopCountdown()
        
        self.run(SKAction.customAction(withDuration: time, actionBlock: {(node: SKNode!, elapsedTime: CGFloat) -> Void in
            self.progress = elapsedTime / CGFloat(time)
            
            if let cb = progressHandler {
                DispatchQueue.main.async(execute: {
                    cb()
                })
            }
            
            if self.progress == 1.0 {
                if let cb = completionHandler {
                    DispatchQueue.main.async(execute: {
                        cb()
                    })
                }
            }
        }), withKey: Constants.actionKey)
    }
    
    public func stopCountdown() {
        self.removeAction(forKey: Constants.actionKey)
    }
}
