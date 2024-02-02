//
//  WalkThroughViewController.swift
//  SeSAC4Seflix
//
//  Created by 박지은 on 2/2/24.
//

import UIKit



class FirstViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ???: 색상을 안넣으면 화면전환이 안된다 ?
        view.backgroundColor = .lightGray
    }
}


class SecondViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
    }
}

class ThirdViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
    }
}




class WalkThroughViewController: UIPageViewController {

    
    
    var pageViewControllerList: [UIViewController] = []
//    var pageViewControllerList: [UIViewController] = [FirstViewController(), ] // 이렇게 만들면 안되나요? -> 인스턴스 만드는게 힘드니까 구분해서 만들쟝~
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .magenta
        createPageViewController()
        configurePageViewController()
        
    }
    
    
    // 뷰컨트롤러 배열 메서드
    func createPageViewController() {
        let vc1 = FirstViewController()
        let vc2 = SecondViewController()
        let vc3 = ThirdViewController()
        
        pageViewControllerList = [vc1, vc2, vc3]
    }
    
    // pageViewControllerList를
    func configurePageViewController() {
        delegate = self
        dataSource = self
        // 자기 자신을 연결해주는거라 앞에 안써도 된다
        
        // Dispaly -> 몇번째 페이지인지 구성하는 것
        // ???: guard let first = pageViewControllerList[0] 이렇게 불러도 똑같긴한데, pageViewControllerList가 빈배열일때, 앱이 꺼진대
        guard let first = pageViewControllerList.first else { return }
        // ???: [first] 왜 배열인지 ?
        setViewControllers([first], direction: .forward, animated: true)
        
        
    }
    
    
}



extension WalkThroughViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    // 이전 화면에 대한 구성
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        // 현재 페이지뷰컨에 보이는 뷰컨의 인덱스 가지고 오기
        guard let currentIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = currentIndex - 1
        
        // 첫번째 화면에서 -1을 하면 보여줄화면이 없으니까 0보다 작으면의 조건을 추가해준다
        return previousIndex < 0 ? nil : pageViewControllerList[previousIndex]
    }
    
    // 다음 화면에 대한 구성
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        // ???:
        guard let currentIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = currentIndex + 1
        
        // 첫번째 화면에서 -1을 하면 보여줄화면이 없으니까 0보다 작으면의 조건을 추가해준다
        return nextIndex >= pageViewControllerList.count ? nil : pageViewControllerList[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pageViewControllerList.count
    }
    
    // 아래 쩜쩜쩜 활성화해주는 기능
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let first = viewControllers?.first,
              let index = pageViewControllerList.firstIndex(of: first) else {
            return 0
        }
        return index
    }
}
