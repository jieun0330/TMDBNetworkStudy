//
//  HomeViewController.swift
//  SeSAC4Seflix
//
//  Created by 박지은 on 1/29/24.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    // 1.
    let logoImageView = PosterImageView(frame: .zero) // 위아래양옆 다 0으로 주는거랑 똑같음
    let emailField = BlackRadiusTextField()
    let passwordField = BlackRadiusTextField()
    let sampleLabel = BlackTextLabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        view.backgroundColor = .white
        
        configureHierarchy()
        configureView()
        configureConstraints()

    }
    
    func configureHierarchy() {
        [logoImageView, emailField, passwordField, sampleLabel].forEach {
            view.addSubview($0)
        }
    }
    
    // method, extension으로 빼서 쓸 수 있게끔
    func configureView() {
        
        logoImageView.image = UIImage(systemName: "person")
        
//        emailField.backgroundColor = .clear
//        emailField.textAlignment = .center
//        emailField.borderStyle = .none
//        emailField.layer.cornerRadius = 8
//        emailField.layer.borderColor = UIColor.black.cgColor
//        emailField.layer.borderWidth = 1
        emailField.placeholder = "이메일을 입력해주세요"
        
//        passwordField.backgroundColor = .clear
//        passwordField.textAlignment = .center
//        passwordField.borderStyle = .none
//        passwordField.layer.cornerRadius = 8
//        passwordField.layer.borderColor = UIColor.black.cgColor
//        passwordField.layer.borderWidth = 1
        passwordField.placeholder = "비밀번호를 입력해주세요"
        
        sampleLabel.text = "레이블 커스텀뷰 테스트"
    }
    
    
    func configureConstraints() {
        
        logoImageView.snp.makeConstraints {
            $0.size.equalTo(200)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        emailField.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            $0.height.equalTo(50)
            $0.center.equalTo(view.safeAreaLayoutGuide)
        }
        
        passwordField.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            $0.height.equalTo(50)
            $0.top.equalTo(emailField.snp.bottom).offset(24)
        }
        
        sampleLabel.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            $0.height.equalTo(50)
            $0.top.equalTo(passwordField.snp.bottom).offset(24)
        }
        
    }


}
