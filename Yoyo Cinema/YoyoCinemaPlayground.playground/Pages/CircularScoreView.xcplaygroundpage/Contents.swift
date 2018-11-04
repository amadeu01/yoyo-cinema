import UIKit
import PlaygroundSupport
@testable import YoyoFramework
import SnapKit

let view = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))

view.backgroundColor = .white

let circularView = CircularScoreView()

circularView.scoreColor = .green
circularView.animationDuration = 2
circularView.finalScore = 0.5

view.addSubview(circularView)
circularView.translatesAutoresizingMaskIntoConstraints = false

circularView.snp.makeConstraints { make in
    make.center.equalToSuperview()
    make.bottom.equalToSuperview()
    make.top.equalToSuperview()
    make.leading.equalToSuperview()
    make.trailing.equalToSuperview()
}

PlaygroundPage.current.liveView = view
