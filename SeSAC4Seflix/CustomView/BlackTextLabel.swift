//
//  BlackTextLabel.swift
//  SeSAC4Seflix
//
//  Created by 박지은 on 1/29/24.
//

import UIKit

class BlackTextLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    func configureView() {
        self.font = .boldSystemFont(ofSize: 15)
        self.textAlignment = .left
        self.numberOfLines = 2
        self.backgroundColor = .clear
        self.textColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    
    
}
