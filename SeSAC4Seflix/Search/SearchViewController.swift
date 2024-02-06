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
    
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self // self가 될 수 없으니 lazy?
        view.dataSource = self
        view.rowHeight = 200
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: "SearchTableViewCell")
        return view
    }()
    
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
        
        view.backgroundColor = .white
        configureHierarchy()
        configureConstraints()
        configureView()
        
        // 1. 갱신이 생각보다 과도하다 -> 네트워크 통신 응답을 다 받고 -> 갱신을 한번만 할 수 있도록
        // 2. 반복문을 사용하고싶다
        
        
        // 디스패치그룹은 마지막에 작업하고 알려주는 친구인데
        // 동기냐 비동기냐 에 따라서 작성되는 코드가 다르다?
        // 설명할 수 있어야 함
        
        
        
        
        // ARC가 뭐야
        let group = DispatchGroup() // +1 이라는 숫자를 갖게됨?
        
        //        DispatchQueue.global().async(group: group) {
        // fetchTrending -> Alamofire -> 비동기 안에 비동기
        // 알바생이 또 다른 알바생을 품고있는거임
        
        group.enter() // 나 들어갈게? // +1 // 체크리스트라고 생각하면 됨 // 이거 해야됨 // 나 이거 할게~?
        
        TMDBAPIManager.shared.fetchMovie(api: .trending) { movie, error in
            // movie와 error가 둘다 옵셔널이니까 그거 먼저 해결해주자
                
                // movie 0, error == nil
                // 오류 없음 -> 네트워크 통신이 성공했을 것
                // movie == nil, error 0
                // 오류 있음 -> 네트워크 통신이 실패했을 것
            
            guard let error = error else {
                return
            }
            guard let movie = movie else {
                return
            }
            
//            if let error == error {
//                // 문제가 있는 상황
//                // toast로 네트워크 통신에 문제가 있음을 알린다
//            } else {
//                guard let movie = movie else { return }
//                // 그게 아니라면 movie에 값이 있을테니까
//                self.list = movie
//                // movie에 대한 처리를 담아줘서 처리한다
//            }
            
            // 👩🏻‍🏫 네트워크 통신이 느리거나, 실패했을 경우, 모든 케이스를 잘 처리하고 있는지에 대한 질문이 많다, 네트워크 성공은 그냥 성공이니까
            
            group.leave()
 
        }

//        
//        TMDBAPIManager.shared.fetchMovie(api: .trending) { movie in
//            self.list = movie
//            group.leave() // -1 // 끝냄 // 알바생한테 다 했다고 알려주는거임<#code#>
//        }
        
        // 🚨 네트워크 통신이 안됐을 때는 leave가 호출되지않고 notify가 호출되지않아서 작업이 영ㅇ영 끝나지않는다
        
        
//        TMDBAPIManager.shared.fetchTrendingMovie { movie in
//            self.list = movie
//            group.leave() // -1 // 끝냄 // 알바생한테 다 했다고 알려주는거임
//        }
        //        }
        
        
        
        
        //        DispatchQueue.global().async(group: group) {
        group.enter()
        
        TMDBAPIManager.shared.fetchMovieImages(api: .photo(id: 157336)) { poster in
            self.imageList[0] = poster
            group.leave()
        }
        
        
//        TMDBAPIManager.shared.fetchMovieImages(id: 157336) { poster in
//            self.imageList[1] = poster
//            group.leave()
//        }
        //        }
    
        //        DispatchQueue.global().async(group: group) {
        group.enter()
        
        TMDBAPIManager.shared.fetchMovieImages(api: .photo(id: 11036)) { poster in
            self.imageList[1] = poster
            group.leave()
        }
        
//        TMDBAPIManager.shared.fetchMovieImages(id: 11036) { poster in
//            self.imageList[2] = poster
//            group.leave()
//        }
        //        }
        
        //        DispatchQueue.global().async(group: group) {
        group.enter()
        TMDBAPIManager.shared.fetchMovieImages(api: .photo(id: 46705)) { poster in
            self.imageList[2] = poster
            group.leave()
        }
        
        
//        TMDBAPIManager.shared.fetchMovieImages(id: 46705) { poster in
//            self.imageList[3] = poster
//            group.leave()
//        }
        //        }
        
        group.notify(queue: .main) {
            // collectionView가 tableView 안에 있죠?
            self.tableView.reloadData()
            self.collectionView.reloadData()
        }
    }
    
    func configureHierarchy() {
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Search", for: indexPath) as? SearchCollectionViewCell else {
            print("asdf")
            return UICollectionViewCell()
        }
        
        if self.collectionView == collectionView {
            let item = list[indexPath.item]
            let url = URL(string: "https://image.tmdb.org/t/p/w500/\(item.backdrop)")
            
            cell.posterImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "star.fill"))
            cell.titleLabel.text = item.title
        } else {
            // 여기 조올라 어렵네
            let item = imageList[collectionView.tag].posters[indexPath.item]
            
            let url = URL(string: "https://image.tmdb.org/t/p/w500/\(item.file_path)")
            print(item.file_path)
            
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
