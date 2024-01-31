//
//  FindViewController.swift
//  SeSAC4Seflix
//
//  Created by 박지은 on 1/31/24.
//

import UIKit
import SnapKit

class FindViewController: UIViewController {

    
    
    // 초기화가 되어있어야 함
    let name = "고래밥"
    
    // 정답은 없음, UI를 한번에 보기는 편하긴한데, 뷰컨 위에가 지저분해보이는 점도 있음
    // FindViewController 인스턴스 생성 전에, 클로저가 먼저 실행 -> 대 체 ? 왜?  얘 가 먼 저 실 행 됨
    lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "영화를 검색해보세요"
        view.showsCancelButton = true
        view.barStyle = .black
        view.delegate = self // self 자체가 findviewcontroller 인스턴스인데, 이 클로저 구문이 인스턴스 생성 전에 이걸 해버리니까 -> lazy var을 통해 나중에 생성이 되는거임
        print("searchBar 생성") // 실화? viewDidLoad보다 먼저 실행이 됨? // 클로저로 바꾸게 되면 viewDidLoad가 실행되기전 디자인이 다 만들어짐
        return view
    }()
    
    // 위에꺼랑 동일함
//    let bar: UISearchBar = UISearchBar()
    
    
    
    lazy var bar = makeSearchBar() // 오류가 나는 이유는 ? 아래 메서드랑 실행하는 시점이 완전히 똑같은데 어떻게 넣어줌?
    // -> 그래서 lazy를 붙여준다
    
    // 매개변수도 없고 반환값도 없는걸 함수에 담긔?
    func makeSearchBar() -> UISearchBar {
        let view = UISearchBar()
        view.placeholder = "sdfsdf"
        return view
    }
    // 그래서 함수를 그냥 넣어버려

    
    lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: FindViewController.configureCollectionViewLayout())
        view.delegate = self
        view.dataSource = self
        view.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "Search")
        
        return view
        
    }()
    
    
    
    
//    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("viewDidLoad")
        configureHierarchy()
        configureConstraints()
        configureView()

    }
    
    func configureHierarchy() {
        [searchBar, collectionView].forEach {
            view.addSubview($0)
        }
    }
    
    func configureConstraints() {
        searchBar.snp.makeConstraints {
            $0.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(searchBar.snp.bottom)
        }
        
    }
    
    func configureView() {
        searchBar.placeholder = "영화를 검색해보세요"
        searchBar.showsCancelButton = true
        searchBar.barStyle = .black
    }
    


}

extension FindViewController: UICollectionViewDelegate, UICollectionViewDataSource {
        
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Search", for: indexPath) as! SearchCollectionViewCell
        
        return cell
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
}


extension FindViewController: UISearchBarDelegate  {
    
}
