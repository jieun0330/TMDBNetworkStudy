//
//  SearchCollectionViewCell.swift
//  SeSAC4Seflix
//
//  Created by 박지은 on 1/30/24.
//

import UIKit
import SnapKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    let posterImageView = PosterImageView(frame: .zero)
    let titleLabel = BlackTextLabel()
    
    // init 구문 2개
    // 초기값 세팅
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 순서가 중요한 이유
        configureHierarchy()
        configureConstraints()
        configureView()
        
    }
    
    func configureHierarchy() {
        [posterImageView, titleLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    func configureConstraints() {
        posterImageView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
        
        titleLabel.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalTo(contentView)
            $0.height.equalTo(20)
        }
    }
    
    func configureView() {
        posterImageView.image = UIImage(systemName: "person")
        titleLabel.text = "임시 테스트"
    }
    

    
    // 꼭 불러야 하는 메소드를 호출하지 않았을 때 너 왜 호출 안해? 하고 자동생성
    // 프로토콜에 꼭 구성해야 하는 요소
    // 코드베이스로만 작성하기 때문에 실행 될 일이 없음
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
