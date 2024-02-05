//
//  TMDBSessionManager.swift
//  SeSAC4Seflix
//
//  Created by 박지은 on 2/5/24.
//

import Foundation

// 내가 내 마음대로 에러를 지정해둘게!
enum SeSACError: Error {
    case failedRequest
    case noData
    case invalidResponse
    case invalidData
}

class TMDBSessionManager {
    static let shared = TMDBSessionManager()
    
    /*
     1. URLSessionConfiguration
     - 'shared', default, background
     2. URLSessionDataTask
     - 'dataTask', download, upload, stream ...
     3. URLResponse
     - 'completionHandler' vs delegate
     */
    
//    func fetchTrendingMovie(completionHandler: @escaping (TrendingModel?, Error?) -> Void) {
        func fetchTrendingMovie(completionHandler: @escaping (TrendingModel?, SeSACError?) -> Void) { // Error -> SeSACError

        
        // 아래가 3번에 대한 내용이라는데
//        URLSession(configuration: .default)
        // 👩🏻‍🏫 근데 configuration에 shared는 안나올까 ? -> shared는 싱글톤 패턴으로 이루어져있다
        
        var url = URLRequest(url: TMDBAPI.trending.endpoint)
        // ❓❓❓❓❓ 인증키를 추가한거다 ~?
        url.addValue(APIKey.tmdb, forHTTPHeaderField: "Authorization")
        url.httpMethod = "GET"
            print("3", Thread.isMainThread)
    
        // 👩🏻‍🏫 with: URLRequest -> 어떤 정보들이 들어갈까요? -> 어느 api 쓰겠냐, 어떤 주소냐 입니다
        // 👩🏻‍🏫 with: url이 들어가도 되지만 TMDBAPI.trending.endpoint 이렇게 들어가도 상관업슴다, 이미 endpoint 보면 URL 타입이기 떄무네
        // 👩🏻‍🏫 url로 찍으면 httpMethod에 접근하는게 가능하니까 url 로 만드는게 작성이 더 용이할 것 같슴다
        
        // data, response, error
        // 👩🏻‍🏫 error가 뜻하는게 뭐일것같아요? -> 네트워크 통신이 실패했을 때 이 error에 값이 오겠죠?
        // 👩🏻‍🏫 data, response, error -> 다 옵셔널이에요, 실패했을 경우엔 error == nil 이죠?
        
            // 다른 알바생한테 일을 맡기는 꼴, 메인으로 돌려주지 않음
            // DispatchQueue.global().async 이 구문을 써주지 않더라도 -> 발생하는 문제점
            // 메인이 돌아와야되는 상황에 핸들링을 하지 않아서 생기는 문제? 
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            // 뷰컨에서 신경안쓰이게 만든다 ? 
            DispatchQueue.main.async {
                // dataTask가 내부적으로 -> 네트워크 통신은 main thread가 하기엔 적절하지 않다는걸 애플이 알고있음
                print("4", Thread.isMainThread)

                print("data", data)
                print("response", response)
                print("error", error)
                
                guard error == nil else {
                    // error가 없을 경우 네트워크가 잘 된 경우겠죠?
                    print("네트워크 통신 실패")
                    completionHandler(nil, .failedRequest) // 각각의 조건을 넣어주면 된다
                    return
                }
                
                // 이후엔 네트워크 통신 성공 기능이 들어가겠죠
                // data는 실데이터 (json 형태)
                guard let data = data else {
                    print("네트워크 통신은 성공했지만 데이터가 안옴")
                    completionHandler(nil, .noData)
                    return
                }
                print(String(data: data, encoding: .utf8))
                
                // 👩🏻‍🏫 위에 순서는 상관없는데
                // 아래 순서는 response를 받은 후 statusCode가 들어오니까
                // 아래 순서는 중요함다
                
                // response 는 status code(200)
                guard let response = response as? HTTPURLResponse else {
                    completionHandler(nil, .invalidResponse)
                    print("네트워크 통신은 성공했지만, 응답값(ex.상태코드)이 오지 않음")
                    return
                }
                
                // http헤더에 있는 statuscode만 발라낸 작업 ?
                // 상단에 있는 response 안에 statuscode가 들어있을테니 그에 맞는 상황을 처리 ?
                guard response.statusCode == 200 else {
                    completionHandler(nil, .failedRequest)
                    print("통신은 성공했지만, 올바른 값이 오지 않은 상태")
                    return
                }
                
                
                // AF - responseDecodable 구문을 작성했다고 보면 된다
                do {
                    let result = try JSONDecoder().decode(TrendingModel.self, from: data)
                    completionHandler(result, nil)
                } catch {
                    print(error) // 👩🏻‍🏫 이 에러는 어디서 왔을까요? -> 네트워크 통신에러랑 상관없이 catch문 안에 숨어있는 에러 구문이 있다
                    completionHandler(nil, .invalidData)
                }

            }
            
            
        }
        .resume() // 🚨🚨🚨🚨🚨이거 작성안하면 통신 시작 안합니다~
    }
}
