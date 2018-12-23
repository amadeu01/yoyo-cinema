import UIKit
import PlaygroundSupport
@testable import YoyoFramework
import SnapKit

let view = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))

extension UIColor {
    public static let lightDark = UIColor(red: 10/255, green: 21/255, blue: 25/255, alpha: 0.9)
}

final class CircularScoreView: UIView {
    var scoreColor: UIColor = .red {
        didSet {
            trackingPathColor = UIColor(cgColor: scoreColor.cgColor)
                .withAlphaComponent(0.3)
            trackingPath.strokeColor = trackingPathColor.cgColor
            scorePath.strokeColor = scoreColor.cgColor
        }
    }
    var trackingPathColor: UIColor = .lightGray
    var animationDuration: Double = 2
    var finalScore: Float = 0 {
        didSet {
            textLabel.text = "\(Int(100*finalScore))%"
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    let scorePath = CAShapeLayer()
    let trackingPath = CAShapeLayer()
    let externalCircular = CAShapeLayer()
    let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
    let textLabel = UILabel()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        layout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func initialize() {
        self.layer.addSublayer(externalCircular)
        self.layer.addSublayer(trackingPath)
        self.layer.addSublayer(scorePath)
        self.addSubview(textLabel)
        
        scorePath.lineWidth = 5
        scorePath.strokeEnd = 0
        scorePath.strokeColor = scoreColor.cgColor
        scorePath.fillColor = UIColor.clear.cgColor
        
        externalCircular.lineCap = CAShapeLayerLineCap.round
        externalCircular.fillColor = UIColor.lightDark.cgColor
        externalCircular.lineWidth = 0
        
        trackingPath.lineCap = CAShapeLayerLineCap.round
        trackingPath.fillColor = UIColor.clear.cgColor
        trackingPath.strokeColor = trackingPathColor.cgColor
        
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        basicAnimation.duration = animationDuration
        
        textLabel.textColor = .white
        textLabel.textAlignment = .center
        textLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
    }
    
    func layout() {
        let radius = (frame.width/2) * 0.7
        
        let cicularExternal = UIBezierPath(
            arcCenter: bounds.center,
            radius: radius*1.2,
            startAngle: -CGFloat.pi/2,
            endAngle: 2 * CGFloat.pi - CGFloat.pi/2,
            clockwise: true)
        
        let cicularPath = UIBezierPath(
            arcCenter: bounds.center,
            radius: radius,
            startAngle: -CGFloat.pi/2,
            endAngle: 2 * CGFloat.pi - CGFloat.pi/2,
            clockwise: true)
        
        externalCircular.path = cicularExternal.cgPath
        trackingPath.lineWidth = 5
        trackingPath.path = cicularPath.cgPath
        
        scorePath.lineCap = CAShapeLayerLineCap.round
        scorePath.path = cicularPath.cgPath
        
        basicAnimation.toValue = finalScore
        scorePath.add(basicAnimation, forKey: "strokeEnd")
        print(bounds)
        print(frame)
        print(bounds.center)
        textLabel.frame = CGRect(x: 0,
                                 y: 0,
                                 width: bounds.width,
                                 height: 30)
        textLabel.center = bounds.center
        textLabel.frame
        textLabel.layer.borderColor = UIColor.red.cgColor
        textLabel.layer.borderWidth = 2
        
    }
}

view.backgroundColor = .white
view.layer.borderColor = UIColor.red.cgColor
view.layer.borderWidth = 2

let circularView = CircularScoreView()

circularView.scoreColor = .green
circularView.layer.borderColor = UIColor.red.cgColor
circularView.layer.borderWidth = 2
circularView.animationDuration = 2
circularView.finalScore = 0.5
circularView.frame = CGRect(x: 100,
                            y: 100,
                            width: 100,
                            height: 100)

view.addSubview(circularView)

PlaygroundPage.current.liveView = view
