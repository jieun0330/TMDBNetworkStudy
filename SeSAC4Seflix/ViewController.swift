//
//  ViewController.swift
//  SeSAC4Seflix
//
//  Created by 박지은 on 1/29/24.
//

import UIKit

class ViewController: UIViewController {
    
    // BlackRadiusTextField를 우선 코드로 구현해놓은 상황이죠
    // CodeBase. HomeVC에서는 코드로 그대로 사용 , override init
    
    // 근데 지금 상황은
    // storyboard에 blackradiustextfield가 추가된 상황이라서
    // override init이 아니라 required init 이 나와야되는거 아닌가?
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        TMDBAPIManager.shared.request(type: PosterModel.self,
                                      api: .photo(id: 518068)) { poster in
                                    print(poster)
        }
        
        TMDBAPIManager.shared.request(type: TrendingModel.self,
                                      api: .search(query: "apple")) { search in
                                    print(search)
        }
        
        TMDBAPIManager.shared.request(type: TrendingModel.self,
                                      api: .trending) { trending in
                                    print(trending)
        }
        
        
        
        
        struct User {
            static let id = 123123 // 타입 프로퍼티
            let nick: String // 인스턴스 프로퍼티
        }
        
        
        // String 타입의 인스턴스를 저장
        let name: String = "고래밥"
        
        let metaName: String.Type = String.self
        //                let metaName = name.self
        
        //                let metaName = String.self
        
        
        // Int 타입의 인스턴스(실제값)를 저장
        let age = 23
        
        // user: User 타입의 인스턴스를 저장
        let user: User = User(nick: "Jack")
        
        print(name, age, user)
        print(type(of: name), type(of: age), type(of: user))
        print(type(of: String.self), type(of: Int.self), type(of: User.self)) // ???: 구조체 그 자체를 가져오기 위해서는 .self를 붙어야 한다?
        
        // Int, String, User 타입 자체를 저장할 순 없을까 ?
        //        let string = String
        
        
        
        let meta: User.Type = User.self
        
        User.self.id // ???: 인스턴스 프로퍼티와 상관없이 타입프로퍼티니까 부를 수 있다?
        User.id // 위에랑 동일함
        meta.id // 동일함
        
        
        
        
        
        
        
        
        
        
        
        
        // 명세할 때 같은 타입인지만 명세하고
        //        plus(a: Cyndi, b: Cyndi)
        
        // Cyndi 자리에 내가 Int를 넣으면 Int가 되는거고
        let a = plus(a: 3, b: 3)
        
        // Double을 넣으면 Double이 된다, 그냥 그게 원래 자기 타입이었던것마냥!
        let b = plus(a: 1.5, b: 1.5)
        
        //        let c = plus(a: "안녕", b: "하세요")
        //        let d = plus(a: false, b: true)
        
        let c = UILabel()
        let d = UIImageView()
        let e = UIButton()
        setBorder(a: c)
        setBorder(a: d)
        setBorder(a: e)
        
        
        
        //        print(a,b)
    }
    
    
}

