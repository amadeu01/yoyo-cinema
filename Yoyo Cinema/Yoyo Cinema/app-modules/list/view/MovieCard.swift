//
//  MovieCard.swift
//  YoyoFramework
//
//  Created by Amadeu Cavalcante Filho on 02/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation
import UIKit

final class MovieCard: Card {
    
    var movie: MovieEntity?
    
    var title: String = "" {
        didSet {
            titleLbl.text = title
        }
    }
    
    var titleSize: CGFloat = 26
    
    var subtitle: String = "" {
        didSet {
            subtitleLbl.text = subtitle.uppercased()
        }
    }
    
    var movieScore: Float = 0 {
        didSet {
            scoreView.finalScore = movieScore
            if movieScore > 0.68 {
                scoreView.scoreColor =
                    UIColor(red: 38/255, green: 202/255, blue: 103/255, alpha: 1)
            } else if movieScore > 0.4 {
                scoreView.scoreColor =
                    UIColor(red: 201/255, green: 206/255, blue: 38/255, alpha: 1)
            } else {
                scoreView.scoreColor =
                    UIColor(red: 207/255, green: 0, blue: 78/255, alpha: 1)
            }
        }
    }
    
    public var subtitleSize: CGFloat = 26
    
    public var blurEffect: UIBlurEffect.Style = .extraLight {
        didSet{
            blurV.effect = UIBlurEffect(style: blurEffect)
        }
    }
    
    var subtitleLbl = UILabel()
    var titleLbl = UILabel()
    var blurV = UIVisualEffectView()
    var vibrancyV = UIVisualEffectView()
    var iconIV = UIView()
    var scoreView: CircularScoreView = CircularScoreView()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override func initialize() {
        super.initialize()
        
        vibrancyV = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: UIBlurEffect(style: blurEffect)))
        iconIV.backgroundColor = .clear
        backgroundIV.addSubview(blurV)
        blurV.contentView.addSubview(titleLbl)
        blurV.contentView.addSubview(vibrancyV)
        blurV.contentView.addSubview(subtitleLbl)
        blurV.contentView.addSubview(scoreView)
        blurV.contentView.addSubview(iconIV)
        iconIV.addSubview(scoreView)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        subtitleLbl.text = subtitle.uppercased()
        subtitleLbl.textColor = textColor
        subtitleLbl.font = UIFont.systemFont(ofSize: subtitleSize, weight: .semibold)
        subtitleLbl.adjustsFontSizeToFitWidth = true
        subtitleLbl.minimumScaleFactor = 0.1
        subtitleLbl.lineBreakMode = .byTruncatingTail
        subtitleLbl.numberOfLines = 0
        
        titleLbl.textColor = textColor
        titleLbl.text = title
        titleLbl.font = UIFont.systemFont(ofSize: titleSize, weight: .bold)
        titleLbl.adjustsFontSizeToFitWidth = true
        titleLbl.minimumScaleFactor = 0.1
        titleLbl.lineBreakMode = .byTruncatingTail
        titleLbl.numberOfLines = 2
        
        iconIV.clipsToBounds = true
        
        let blur = UIBlurEffect(style: blurEffect)
        blurV.effect = blur
        
        layout()
    }
    
    override func layout(animating: Bool = true) {
        super.layout(animating: animating)
        
        let gimme = LayoutHelper(rect: backgroundIV.bounds)
        
        blurV.frame = CGRect(x: 0,
                             y: gimme.Y(78),
                             width: backgroundIV.bounds.width,
                             height: gimme.Y(23))
        
        vibrancyV.frame = blurV.frame
        
        titleLbl.frame = CGRect(x: gimme.X(20),
                                y: gimme.Y(3),
                                width: gimme.X(80),
                                height: gimme.Y(20))
        
        subtitleLbl.frame = CGRect(x: gimme.X(20),
                                   y: gimme.Y(12),
                                   width: gimme.X(80),
                                   height: gimme.Y(26))
        
        iconIV.frame = CGRect(x: gimme.X(3),
                              y: gimme.Y(3),
                              width: gimme.Y(15),
                              height: gimme.Y(15))
        
        subtitleLbl.sizeToFit()
        titleLbl.sizeToFit()
    }
    
}


