//
//  TMDBAPI.swift
//  SeSAC4Seflix
//
//  Created by 박지은 on 2/1/24.
//

import Foundation
import Alamofire

// 한가지를 선택해보자~ 하면 열거형임
// case를 명시적으로 나누고싶어서 열거형을 쓴다!
enum TMDBAPI {
    
    // URL
    // case는 고유해야한다, rawValue가 겹치면 안됨 알지???? 안다고해
    case trending
    case search(query: String)
    // 매개변수를 만들어준다!? -> 열거형의 연관값이라고 한다
    case photo(id: Int)
    
    
    // 오류가 나는 이유는 -> 열거형은 저장 프로퍼티가 될 수 없다,
    // 저장 프로퍼티 & 인스턴스 프로퍼티
    // 인스턴스를 만들어야 만들 수 있는데 ->인스턴스가 만들지 않았으니 -> static & 연산
    //    let baseURL = "https://api.themoviedb.org/3/"
    // 연산
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var endpoint: URL {
        switch self {
        case .trending:
            return URL(string: baseURL + "trending/movie/week")!
        case .search:
            return URL(string: baseURL + "search/movie")!
        case .photo(let id):
            return URL(string: baseURL + "movie/\(id)/images")!
            
        }
    }
    
    var header: HTTPHeaders {
        return ["Authorization": APIKey.tmdb]
    }
    
    // 각 case가 어떤 방식인지(get, post)
    var method: HTTPMethod {
        return .get
    }
    
    var parameter: Parameters {
        switch self {
        case .trending:
            ["": ""]
        case .search(let query):
            ["language": "ko-KR", "query": query]
        case .photo:
            ["": ""]
        }
        
    }
}
