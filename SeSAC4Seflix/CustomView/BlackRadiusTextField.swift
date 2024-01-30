//
//  BlackRadiusTextField.swift
//  SeSAC4Seflix
//
//  Created by 박지은 on 1/29/24.
//

import UIKit

/*
 스토리보드 기반 -> required init
 코드 기반 -> override init / required init
 */

// override: 재정의, 슈퍼클래스
// required: 프로토콜로부터 온것
// override required init: 부모클래스, 부모클래스에서 프로토콜을 채택

// NSObject Class: init(frame:) / NSCoding: init?(coder:)
// -> UIViewController
// -> UIView
    // -> UITextField
    // -> UIImageView
    // 그래서 override를 할 수 있다 ?

@IBDesignable
class BlackRadiusTextField: UITextField {

    // xib 만들지않고 코드 베이스로 만들면 override 구문이 실행된다
    // 초기화 구문 만들어주기
    // 코드로 작업했을 때 init
    override init(frame: CGRect) {
        super.init(frame: frame) // 까무그면 안돼요~
        
        configureView()
        print("textField override init")
        
    }
    
    func configureView() {
        backgroundColor = .clear
        textAlignment = .center
        borderStyle = .none
        layer.cornerRadius = 8
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
    }
    
    // 스토리보드로 작업했을 때 init, NSCoding Protocol
    // 초기화가 실패될수도있어~ 는 왜그럴까? ->
    // 코드베이스로 하면 유아이 값들이 닐값이 될 수 있으니까?
    // 네?
    // 너무 어려우면 required는 프로토콜 이라고 생각정도만 해주세요
    
    // 코드베이스로만 작업을 해서 위에 override가 실행될 수 있또록 할건데
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("textField required init")
        // 무조건 앱 종료해
        // fatalError를 어디선가 구현해놨으면 꺼지게 됨
//        fatalError("init(coder:) has not been implemented")
        
        // fatalError는 왜 자동생성되는걸까
        // -> required init 런타임 컴파일 오류를
        // 코드로 작업하는거지? 스토리보드로 작업하게 되면 오류날 수 있게 만들어줄게
        // 명확하게 런타임 오류로 진행되게끔 만들어준거임
        // fatalError: 디버깅 ? ? ? ? -> 런타임 오류가 발생하는거니까 잘 사용해야댐요~
        // 비슷한기능 하나 더 있는데 그냥 듣고 넘기세염~ assert
        
        configureView()
    }
    
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
}





//protocol Example {
//    func example()
//    init() // init구문도 프로토콜 안에 넣을 수 있음
//}

//class Apple: Mobile {
//    func example() { //Example을 채택하면
//        <#code#>
//    }
//    
//    required init() { // 프로토콜에서 온 initializer구나 하면 됨
//        <#code#>
//    }
    
    
//    let name: String
//    
//    override init(name: String) {
//        self.name = name
//    }
//    
//    required init() {
//        fatalError("init() has not been implemented")
//    }
//}




//class Mobile: Example {
//    required init() { // example에 init구문 있던데 너도 써야돼, 프로토콜에서 온거구나 하면 됨
//        <#code#>
//    }
//    
//    func example() { // Example을 채택하게 되면 이 함수가 자동 생성
//        <#code#>
//    }
//    
//    let name: String
//    
//    init(name: String) {
//        self.name = name
//    }
//}
