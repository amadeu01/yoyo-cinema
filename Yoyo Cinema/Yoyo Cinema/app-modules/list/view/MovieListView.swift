//
//  MovieListView.swift
//  YoyoFramework
//
//  Created by Amadeu Cavalcante Filho on 03/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

class MovieListView: UITableView, MovieListViewProtocol {
    var movieListDelegate: MovieListDelegate?
    var movies: Set<MovieEntity> = []
    fileprivate var moviesData: [MovieEntity] = []
    
    var parent: UIViewController?
    
    fileprivate var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.color = UIColor.darkGray
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
        return activityIndicator
    }()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    init(movies: [MovieEntity], movieListDelegate: MovieListDelegate) {
        super.init(frame: CGRect.zero, style: UITableView.Style.plain)
        self.movies = Set(movies)
        self.moviesData = [MovieEntity](movies)
        self.movieListDelegate = movieListDelegate
        initialize()
    }
    
    private func initialize() {
        self.register(MovieTableViewCell.self,
                      forCellReuseIdentifier: MovieTableViewCell.idendifier)
        self.addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        self.delegate = self
        self.dataSource = self
        self.separatorStyle = .none
    }
    
    func showError() {
        
    }
    
    func showLoading() {
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
    }
    
    func showMovies(_ movies: [MovieEntity]) {
        self.movies = Set(movies)
        self.moviesData = [MovieEntity](self.movies)
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
}

extension MovieListView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = dequeueReusableCell(withIdentifier:
            MovieTableViewCell.idendifier) as? MovieTableViewCell {
            cell.movie = moviesData[indexPath.row]
            cell.movieCard.delegate = self
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension MovieListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}

extension MovieListView: CardDelegate {
    func contentViewControllerForCard(card: Card) -> UIViewController {
        card.shouldPresent(from: parent)
        if let card = card as? MovieCard {
            let detail = MovieDetailWireFrame.createMovieDetailModule(for: card.movie ?? MovieEntity.empty)
            return detail as? UIViewController ?? UIViewController()
        }
        
        return UIViewController()
    }
}
