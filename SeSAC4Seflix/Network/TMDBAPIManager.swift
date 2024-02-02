//
//  TMDBAPIManager.swift
//  SeSAC4Seflix
//
//  Created by 박지은 on 1/30/24.
//

import Foundation
import Alamofire

class TMDBAPIManager {
    
    func request<T: Decodable>(type: T.Type, api: TMDBAPI, completionHandler: @escaping ((T) -> Void)) {
        
        // url 주소도 아래꺼랑 3까지는 똑같음
//        let url = "\(baseURL)trending/movie/week?language=ko-KR"
        
        
        // parmaeters: HTTP Body, Query String
        AF
            .request(api.endpoint,
                     method: api.method,
                     parameters: api.parameter,
                     // ???: 검색하는거니까 encoding이 필요한것같다
                     encoding: URLEncoding(destination: .queryString),
                     headers: api.header)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let success):
                    print("success", success)
                    
                    completionHandler(success) // 클로저 안에 클로저에 있는걸 꺼내기 위해서는 @escaping
                    
                case .failure(let failure):
                    print("fail", failure)
                }
            }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    // 싱글톤
    static let shared = TMDBAPIManager()
    // 아래 메서드 안에 있는 Header랑 반복되니까 하나로 합치는 작업을 해보자
    let header: HTTPHeaders = ["Authorization": APIKey.tmdb]
    let baseURL = "https://api.themoviedb.org/3/"
    
    
    
    // 밑에꺼랑 똑같음
//    func searchMovie(query: String, completionHandler: @escaping ([Movie]) -> Void) {
//    func searchMovie(api: TMDBAPI, completionHandler: @escaping ([Movie]) -> Void) {

        
//        let url = baseURL + "search/movie?language=ko-KR&query=\(query)"
        
        // 값을 확인했으니까 원래 상태 코드로,,?
        //        AF
        //            .request(url, headers: header)
        //            // 식판에 담는게 아니라 문자열 그대로 잘 오는지 확인하는 코드
        //            .responseString { response in
        //                print(response)
        //                print(response.result)
        //            }
//        
//        AF
//            .request(api.endpoint,
//                     method: api.method,
//                     parameters: api.parameter,
//                     encoding: URLEncoding(destination: .queryString),
//                     headers: api.header)
//            .responseDecodable(of: TrendingModel.self) { response in
//                switch response.result {
//                case .success(let success):
//                    print("success", success)
//                    
//                    completionHandler(success.results) // 클로저 안에 클로저에 있는걸 꺼내기 위해서는 @escaping
//                    
//                case .failure(let failure):
//                    print("fail", failure)
//                }
//            }
//    }
    
    // 이 메서드 안에서는 모든 값을 리턴을 해야 하기 때문에 return으로 하기 어렵다 ?
    func fetchMovie(api: TMDBAPI, completionHandler: @escaping (([Movie]) -> Void)) {
        
        // url 주소도 아래꺼랑 3까지는 똑같음
//        let url = "\(baseURL)trending/movie/week?language=ko-KR"
        
        
        // parmaeters: HTTP Body, Query String
        AF
            .request(api.endpoint,
                     method: api.method,
                     parameters: api.parameter,
                     // ???: 검색하는거니까 encoding이 필요한것같다
                     encoding: URLEncoding(destination: .queryString),
                     headers: api.header)
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
    func fetchMovieImages(api: TMDBAPI, completionHandler: @escaping (PosterModel) -> Void) {
//        let url = "\(baseURL)movie/\(id)/images"
        
        AF
            .request(api.endpoint, headers: header)
            .responseDecodable(of: PosterModel.self) { response in
                switch response.result {
                case .success(let success):
                    
                    // ???: 
                    completionHandler(success)
                case .failure(let failure):
                    print("fail", failure)
                }
            }
    }
}
