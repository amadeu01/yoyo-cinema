//
//  MovieTableViewCell.swift
//  YoyoFramework
//
//  Created by Amadeu Cavalcante Filho on 03/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation
import SnapKit
import SDWebImage

class MovieTableViewCell: UITableViewCell {
    static let idendifier = "movieCellCard"
    let movieCard = MovieCard()
    
    var movie: MovieEntity? {
        didSet {
            updateMovie()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(style: UITableViewCell.CellStyle.default,
                   reuseIdentifier: MovieTableViewCell.idendifier)
    }
    
    func updateMovie() {
        self.subviews.forEach { $0.removeFromSuperview() }
        
        movieCard.movie = movie
        movieCard.backgroundColor = UIColor.lightDark
        movieCard.blurEffect = .extraLight
        movieCard.subtitleSize = 16
        movieCard.textColor = UIColor.black
        
        movieCard.title = movie?.title ?? ""
        movieCard.subtitle = movie?.releaseDate ?? ""
        movieCard.backgroundImage = UIImage(named: "film-poster-placeholder")
        movieCard.backgroundIV.contentMode = .scaleAspectFit
        
        if let posterUrl = movie?.posterUrl {
            loadImage(url: posterUrl, movieCard: movieCard)
        }
        
        self.addSubview(movieCard)
        
        movieCard.snp.makeConstraints { make in
            make.top.equalTo(self.layoutMarginsGuide.snp.top).offset(10)
            make.bottom.equalTo(self.layoutMarginsGuide.snp.bottom).offset(-10)
            make.trailing.equalTo(self.layoutMarginsGuide.snp.trailing).offset(-8)
            make.leading.equalTo(self.layoutMarginsGuide.snp.leading).offset(8)
            make.center.equalToSuperview()
        }
    }
    
    func loadImage(url: String, movieCard: MovieCard) {
        let cache = SDImageCache.shared()
        
        SDWebImageDownloader
            .shared()
            .downloadImage(
                with: URL(string: url),
                options: SDWebImageDownloaderOptions.lowPriority,
                progress: nil) { (image, data, error, finished) in
                    if let image = image {
                        movieCard.backgroundImage = image
                        cache.store(image, imageData: data, forKey: url, toDisk: true, completion: nil)
                    }
        }
        
    }
}
