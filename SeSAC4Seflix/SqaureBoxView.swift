//
//  SqaureBoxView.swift
//  SeSAC4Seflix
//
//  Created by 박지은 on 1/29/24.
//

import UIKit

/*
 XIB(xml interface builder) 스위프트 코드가 아니라서  -> 컴파일 시 애플이 사용할 수 있게 NIB 파일로 변환이 됨 -> 이때 도움 주는 친구가 NSCoder 임
 
 @IBInspectable, @IBDesignable
 -> 이거 안알려주려고 했는데 회사에 레거시코드가 있다고 ?
 레거시코드 ?
 -> 이 친구들이 가지고 있는건 Interface Builder에서 컴파일 ㅅ지ㅓㅁ에, 즉 실시간으로 객체에 속성을 적용하는 방법 ?
 */


@IBDesignable
class SqaureBoxView: UIView {

    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    // init이 필요한 이유는? 🚨🚨🚨🚨🚨
    
    // codable
    // 모든 데이터를 string으로 와서 data로 바꿔주고 구조체에서 쓸 수 있게끔 해야한다 -> decodable -> 외부에서 사용하는 값을 struct로 바꾸겠다
    // 우리가 사용하는 struct를 data로 바꿔서 -> string으로 바꿔서 쓰겠다 -> encodable -> 내부에서 외부로 보내주기 위함
    
    // required init: 스토리 기반으로 작업했을 때 실행되는 init
    // init? -> init이 안될수도있다? -> inital 구문이긴 한데 실패 가능한 이니셜라이저
    required init?(coder: NSCoder) { // nscoder -> decoding, encoding 다 해주는 애임
        super.init(coder: coder)
        
        // 코드로 뷰를 load해주려고 한다
        loadView()
        loadUI()
    }
    
    // init을 할 때 xib 파일을 가져와야 한다
    func loadView() {
        
        
        // 화면 전환하는 것처럼 인스턴스화 만든다 ?
        // 이 코드를 이해하기 보다는 init구문이랑 함수 구문이랑 따로 있는걸 알아야 한다 ?
        // first 요소를 가져온다 ? 첫번째 화면을 가져온다고 생각하면 된다, 근데 그냥 한 화면 밖에 없으니까 first 쓰면 된다
        let view = UINib(nibName: "SqaureBoxView", bundle: nil).instantiate(withOwner: self).first as! UIView
        view.frame = bounds
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 10
        // squareboxview에 squareboxview를 추가한다곡?
        // xib파일 자체가 uiview에서 구현이 안되기 때문에 코드로 구현하는 피료함
        // 하나부터 다시다시 다 작업하는 영역이라고 생각하면 됨
        self.addSubview(view)
    }
    
    func loadUI() {
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.textAlignment = .center
        posterImageView.image = UIImage(systemName: "star.fill")
        posterImageView.backgroundColor = .green
    }
    
    // 이걸 작성하지못하더라도 연산프로퍼티구나 하고 이해하면 됨
    // 연산프로퍼티,,,,,,하
    // @IBInspectable: 스토리보드 인스펙터 영역에 보여주기 역할
    // 이건 단순히 보여줄게요 코드라서 인스펙터에서 실시간으로는 안보일 수 있음(버그) -> 그래서 @IBDesignable 실시간으로 반영되게끔 만들어주는거임 -> 맨위에다 붙였음
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return posterImageView.layer.cornerRadius
        }
        set {
            // 아웃렛 만들어진 시점이 보더컬러 시점보다 나중인거야 그래서 nil임
            // 시점 문제
            // inspectable, designable 문제가 아님
            // 이뿐임
            posterImageView.layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: posterImageView.layer.borderColor!)
        }
        set {
            posterImageView.layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return posterImageView.layer.borderWidth
        }
        set {
            posterImageView.layer.borderWidth = newValue
        }
    }
    
    
    
    
    
    // override init: 코드베이스로 작업했을 때 실행되는 init
//    override init(frame: CGRect) {
//        <#code#>
//    }
    
    // init이 ?가 있고, 없는 경우가 있다
    // ? -> 왜 붙지 하면 옵셔널이구나 하는 정도로만 이해하고있으면 됨
    
}
