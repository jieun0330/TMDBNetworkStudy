//
//  DetailViewController.swift
//  SeSAC4Seflix
//
//  Created by 박지은 on 1/31/24.
//

import UIKit
import SnapKit
// snapkit을 쓰지 않아도 빌드 됨 이요옹롤올올~(근데 이건 라이브러리마다 다름) 이건 snapkit 코드 내부에 이렇게 구성해놔서 그럼
// 그래도 어떤걸 쓰고있는지 보여줘야함, 최대한 명세하는게 제일 좋음

class DetailViewController: BaseViewController {
    
    let label = UILabel()
    
// 이게 없어도 실행되는지 테스트
// viewDidLoad에서 수행하는 기능들이 다 들어있으니까
    override func viewDidLoad() { // 이건 애플이 만들어준거고, 애플이 어떤걸 만들었는지 우리는 모름
        super.viewDidLoad() // 그래서 super 항시 호출하는게 맞음
        
    }

    // 자동생성됨 ㅁㅊㅁㅊㅁㅊ
    override func configureHierarchy() { // 벗뜨 얘의 super를 불러버리면 base에 있는 프린트까지 실행되버리니까 super 안붙여도됨
        view.addSubview(label)
    }
    
    
    override func configureConstraints() {
        label.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
    override func configureView() {
        label.backgroundColor = .red
    }
    
    

}
