//
//  SearchMovieView.swift
//  YoyoFramework
//
//  Created by Amadeu Cavalcante Filho on 02/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

public final class SearchMovieView: UIViewController, SearchMovieViewProtocol {
    public var presenter: SearchMoviePresenterProtocol?
    public var movieList: MovieListViewProtocol?
    fileprivate let searchBar = UISearchBar()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        addSearchBar()
        addMovieListView()
        
        searchBar.delegate = self
    }
    
    func addSearchBar() {
        self.view.addSubview(searchBar)
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.view.layoutMargins.top).inset(UIApplication.shared.statusBarFrame.size.height)
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    func addMovieListView() {
        if let movieList = movieList as? MovieListView {
            self.view.addSubview(movieList)
            movieList.tableFooterView = UIView(frame: CGRect.zero)
            movieList.parent = self
            
            movieList.snp.makeConstraints { make in
                make.top.equalTo(self.searchBar.snp.bottom).inset(2)
                make.bottom.equalToSuperview()
                make.trailing.equalToSuperview()
                make.leading.equalToSuperview()
            }
        }
    }
}

extension SearchMovieView: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.searchMovie(matching: searchText)
    }
}

