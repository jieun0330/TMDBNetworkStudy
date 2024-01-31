//
//  BaseViewController.swift
//  SeSAC4Seflix
//
//  Created by 박지은 on 1/31/24.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print(self, #function)
        
        view.backgroundColor = .white
        configureHierarchy()
        configureConstraints()
        configureView()
        
    }

    func configureHierarchy() {
        print(self, #function)

    }
    
    func configureConstraints() {
        print(self, #function)

    }
    
    func configureView() {
        print(self, #function)

    }
    
}
