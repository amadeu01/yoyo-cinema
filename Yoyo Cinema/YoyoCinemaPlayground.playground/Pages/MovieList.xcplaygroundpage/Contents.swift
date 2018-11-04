import UIKit
import PlaygroundSupport
@testable import YoyoFramework
import SnapKit

var StarWars = MovieEntity(
    id: 10,
    title: "Star Wars",
    originalTitle: "Star Wars",
    adult: false,
    video: false,
    releaseDate: "1977-05-25",
    voteCount: 9994,
    backdropPath: "/4iJfYYoQzZcONB9hNzg0J0wWyPH.jpg",
    budget: 11000000,
    genres: [.scienceFiction],
    homepage: "http://www.starwars.com/films/star-wars-episode-iv-a-new-hope",
    originalLanguage: "English",
    overview: "Princess Leia is captured and held hostage by the evil Imperial forces in their effort to take over the galactic Empire. Venturesome Luke Skywalker and dashing captain Han Solo team together with the loveable robot duo R2-D2 and C-3PO to rescue the beautiful princess and restore peace and justice in the Empire.",
    popularity: 29.106,
    posterPath: "/btTdmkgIvOi0FFip1sPuZI2oQG6.jpg",
    revenue: 775398007,
    runtime: 121,
    status: "Released",
    tagline: "A long time ago in a galaxy far, far away...",
    voteAverage: 8.2,
    posterUrl: nil,
    backdropUrl: nil)


let config = TMDbConfigurationEntity(
    baseUrl: "http://image.tmdb.org/t/p/",
    secureBaseUrl: "https://image.tmdb.org/t/p/",
    backdropSizes: ["w300", "w780", "w1280", "original"].map { BackdropSize($0) },
    logoSizes: ["w45", "w92", "w154", "w185", "w300", "w500"],
    posterSizes: ["w154", "w185", "w342", "w500", "w780", "original"].map { PosterSize($0) },
    profileSizes: ["w45", "w185", "h632", "original"],
    stillSizes: ["w92", "w185", "w300", "original"],
    changeKeys: ["adult"])

StarWars.updateImageUrls(with: config)

class MovieDelegate: MovieListDelegate {
    func loadMoreMovies() {
        
    }
    
    func didSelect(_ movie: MovieEntity) {
        
    }
}

class MyList: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let movieList = MovieListView(movies: [StarWars], movieListDelegate: MovieDelegate())
        
        self.view.addSubview(movieList)
        
        movieList.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview()
            make.center.equalToSuperview()
        }
    }
}


PlaygroundPage.current.liveView = MyList()
