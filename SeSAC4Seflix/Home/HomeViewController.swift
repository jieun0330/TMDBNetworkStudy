//
//  HomeViewController.swift
//  SeSAC4Seflix
//
//  Created by 박지은 on 1/29/24.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    let mainView = HomeView()
    
    // 뷰의 생명주기 중 하나인데
    // 루트뷰를 생성해주는 기능
    // HomeView 자체를 루트뷰로 변경시킨다
    // rootView 위에서 동작하는 label, button 등을 뷰컨트롤러가 아니라 'UIView'가 책임질 수 있게 설정
    // ViewDidLoad보다 먼저 실행
    
    // ⭐️주의사항: super 메소드 호출하지 않음
    override func loadView() {
        self.view = mainView
//        self.view = HomeView() // !!!: 이렇게 호출을 해버리면 아래 signButton에 접근할 수가 없으니 한번 더 체크해보기!!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 루트 뷰 자체가 바뀌기 때문에 아래 코드는 필요가 없음
//        view.addSubview(mainView)
        // 메인뷰가 루트뷰와 동일하게
//        mainView.snp.makeConstraints {
//            $0.edges.equalTo(view)
//        }
        
        view.backgroundColor = .white
        // HomeView signButton addTarget 연결 방법 1️⃣
        mainView.signButton.addTarget(self, action: #selector(signButtonClicked), for: .touchUpInside)
    }
    
    @objc func signButtonClicked() {
        present(FindViewController(), animated: true)
    }
    
}


// ViewController -? 사용자의 액션이 담겨져있다, 화면 전환, Alert와 같은 
