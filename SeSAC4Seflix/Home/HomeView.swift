//
//  HomeView.swift
//  SeSAC4Seflix
//
//  Created by 박지은 on 2/1/24.
//

import UIKit
import SnapKit

class HomeView: BaseView {
    
    let logoImageView = PosterImageView(frame: .zero) // 위아래양옆 다 0으로 주는거랑 똑같음
    
    let emailField: BlackRadiusTextField = {
        let view = BlackRadiusTextField()
        view.placeholder = "이메일을 입력해주세요"
        return view
    }()
    
    let passwordField = BlackRadiusTextField()
    let sampleLabel = BlackTextLabel()
    
    let signButton: UIButton = {
        let view = UIButton()
        view.setTitle("버튼", for: .normal)
        view.backgroundColor = .black
        view.setTitleColor(.white, for: .normal)
        return view
    }()
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        configureHierarchy()
//        configureConstraints()
//        configureView()
        
//    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func configureHierarchy() {
        [logoImageView, emailField, passwordField, sampleLabel, signButton].forEach {
            addSubview($0)
    }
        
    }
    
    override func configureConstraints() {
        
        logoImageView.snp.makeConstraints {
            $0.size.equalTo(200)
            $0.top.equalTo(safeAreaLayoutGuide).offset(24)
            $0.centerX.equalTo(safeAreaLayoutGuide)
        }
        
        emailField.snp.makeConstraints {
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            $0.height.equalTo(50)
            $0.center.equalTo(safeAreaLayoutGuide)
        }
        
        passwordField.snp.makeConstraints {
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            $0.height.equalTo(50)
            $0.top.equalTo(emailField.snp.bottom).offset(24)
        }
        
        sampleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            $0.height.equalTo(50)
            $0.top.equalTo(passwordField.snp.bottom).offset(24)
        }
        
        signButton.snp.makeConstraints {
            $0.bottom.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(30)
            $0.height.equalTo(50)
        }
        
    }
    
    override func configureView() {
        
        logoImageView.image = UIImage(systemName: "person")
        emailField.placeholder = "이메일을 입력해주세요"
        passwordField.placeholder = "비밀번호를 입력해주세요"
        sampleLabel.text = "레이블 커스텀뷰 테스트"
        
        // HomeView signButton addTarget 연결 방법 2️⃣
        //        signButton.addTarget(self, action: #selector(signButtonClicked), for: .touchUpInside)
        
    }
    
    //    @objc func signButtonClicked() {
    //        present -> 자동완성이 안됨
    // present를 UIView에서 부르려니까 안됨
    // present는 화면을 띄워주는 화면전환 코드인데 -> 이건 UIViewController에서 갖고있음
    
    // -> 각 버튼의 기능, 화면 전환, 서버통신과 같은 이벤트 관련된 것은 -> HomeViewController에서 하는게 깔끔하다고 생각함 -JACK-
    //    }
}
