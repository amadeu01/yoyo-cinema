//
//  FavoriteMovieView.swift
//  Yoyo Cinema
//
//  Created by Amadeu Cavalcante Filho on 03/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import UIKit
import SnapKit

final public class FavoriteMovieView: UIViewController, FavoriteMovieViewProtocol {
    public var presenter: FavoriteMoviePresenterProtocol?
    
    public var movieList: MovieListViewProtocol?
    
    
    public override func viewDidLoad() {
        addMovieListView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    func addMovieListView() {
        if let movieList = movieList as? MovieListView {
            self.view.addSubview(movieList)
            movieList.tableFooterView = UIView(frame: CGRect.zero)
            movieList.parent = self
            
            movieList.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
                make.trailing.equalToSuperview()
                make.leading.equalToSuperview()
                make.center.equalToSuperview()
            }
        }
    }
    
}
