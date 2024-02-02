//
//  UIView+Extension.swift
//  SeSAC4Seflix
//
//  Created by 박지은 on 2/2/24.
//

import UIKit

enum TransitionStyle {
    case present
    case presentNavigation // 네비게이션 임베드한 채로 present
    case presentFullNavigation // 네비게이션 임베드한 채로 된 full present
    case push
}




extension UIViewController {
    
    // 아래는 a: T 이런식인데
    // 여기는 왜 T: 임 ?
    // ->
    
    // ???: T: UIViewController ? ? ? ?
    func transition<T: UIViewController>(style: TransitionStyle, storyboard: String, viewController: T.Type) {
        
//        let array: [String] = ["1", "2", "3"]
        let array: Array<String> = ["1", "2", "3"] // !!!: Array도 Generic의 형태로 되어있다~
        
        
        let sb = UIStoryboard(name: storyboard, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: String(describing: viewController)) as! T
        
        switch style {
        case .present:
            present(vc, animated: true)
        case .presentNavigation:
            let nav = UINavigationController(rootViewController: vc)
            navigationController?.pushViewController(vc, animated: true)
        case .presentFullNavigation:
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        case .push:
            navigationController?.pushViewController(vc, animated: true)
        }
        
        
        
        
        
        
    }
    
    
    // Int, Double, Float의 타입을 다 품을 수 있다면
    // Generic: 타입에 유연하게 대응
    // 같은 타입인지만 명세한다
    // 함수를 호출할 때 타입을 정의한다
    
    // T: 타입 파라미터(???: 플레이스 홀더와 같은 역할?) -> T, U (U는 뭐야 못들었어) -> Uppercase
    
    // 덧셈을 하고싶은데? -> 타입 파라미터에 뭐가 들어올지 모르니 -> 제약을 설정한다
    // 클래스 제약과 프로토콜 제약이 있다
    // Numeric: https://developer.apple.com/documentation/swift/numeric
    
    // ???: 이게 프로토콜 제약. ? ? ?
    func plus<T: Numeric>(a: T, b: T) -> T {
        return a + b
    }
    
    // a: UILable() -> UILabel == UILabel.self
    // T: UILabel -> UILabel.Type
    
    
    
    
    
    // ???: 이게 클래스 제약이고
    // Int나 String말고 UIView를 적어줄거얀
    func setBorder<T: UIView>(a: T) {
        // ???: self를 붙이고 안붙이고를 확실하게 알아두기
        a.layer.borderWidth = 1
        a.layer.borderColor = UIColor.black.cgColor
    }
    
    
    
//    func plus(a: Int, b: Int) -> Int {
//        return a + b
//    }
//    
//    func plus(a: Double, b: Double) -> Double {
//        return a + b
//    }
//    
//    func plus(a: Float, b: Float) -> Float {
//        return a + b
//    }
    

    
}


extension UIButton {
    func setBorder() {
        // ???: self를 붙이고 안붙이고를 확실하게 알아두기
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }
}
