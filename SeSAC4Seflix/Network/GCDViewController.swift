//
//  GCDViewController.swift
//  SeSAC4Seflix
//
//  Created by 박지은 on 1/31/24.
//

import UIKit

// global qos(quality of service)
// dispatchGroup
// notify: 동기 함수 -> 네트워크 통신과 같은 비동기 함수가 group에 묶이게 되면,
// 비동기 함수는 또 다른 알바생이 담당하기 때문에
// 또 다른 알바생의 일을 기다리지 않고 notify를 바로 띄우게 된다

// 그럼 어케요?
// enter / leave -> 짝꿍으로 보면 됨, 애플왈: enter와 Leave의 숫자는 동일해야 한다

class GCDViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let group = DispatchGroup()
        
        
        
        // 레퍼런스 카운트 ?
        DispatchQueue.global().async(group: group) {
            // 담당하고 있는 일이 동기로 진행 sync
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        
        // 백그라운드보다는 더 중요해보임?
        DispatchQueue.global().async(group: group) {
            for i in 201...300 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for i in 301...400 {
                print(i, terminator: " ")
            }
        }
        
        // 누가 마지막에 끝나도 상관없지만 끝남을 알려줄수있는 뭔가가 필요하다

        // 끝나면 노티해줘?
        // 끝나면 누구한테 넘겨줄까? queue: 닭벼슬 main
        group.notify(queue: .main) {
            print("4명 알바생 업무 끝났어요") // 뭐라고 넘겨줄까?
        }
        
        
        // 안에 역할이 동기냐 비동기냐가 달라도 Notify는 동일함
        

        

        

        

    }
    
    func callBack() {
        
        // 4명의 알바생이 각자 일을 하고 있는 상황
        // 각자 알아서 일을 시작하고 끝낼텐데
        // 누가 마지막에 끝날지 nobody knows

        // 다른 알바생을 쓰지만 시간이 줄어들지 않는다
        // 벗뜨 누가 마지막에 끝나는지는 명확하게 알고싶다
        // -> DispatchGroup
        
        
        DispatchQueue.global().async {
            for i in 1...100 {
                print(i, terminator: " ")
            }
            print("1번 알바생 끝")
            
            DispatchQueue.global().async {
                for i in 101...200 {
                    print(i, terminator: " ")
                }
                print("2번 알바생 끝")
                
                DispatchQueue.global().async {
                    for i in 201...300 {
                        print(i, terminator: " ")
                    }
                    print("3번 알바생 끝")
                    
                    DispatchQueue.global().async {
                        for i in 301...400 {
                            print(i, terminator: " ")
                        }
                        print("4번 알바생 끝")
                        print("끝!")

                    }
                }
            }
        }
    }

}
