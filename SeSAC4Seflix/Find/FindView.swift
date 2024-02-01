//
//  FindView.swift
//  SeSAC4Seflix
//
//  Created by 박지은 on 2/1/24.
//

import UIKit

// !!!:  레이아웃 자체는 View가 담당할 수 있도록
class FindView: BaseView {
    
    // 정답은 없음, UI를 한번에 보기는 편하긴한데, 뷰컨 위에가 지저분해보이는 점도 있음
    // FindViewController 인스턴스 생성 전에, 클로저가 먼저 실행 -> 대 체 ? 왜?  얘 가 먼 저 실 행 됨
    let searchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "영화를 검색해보세요"
        view.showsCancelButton = true
        view.barStyle = .black
        print("searchBar 생성") // 실화? viewDidLoad보다 먼저 실행이 됨? // 클로저로 바꾸게 되면 viewDidLoad가 실행되기전 디자인이 다 만들어짐
        return view
    }()
    
    // !!!: 이건 없어도 됨
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
    // 위에꺼랑 동일함
//    let bar: UISearchBar = UISearchBar()
    
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
        view.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "Search")
        
        return view
        
    }()
    
    override func configureHierarchy() {
        [searchBar, collectionView].forEach {
            addSubview($0)
        }
    }
    
    override func configureConstraints() {
        searchBar.snp.makeConstraints {
            $0.horizontalEdges.top.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
            $0.top.equalTo(searchBar.snp.bottom)
        }
        
    }
    
    
    static func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.width / 3 )
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        
        return layout
    }
    
//    func configureView() {
//        searchBar.placeholder = "영화를 검색해보세요"
//        searchBar.showsCancelButton = true
//        searchBar.barStyle = .black
//    }
}
