//
//  TMDBAPIManager.swift
//  SeSAC4Seflix
//
//  Created by 박지은 on 1/30/24.
//

import Foundation
import Alamofire

class TMDBAPIManager {
    
    // 싱글톤
    static let shared = TMDBAPIManager()
    
    
    // 이 메서드 안에서는 모든 값을 리턴을 해야 하기 때문에 return으로 하기 어렵다 ?
    func fetchTrendingMovie(completionHandler: @escaping (([Movie]) -> Void)) {
        let url = "https://api.themoviedb.org/3/trending/movie/week?language=ko-KR"
        let header: HTTPHeaders = ["Authorization": APIKey.tmdb]
        
        
        
        AF
            .request(url, headers: header)
            .responseDecodable(of: TrendingModel.self) { response in
                switch response.result {
                case .success(let success):
                    print("success", success)
                    
                    completionHandler(success.results) // 클로저 안에 클로저에 있는걸 꺼내기 위해서는 @escaping
                    
                case .failure(let failure):
                    print("fail", failure)
                }
            }
            
        
        
        
        

        
        
    }
    
    // 인스턴스 메서드
    func fetchMovieImages(id: Int, completionHandler: @escaping (PosterModel) -> Void) {
        let url = "https://api.themoviedb.org/3/movie/\(id)/images"
        let header: HTTPHeaders = ["Authorization": APIKey.tmdb]
        
        
        
        AF
            .request(url, headers: header)
            .responseDecodable(of: PosterModel.self) { response in
                switch response.result {
                case .success(let success):
                    completionHandler(success)
                case .failure(let failure):
                    print("fail", failure)
                }
            }
        
        
    }
    
}
