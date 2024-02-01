//
//  TrendingModel.swift
//  SeSAC4Seflix
//
//  Created by 박지은 on 1/30/24.
//

import Foundation

// Codable = Decodable & Encodable
// 두가지의 정보를 다 줄 필요는 없다
// 범주를 좁혀서 받는 애구나 싶으면 Decodable로 작성하면 된다

// 서버 응답이 옵셔널인지 아닌지에 따라서도 식판을 다르게 만들어 주어야 한다!
struct TrendingModel: Decodable {
    let page: Int
    let results: [Movie]
    
}


// struct 이름은 마음대로 해도 되지만 안에 있는 Key 값들은 그대로 사용하자
// 서버에서 값이 null로 오지만, 클라이언트 모델에서는 옵셔널이 아닌 모델로 구성할 수는 없을까?
struct Movie: Decodable {
    let id: Int
    let title: String
    let original: String // 그냥 Original 로 쓰고싶다면?
    let overview: String
    let poster: String
    let backdrop: String?
    // 서버에서 영화가 몇위인진 알 수 없지만 -> 우리가 명시시켜줄 수 있다?
//    let top10: String?
    
    // 어느걸 앞에 써야되는거야?
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case original = "original_title"
        case overview
        case poster = "poster_path"
        case backdrop = "backdrop_path"
    }
    
    // 옵셔널 값 처리하기 귀찮으니까 처리하는 구문임
    // 식판을 담을 때 위에 있는 enum을 거치게 됨

    // 서버에서 받은 값을 그대로 사용하지 않고, 일부 제약조건을 추가하거나 값에 대한 변형을 하고싶을 때 사용
    // ex. 서버에서 null을 줄 때, 대체할 문자열을 추가하고싶을 때
    
//    init(from decoder: Decoder) throws {
//        // 식판 전체를 부르는게 container
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        // 식판에 담아줄게 라는 표현임
//        // decode: 확정, 서버에서 모든 데이터를 절대 nil이 되지 않게 해줌
//        // decodeIfPresent -> 서버에서 null값이 올 수 있는 것들을 바꿔줌
//        self.id = try container.decode(Int.self, forKey: .id)
//        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
//        self.original = try container.decodeIfPresent(String.self, forKey: .original) ?? ""
//        self.overview = try container.decodeIfPresent(String.self, forKey: .overview) ?? "줄거리 없음"
//        self.poster = try container.decode(String.self, forKey: .poster)
//        // null 값일때 "" 빈값으로 보여달라
//        self.backdrop = try container.decodeIfPresent(String.self, forKey: .backdrop) ?? ""
//    }
    
    
}
