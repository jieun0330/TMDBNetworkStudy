//
//  FindViewController.swift
//  SeSAC4Seflix
//
//  Created by 박지은 on 1/31/24.
//

import UIKit
import SnapKit
import Kingfisher

class FindViewController: UIViewController {
    
    let mainView = FindView() // !!!: 이걸 보고 메인뷰가 findview구나 알 수가 있도록 만드는것
    
    var list: [Movie] = []
    
    override func loadView() {
        self.view = mainView
        //        self.view = FindView() // !!!: 이렇게 호출해도 되긴 하지만, 안에 있는 속성들에 접근을 할 수가 없다
    }
    
    //    lazy var bar = makeSearchBar() // 오류가 나는 이유는 ? 아래 메서드랑 실행하는 시점이 완전히 똑같은데 어떻게 넣어줌?
    // -> 그래서 lazy를 붙여준다
    
    // 매개변수도 없고 반환값도 없는걸 함수에 담긔?
    //    func makeSearchBar() -> UISearchBar {
    //        let view = UISearchBar()
    //        view.placeholder = "sdfsdf"
    //        return view
    //    }
    // 그래서 함수를 그냥 넣어버려
    
    //    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        view.delegate = self // self 자체가 findviewcontroller 인스턴스인데, 이 클로저 구문이 인스턴스 생성 전에 이걸 해버리니까 -> lazy var을 통해 나중에 생성이 되는거임
        //        view.delegate = self
        mainView.searchBar.delegate = self
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        print("1", Thread.isMainThread)
        
        
        TMDBSessionManager.shared.fetchTrendingMovie { movie, error in
            
            print("2", Thread.isMainThread)
            
            if error == nil  { // 네트워크 통신이 성공했다는 의미
                guard let movie = movie else { return }
                

                
                self.list = movie.results
                self.mainView.collectionView.reloadData()
                // ❓❓❓❓❓❓ 메인이 해야할일을 뷰컨이 아니라 manager 안에 ㅇ넣어놓는다
//                DispatchQueue.main.async {
//                    self.mainView.collectionView.reloadData()
//                }
                
                
            } else {
                // error 분기 처리, alert, toast message를 띄울거임 -> main에서 띄워줘야 함
                switch error! { // SeSACError가 옵셔널이여서 error! 우선 강제 언랩핑 해놓긴 함
                    
                case SeSACError.failedRequest: print("")
                default: print("")
                }
                
                
                var nickname: String? = "고래밥"
//                var nickname: Optional<String> = "고래밥" // 위에랑 똑같져?
                var list: [String] = ["1", "2"]
//                var list: Array<String> = ["1", "2"] // 위에랑 똑같져? -> 제네릭
                
                switch error {
//                    옵셔널은 열거형이다!? 
//                    옵셔널 케이스는 두케이스로 나뉘어져있따
                    
                    // error가 옵셔널이여서 우선 error 자체를 옵셔널인지 아닌지를 확인하기 위해 이 두가지 구문이 나옴
                case .none:
                    <#code#>
                case .some(let value):
                    switch value  {
                        
                    case .failedRequest:
                        <#code#>
                    case .noData:
                        <#code#>
                    case .invalidResponse:
                        <#code#>
                    case .invalidData:
                        <#code#>
                    }
                }
                
            }
        }
        
    }
}



extension FindViewController: UISearchBarDelegate  {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
//        TMDBAPIManager.shared.fetchMovie(api: .search(query: searchBar.text!)) { movie in
//            self.list = movie
//            self.mainView.collectionView.reloadData()
//        }
        
//        TMDBAPIManager.shared.searchMovie(api: <#TMDBAPI#>, query: searchBar.text!) { movie in
//            self.list = movie
//            self.mainView.collectionView.reloadData()
//        }
    }
}


extension FindViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Search", for: indexPath) as! SearchCollectionViewCell
        
        let item = list[indexPath.item]
        
        
        // item.poster가 nil 인지 아닌지에 따라
        if let poster = item.poster {
            let url = URL(string: "https://image.tmdb.org/t/p/w500/\(poster)")
            cell.posterImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "star.fill"))
            

        } else {
            cell.posterImageView.image = UIImage(systemName: "pencil")
        }
        
        
        
        cell.titleLabel.text = item.title
        
        return cell
    }
}
