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
    
    /*
     completionhanler에서 성공했을때만 하고있는데
     실패했을때도 completionhanler를 탈 수 있게 만든다
     */
    
    // 🚨🚨🚨🚨🚨
    // DispatchGroup 코드에서 발생할 수 있는 문제?
    // 실패 케이스에 대해서도 completionHandler 필요! (ex. toast)
    // completionHandler를 2개 만들지, 매개변수를 2개 생성할 지
    // 만약 매개변수 2개로 생성한다면, 왜 옵셔널이어야만 하는지 -> 옵셔널이 아니면 어떻게 되는지
    
    
    
    // 이 메서드 안에서는 모든 값을 리턴을 해야 하기 때문에 return으로 하기 어렵다 ?
    func fetchMovie(api: TMDBAPI,
                    // 핸들러를 두개 쓰기 귀찮아서 옵셔널 처리로 두개를 붙여준다
                    completionHandler: @escaping (([Movie]?, AFError?) -> Void)) {
        
        // url 주소도 아래꺼랑 3까지는 똑같음
//        let url = "\(baseURL)trending/movie/week?language=ko-KR"
        
        // parmaeters: HTTP Body, Query String
        AF
            .request(api.endpoint, // url
                     method: api.method, 
                     parameters: api.parameter,
                     // ???: 검색하는거니까 encoding이 필요한것같다
                     encoding: URLEncoding(destination: .queryString),
                     headers: api.header)
            .responseDecodable(of: TrendingModel.self) { response in
                switch response.result {
                case .success(let success):
                    print("success", success)
                    
                    // 성공했다면 -> 에러가 없다는 의미니까 ->  nil
                    // 에러를 전달해줄 필요가 없다
                    completionHandler(success.results, nil) // 클로저 안에 클로저에 있는걸 꺼내기 위해서는 @escaping
                    
                case .failure(let failure):
                    print("fail", failure)
                    // 네트워크 실패했을 경우 -> movie data를 전달해줄 수 없으니까 nil
                    completionHandler(nil, failure)
                    // 실패했을 때 alert나 toast message를 왜 못띄울까? -> 이걸 띄우기 위해선 뷰가 있어야 하는데, 띄울 수 있는 존재는 뷰컨밖에 없다
                    // 그래서 Present 같은 요소를 부를 수가 없다
                    // -> completionhandler가 하나만 있으라는 법은 없다, 하나 더 만들겠다
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
