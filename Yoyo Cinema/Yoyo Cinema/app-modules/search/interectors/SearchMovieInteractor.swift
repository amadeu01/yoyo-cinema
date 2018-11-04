//
//  SearchMovieInteractor.swift
//  Yoyo Cinema
//
//  Created by Amadeu Cavalcante Filho on 03/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import SDWebImage

final class SearchMovieInteractor: SearchMovieInteractorInputProtocol {
    var remoteDataManager: WebClientProtocol?
    
    var presenter: SearchMovieInteractorOutputProtocol?
    
    func searchMovie(by query: String, at page: Int = 1) {
        if let webClient = remoteDataManager {
            GetTmdbConfigurationRemoteGateway(webClient: webClient) { (configuration, error) in
                if let _ = error {
                    self.presenter?.onError()
                    return
                }
                SearchMovieGateway(webClient: webClient, query: query, page: page) { (movies, error) in
                    if let _ = error {
                        self.presenter?.onError()
                        return
                    }
                    if let movies = movies, let configuration = configuration {
                        let moviesWithImageUrls = movies.map { $0.updateImageUrls(with: configuration) }
                        moviesWithImageUrls.forEach { self.storeImages(urlString: $0.posterUrl) }
                        self.presenter?.didRetrieveMovies(moviesWithImageUrls, for: query)
                    }
                    }.fetchData()
                }.fetchData()
        }
    }
    
    private func storeImages(urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else { return }
        SDWebImageDownloader.shared()
            .downloadImage(
                with: url,
                options: SDWebImageDownloaderOptions.scaleDownLargeImages,
                progress: nil) { (image, data, error, finished) in
                    SDImageCache.shared().store(image, forKey: urlString, toDisk: true, completion: nil)
        }
    }
}
