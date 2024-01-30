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
struct TrendingModel: Decodable {
    
    let page: Int
    let results: [Movie]
    
}

// struct 이름은 마음대로 해도 되지만 안에 있는 Key 값들은 그대로 사용하자
struct Movie: Decodable {
    let id: Int
    let title: String
    let original: String // 그냥 Original 로 쓰고싶다면?
    let overview: String
    let poster: String
    let backdrop: String
    
    // 어느걸 앞에 써야되는거야?
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case original = "original_title"
        case overview
        case poster = "poster_path"
        case backdrop = "backdrop_path"
    }
    
}
