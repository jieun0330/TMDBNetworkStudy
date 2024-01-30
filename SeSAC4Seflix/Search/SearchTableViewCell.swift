//
//  SearchTableViewCell.swift
//  SeSAC4Seflix
//
//  Created by 박지은 on 1/30/24.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    let titleLabel = BlackTextLabel()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    
    
    // 스토리보드냐 아니냐의 차이
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .green
        
        configureHiearchy()
        configureConstraints()
        configureView()
        
    }
    
    func configureHiearchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
    }
    
    func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView).inset(20)
            make.height.equalTo(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(contentView)
            make.top.equalTo(titleLabel.snp.bottom)
        }
        
        
        
    }
    
    func configureView() {
        backgroundColor = .green
        titleLabel.backgroundColor = .red
        collectionView.backgroundColor = .blue
    }
    
    static func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 160)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        
        return layout
    }
    
    
    // 프로토콜 안에 있는 내용이다보니 꼭 적어라 하고 자동생성되는거임
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
