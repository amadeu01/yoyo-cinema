//
//  MovieDetailView.swift
//  YoyoFramework
//
//  Created by Amadeu Cavalcante Filho on 03/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation
import SnapKit
import SDWebImage
import UIKit


public final class MovieDetailView: UIViewController, MovieDetailViewProtocol {
    public var presenter: MovieDetailPresenterProtocol?
    var movieEntity: MovieEntity!
    
    let container = UIScrollView()
    var overviewTextLabel = UILabel()
    let overviewLabel = UILabel()
    
    public func showError() {
        
    }
    
    public func showLoading() {
        
    }
    
    public func hideLoading() {
        
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        addScrollView()
        addOverview()
        addFavoriteButton()
        
        if let movie = movieEntity {
            showMovieDetail(for: movie)
        }
    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        container.contentSize = CGSize(width: self.view.frame.width,
                                       height: 700)
        updateOverviewTextConstraint()
    }
    
    func addScrollView() {
        container.backgroundColor = .white

        self.view.addSubview(container)
        
        container.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    func addOverview() {
        overviewLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        overviewLabel.textAlignment = .left
        overviewLabel.text = "Overview"
        
        overviewTextLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        overviewTextLabel.textAlignment = .left
        overviewTextLabel.numberOfLines = 0
        
        self.container.addSubview(overviewLabel)
        self.container.addSubview(overviewTextLabel)
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(25)
            make.trailing.equalTo(self.view.snp.trailing).inset(15)
            make.leading.equalTo(self.view.snp.leading).inset(15)
            make.height.equalTo(40)
        }
        
        overviewTextLabel.snp.makeConstraints { make in
            make.top.equalTo(overviewLabel.snp.bottom).inset(5)
            make.trailing.equalTo(self.view.snp.trailing).inset(15)
            make.leading.equalTo(self.view.snp.leading).inset(15)
            make.height.equalTo(50)
        }
    }
    
    func addFavoriteButton() {
        let button = UIButton(type: .custom)
        button.setTitle("Add to Favorites", for: .normal)
        button.backgroundColor = UIColor.lightDark
        button.tintColor = UIColor.white
        button.layer.borderColor = UIColor.clear.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(self.addFavorite), for: UIControl.Event.touchUpInside)
        
        self.container.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.top.equalTo(overviewTextLabel.snp.bottom).inset(15)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(140)
        }
    }
    
    @objc func addFavorite() {
        presenter?.favorited(movieEntity)
    }
    
    public func showMovieDetail(for movieEntity: MovieEntity) {
        self.movieEntity = movieEntity
        overviewTextLabel.text = movieEntity.overview
    }
    
    func updateOverviewTextConstraint() {
        let screenWidth = UIScreen.main.bounds.width
        if let text = overviewTextLabel.text {
            let height = text.height(withConstrainedWidth: screenWidth,
                                     font: overviewTextLabel.font)
            overviewTextLabel.snp.updateConstraints { make in
                make.height.equalTo(height + 70)
            }
        }
    }
}
