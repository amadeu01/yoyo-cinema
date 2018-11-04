//
//  CircularScoreMovie.swift
//  Yoyo Cinema
//
//  Created by Amadeu Cavalcante Filho on 02/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import UIKit

extension UIColor {
    public static let lightDark = UIColor(red: 10/255, green: 21/255, blue: 25/255, alpha: 0.9)
}

final class CircularScoreView: UIView {
    var scoreColor: UIColor = .red {
        didSet {
            trackingPathColor = UIColor(cgColor: scoreColor.cgColor)
                .withAlphaComponent(0.3)
        }
    }
    var trackingPathColor: UIColor = .lightGray
    var animationDuration: Double = 2
    var finalScore: Float = 0
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        self.subviews.forEach { $0.removeFromSuperview() }
        addCircularLayers()
        addScoreText()
    }
    
    func addCircularLayers() {
        let radius = (frame.width/2) * 0.7
    
        let cicularExternal = UIBezierPath(
            arcCenter: self.center,
            radius: radius*1.2,
            startAngle: -CGFloat.pi/2,
            endAngle: 2 * CGFloat.pi - CGFloat.pi/2,
            clockwise: true)
        
        let cicularPath = UIBezierPath(
            arcCenter: self.center,
            radius: radius,
            startAngle: -CGFloat.pi/2,
            endAngle: 2 * CGFloat.pi - CGFloat.pi/2,
            clockwise: true)
        
        let externalCircular = CAShapeLayer()
        externalCircular.lineCap = CAShapeLayerLineCap.round
        externalCircular.fillColor = UIColor.lightDark.cgColor
        externalCircular.lineWidth = 0
        externalCircular.path = cicularExternal.cgPath
        
        let trackingPath = CAShapeLayer()
        trackingPath.lineCap = CAShapeLayerLineCap.round
        trackingPath.fillColor = UIColor.clear.cgColor
        trackingPath.lineWidth = 5
        trackingPath.path = cicularPath.cgPath
        trackingPath.strokeColor = trackingPathColor.cgColor
        
        let scorePath = CAShapeLayer()
        scorePath.lineCap = CAShapeLayerLineCap.round
        scorePath.lineWidth = 5
        scorePath.fillColor = UIColor.clear.cgColor
        scorePath.path = cicularPath.cgPath
        scorePath.strokeEnd = 0
        scorePath.strokeColor = scoreColor.cgColor
        
        self.layer.addSublayer(externalCircular)
        self.layer.addSublayer(trackingPath)
        self.layer.addSublayer(scorePath)
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        basicAnimation.duration = animationDuration
        basicAnimation.toValue = finalScore
        
        scorePath.add(basicAnimation, forKey: "strokeEnd")
    }
    
    func addScoreText() {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = .white
        textLabel.sizeToFit()
        textLabel.textAlignment = .center
        textLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        textLabel.text = "\(Int(100*finalScore))%"
        
        self.addSubview(textLabel)
        
        textLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.top.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(10)
        }
    }
}
