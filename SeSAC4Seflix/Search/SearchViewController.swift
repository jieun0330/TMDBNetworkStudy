//
//  SearchViewController.swift
//  SeSAC4Seflix
//
//  Created by 박지은 on 1/29/24.
//

import UIKit
import SnapKit
import Kingfisher

class SearchViewController: UIViewController {
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    let tableView = UITableView()
    
    var list: [Movie] = [] // 상단 컬렉션에서 사용할 데이터
    var titleList: [String] = ["어벤져스 포스터", "해리포터 포스터", "엑스맨 포스터", "스파이더맨 포스터"] // 테이블뷰의 타이틀 레이블
    
    
    // 46705, 157336, 11036
    // 1. ImageList -> TableView -> CollectionView
    // 2. 네트워크 요청 -> 응답 -> ImageList -> reload
    
    var imageList: [PosterModel] = [
        PosterModel(posters: []),
        PosterModel(posters: []),
        PosterModel(posters: []),
        PosterModel(posters: [])
    ]
    
    
    // configureCollectionViewLayout 얘가 만들어지고 -> collectionView 얘가 만들어져야되는데
    // 똑같이 일어나고있으니까
    // 저장 프로퍼티를 지연시켜준다
    // 1. lazy var로 collectionview로 만들어지면 오류가 해결이된다
    
    // 2. 인스턴스 시점이랑 상관없이 static으로 만들어준다

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierachy()
        configureConstraints()
        configureView()
        
        TMDBAPIManager.shared.fetchTrendingMovie { movie in
            self.list = movie
            self.collectionView.reloadData()
            // collectionView가 tableView 안에 있죠?
            self.tableView.reloadData()
        }
        
        TMDBAPIManager.shared.fetchMovieImages(id: 46705) {
            poster in
            
            self.imageList[0] = poster
            self.tableView.reloadData()
        }
        
        TMDBAPIManager.shared.fetchMovieImages(id: 157336) {
            poster in
            
            self.imageList[1] = poster
            self.tableView.reloadData()
        }
        
        TMDBAPIManager.shared.fetchMovieImages(id: 11036) {
            poster in
            
            self.imageList[2] = poster
            self.tableView.reloadData()
        }
        
        TMDBAPIManager.shared.fetchMovieImages(id: 46705) {
            poster in
            
            self.imageList[3] = poster
            self.tableView.reloadData()
        }
    }
    
    func configureHierachy() {
        view.addSubview(collectionView)
        view.addSubview(tableView)
    }
    
    func configureConstraints() {
        collectionView.snp.makeConstraints {
            $0.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(200)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    func configureView() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "Search")
        collectionView.backgroundColor = .brown
        // 셀 하나하나를 페이지로 인식하고 멈추는 기능을 가지고있다
        // 셀 사이즈랑 상관없이 디바이스 너비만큼 움직임 -> 아래 layout spacing을 무시해버린다 -> 사이 간격을 다 없애버리면 스크롤은 정상범위 내에서 작동한다
        collectionView.isPagingEnabled = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 200
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "SearchTableViewCell")

    }
    

    
    
    static func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 200)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        
        
        return layout
    }
}

// 프로토콜로 부른다
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // 매개변수랑 이름이 똑같잖아요? 그럼 내가 부르는 저기 저 위에 있는 collectionView를찾을 때 self 를 붙여요, 왜냐면 가까운애 ㅇ를 찾아버리거든
        if self.collectionView == collectionView {
            return list.count
        }
        else {
            // 리스트를 공유하기 때문에
            return imageList[collectionView.tag].posters.count
        }
        
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Search", for: indexPath) as! SearchCollectionViewCell
        
        if self.collectionView == collectionView {
            let item = list[indexPath.item]
            let url = URL(string: "https://image.tmdb.org/t/p/w500/\(item.backdrop)")
            
            cell.posterImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "star.fill"))
            cell.titleLabel.text = item.title
        } else {
            // 여기 조올라 어렵네
            let item = imageList[collectionView.tag].posters[indexPath.item]
            
            let url = URL(string: "https://image.tmdb.org/t/p/w500/\(item.file_path)")
            
            cell.posterImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "star.fill"))
            cell.titleLabel.text = "임시!"
        }
        
        
        
        return cell
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "Search")
        cell.collectionView.tag = indexPath.row
        cell.collectionView.reloadData()
        cell.titleLabel.text = titleList[indexPath.row]
        
        
        return cell
    }
}
