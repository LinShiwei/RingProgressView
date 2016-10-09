//
//  RingProgressView.swift
//  RingProgressView
//
//  Created by Linsw on 16/10/8.
//  Copyright © 2016年 Linsw. All rights reserved.
//

import UIKit

public enum RingProgressViewDirection{
    case Clockwise,Counterclockwise
}

public class RingProgressView: UIView {
    
    private var dotCount : Int = 60{
        didSet{
            maskLayer.instanceCount = dotCount
            maskLayer.instanceTransform = CATransform3DMakeRotation(CGFloat.pi*2/CGFloat(dotCount), 0, 0, 1)
        }
    }
    private var dotRadius : CGFloat = 1{
        didSet{
            dot.frame = CGRect(x: -dotRadius, y: 0, width: 2*dotRadius, height: 2*dotRadius)
            dot.cornerRadius = dotRadius
            strokeLayer.lineWidth = dotRadius*3
            adjustStrokeLayerTransform(clockwise: direction)
        }
    }
    private var ringGap : CGFloat = 4{
        didSet{
            ringLayer.frame = CGRect(x: ringGap, y: ringGap, width: frame.width-ringGap*2, height: frame.height-ringGap*2)

        }
    }
    private var dotColor : UIColor = UIColor.white{
        didSet{
            strokeLayer.strokeColor = dotColor.cgColor
        }
    }
    private var dotBackgroundColor : UIColor = UIColor.darkGray{
        didSet{
            strokeLayer.backgroundColor = dotBackgroundColor.cgColor
        }
    }
    private var hasRing : Bool = true{
        didSet{
            guard ringLayer.superlayer != nil && hasRing == false else{return}
            ringLayer.removeFromSuperlayer()
        }
    }
    private var ringLineWidth : CGFloat = 1{
        didSet{
            ringLayer.borderWidth = ringLineWidth
        }
    }
    private var ringLineColor : UIColor = UIColor(white: 1, alpha: 0.2){
        didSet{
            ringLayer.borderColor = ringLineColor.cgColor

        }
    }
    private var animationDuration : CFTimeInterval = 1
    private var direction :RingProgressViewDirection = .Counterclockwise{
        didSet{
            let path = CGMutablePath()
            switch direction {
            case .Counterclockwise:
                path.addArc(center: CGPoint(x:frame.width/2,y:frame.height/2), radius: frame.width/2, startAngle: -CGFloat.pi/2, endAngle: CGFloat.pi/2*3, clockwise: false)
            case .Clockwise:
                path.addArc(center: CGPoint(x:frame.width/2,y:frame.height/2), radius: frame.width/2, startAngle: CGFloat.pi/2*3, endAngle: -CGFloat.pi/2, clockwise: true)
            }
            strokeLayer.path = path
            adjustStrokeLayerTransform(clockwise: direction)
        }
    }
    
    private let maskLayer = CAReplicatorLayer()
    private let strokeLayer = CAShapeLayer()
    private let ringLayer = CALayer()
    private let dot = CALayer()
    private let strokeEnd = CABasicAnimation(keyPath: "strokeEnd")

    public var progress : Double = 0{
        didSet{
            progress = progress > 1 ? 1 : progress
            progress = progress < 0 ? 0 : progress
            strokeLayer.strokeEnd = CGFloat(progress)
            strokeEnd.fromValue = 1
            strokeEnd.duration = (1-progress)*animationDuration
            strokeLayer.add(strokeEnd, forKey: "strokeEnd")
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure(frame:frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setting(dotCount count:Int=60, dotRadius radius: CGFloat=1, dotColor color:UIColor=UIColor.white,dotBackgroundColor:UIColor=UIColor.darkGray, hasRing:Bool=true,  GapBetweenRingAndDot gap:CGFloat=4, ringLineWidth lineWidth:CGFloat=1,ringLineColor lineColor:UIColor=UIColor(white: 1, alpha: 0.2),  animationDuration duration:CFTimeInterval=1, direction:RingProgressViewDirection = .Counterclockwise){
        
        dotCount = count
        dotRadius = radius
        dotColor = color
        self.dotBackgroundColor = dotBackgroundColor
        self.hasRing = hasRing
        ringGap = gap
        ringLineWidth = lineWidth
        ringLineColor = lineColor
        animationDuration = duration
        self.direction = direction
    }
    
    private func configure(frame:CGRect) {
        dot.frame = CGRect(x: -dotRadius, y: 0, width: 2*dotRadius, height: 2*dotRadius)
        dot.cornerRadius = dotRadius
        dot.backgroundColor = UIColor.white.cgColor
        
        maskLayer.frame = CGRect(x: (frame.width-frame.width/1.41)/2, y: (frame.width-frame.width/1.41)/2, width: frame.width/1.41, height: frame.width/1.41)
        maskLayer.instanceCount = dotCount
        maskLayer.instanceTransform = CATransform3DMakeRotation(CGFloat.pi*2/CGFloat(dotCount), 0, 0, 1)
//        maskLayer.transform = CATransform3DMakeRotation(CGFloat.pi/4+dotRadius/(frame.height/2), 0, 0, 1)
        maskLayer.addSublayer(dot)
        
        let path = CGMutablePath()
        path.addArc(center: CGPoint(x:frame.width/2,y:frame.height/2), radius: frame.width/2, startAngle: -CGFloat.pi/2, endAngle: CGFloat.pi/2*3, clockwise: false)
        strokeLayer.frame = bounds
        strokeLayer.path = path
        strokeLayer.fillColor = nil
        strokeLayer.strokeColor = dotColor.cgColor
        strokeLayer.lineWidth = dotRadius*3
        strokeLayer.mask = maskLayer
        strokeLayer.backgroundColor = dotBackgroundColor.cgColor
        adjustStrokeLayerTransform(clockwise: direction)
        layer.addSublayer(strokeLayer)
        
        ringLayer.frame = CGRect(x: ringGap, y: ringGap, width: frame.width-ringGap*2, height: frame.height-ringGap*2)
        ringLayer.borderColor = ringLineColor.cgColor
        ringLayer.borderWidth = ringLineWidth
        ringLayer.cornerRadius = ringLayer.frame.width/2
        layer.addSublayer(ringLayer)
        
    }
    
    private func adjustStrokeLayerTransform(clockwise:RingProgressViewDirection){
        let angle = dotRadius/(frame.height/2)
        switch clockwise {
        case .Clockwise:
            strokeLayer.transform = CATransform3DMakeRotation(angle, 0, 0, 1)
            maskLayer.transform = CATransform3DMakeRotation(CGFloat.pi/4-angle*2, 0, 0, 1)
        case .Counterclockwise:
            strokeLayer.transform = CATransform3DMakeRotation(-angle, 0, 0, 1)
            maskLayer.transform = CATransform3DMakeRotation(CGFloat.pi/4+angle*2, 0, 0, 1)
        }
    }
}
