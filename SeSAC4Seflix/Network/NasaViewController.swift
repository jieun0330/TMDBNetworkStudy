//
//  NasaViewController.swift
//  SeSAC4Seflix
//
//  Created by 박지은 on 2/6/24.
//

import UIKit
import SnapKit

enum ValidationError: Error {
    case emptyString
    case isNotInt
    case isNotDate
}

// completionhandler는 100% 다 다운로드 받아진 후에 이미지가 보여지는거라
// 이렇게 중간에 얼만큼 다운받았고하는 것들은 -> completionHandler는 못함, delegate!

class NasaViewController: UIViewController {
        
    // 뷰가 있어야 얼마나 진행됐는지 보여줄 수 있겠죠 ?
    let nasaImageView = UIImageView()
    let resultLabel = UILabel()
    
    let tempTextField = UITextField()
    
    // 이미지를 다운받는 도중에 앱을 꺼버릴 때 ? -> 사진을 계속 다운받을지, 중단할지 ?
    // 화면 전환을 했거나, 앱을 종료했거나 등 뷰가 사라지는 시점에 네트워크 통신에 관련된 리소스 정리
    // ex. 카톡 이미지 다운받다가 다른 톡방을 킨다면 ? 기획에 따라서 내용을 다르게 구현해주어야 한다
    var session: URLSession!
    
    // 이미지 다운을 prgress로 표현해준다면?
    var buffer: Data? {
        didSet {
            
            let result = Double(buffer?.count ?? 0) / total
            resultLabel.text = "\(result * 100)%"
        }
    }
    
    var total: Double = 0 // 이미지 총 크기
    
    // 하나하나의 byte 숫자를 누적해놓을 공간ㅇ ㅣ필요
    // 이미지를 나눠서 받게 된다면, 이를 모두 append!
    
    @objc func tempTextFieldReturnTapped() {
        
        // 텍스트필드에 사용자가 입력하는 값이: 20220101 같은 날짜 형식이어야 한다면
        // 1. 빈칸은 아닌지 ?
        // 2. 글자 수가 8글자인지 ?
        // 3. 숫자로 변환이 되는 지 ?
        // 4. 날짜 형식으로 변환이 되는 지 ?
        // 5. 오늘 날짜는 아닌 지 ?
        
        
        guard let text = tempTextField.text else { return }
        
        do {
            let result = try validateUserInputError(text: text)
            print("\(result)")
        } catch {
            switch error {
            case ValidationError.emptyString:
                print("빈값입니다")
            case ValidationError.isNotInt:
                print("숫자가 아닙니다")
            case ValidationError.isNotDate:
                print("날짜 형식이 아닙니다")
            default:
                print("알 수 없는 오류입니다 ")
            }
        }
        
//        if validateUserInputError(text: text) {
//            print("유효성 통과! 잘 입력했음")
//        } else {
//            print("잘 못 입력 해 ㅆ 음")
//        }
        
//        if text.isEmpty {
//            print("빈 값")
//        } else if Int(text) == nil {
//            print("숫자로 변환이 안됨")
//        }
    }
    
    //
    func validateUserInputError(text: String) throws -> Bool { // 여러가지 케이스로 인해 throws 될 수 있다
        guard !(text.isEmpty) else {
            print("빈 값")
            throw ValidationError.emptyString // 에러면 그냥 던져벌여
//            return false
        }
        
        guard Int(text) != nil else {
            print("숫자 아님")
            throw ValidationError.isNotInt
//            return false
        }
        
        return true
    }
    
//    var nickname: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
//        if let nickname = nickname {
//            view.backgroundColor = .red
//        }
        
        // 옵셔널 buffer를 빈 공간으로 임의로 만드러준다
        buffer = Data()
        
        view.backgroundColor = .lightGray
        view.addSubview(nasaImageView)
        view.addSubview(resultLabel)
        view.addSubview(tempTextField)
        
        tempTextField.backgroundColor = .white
        tempTextField.addTarget(self, action: #selector(tempTextFieldReturnTapped), for: .editingDidEndOnExit)
        
        tempTextField.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(100)
        }
        
        nasaImageView.snp.makeConstraints {
            $0.center.equalTo(view)
            $0.size.equalTo(200)
        }
        resultLabel.backgroundColor = .white
        nasaImageView.backgroundColor = .brown
        
//        request()

    }
    
    // 화면이 사라질려고 할 때
    override func viewWillDisappear(_ animated: Bool) {
        
        // 다운받고있는 이미지를 무시하고 싶을 ㄸ ㅐ
        //  화면이 사라진다면 네트워크 통신도 함께 중단
        // 실행중인(다운로드 중인)리소스도 무시
        session.invalidateAndCancel()
        
        // 비슷한 기능
        // 다운로드 될 때 까지 기다렸ㄷ가ㅏ, 끝나면 정리하기
        // 40mb 인데 39.8까지 다운받았는데 그냥 끝내버리면 아깝잖아여 ? -> background에서 실행할게 더 필요할텐데
        // 이러한 기능이 있다고만~ 알고있으면 돼여
        session.finishTasksAndInvalidate()
        
        
    }
    
    
    

    func request() {
//        let url = URL(string: TMDBAPI.trending.endpoint) // 이렇게 안쓰는 이유 확인
//        var url = URLRequest(url: TMDBAPI.trending.endpoint)
//        url.addValue(APIKey.tmdb, forHTTPHeaderField: "Authorization")
        
        let url = URL(string: "https://apod.nasa.gov/apod/image/2402/Carina_Taylor_9714.jpg")!
        
        // completionHandler -> delegate
        // shared는 간략한 친구, 세부적인 내용을 쓰기 어렵다 ? -> delegate를 쓰기 어렵다! -> default
        
        
        
        session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        session.dataTask(with: url).resume()

        
//        URLSession(configuration: .default, delegate: self, delegateQueue: .main).dataTask(with: url).resume()
        
//        URLSession.shared.dataTask(with: url).resume()
        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            
//            print(data)
//            print(response)
//            print(error)
//            
//            // data, response, error nil 여부에 관한 코드
//            // if let, guard let -> 취향 차이, 갈려고 하는 목적지는 동일하다
//            
//            if let error = error {
//                print("오류 발생")
//                return // guard문이 아니더라도 return을 쓸 수 있따!? 여기서 멈추냐 안멈추느냐 ?
//            }
//            
//            // TMDBSessionManager guard문 2개를 1개로 연결한걸로 보면 된다
//            
//            
//            
////            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
////                print("상태코드 오류")
////                // response.status코드가 이 안에서 실행되지 않는 이유를 이해해야 한다
////                print((response as? HTTPURLResponse)?.statusCode) // 쉬운 방법 2️⃣ -> response를 또 개별적으로 타입 캐스팅 해서 statusCode에 접근해야만 동작하는 이유를 이해해야 한다
////                // return만 쓰고 위에 어떤 상태인지 쓰지 않으면 어디서 return 했는지 알 수가 없음!
////                // response.statusCode가 이 부분에서 동작하지 않는 이유 ⬇️
////                return
////            }
////            
////            print(response.statusCode) // response.statusCode는 guard문 안에서 쓸 수 없다, 옵셔널 바인딩을 한 후 밖에서 확인할 수 있다!!!!
//            
//            
//            
//            
//            
//            // 이게 왜 안나와 ? 이유는 -> 위에 return 을 써버려서 위에서 끝난거임
//            // 그럼 return을 주석한다? -> nope! guard문 특성상 return을 주석할 순 없음,, -> guard 구문에서 return을 생략하면 오류 나는 이유를 이해해야 한다
//            // 그냥 제일 쉬운 방법? -> 1️⃣ if let으로 바꾼다
//            
//            
//            // TMDBSessionManager data 구문과 do try catch 구문 2개도 -> 1개로 연결할 수 있다
//            // try? vs try! vs do try catch
//            // try? -> try! 로 바꾼다면 ?
//            // data가 문제인지, decoding이 문제인지 알 수가 없다 -> do try catch를 사용해야 알 수 있다 ?
//            
//            // 디버깅 할 수 있는 코드에 속한다 ?
////            if let data = data {
////                do {
////                    let result = try JSONDecoder().decode(TrendingModel.self, from: data)
////                    print(result)
////                } catch {
////                    print(error)
////                }
////            } else {
////                print("optional binding failed")
////            }
////            
////            
////            
////            if let data = data, let result = try? JSONDecoder().decode(TrendingModel.self, from: data) {
////                dump(result)
////                print("result")
////                return
////            }
////            print("end")
//            
//            
//            
//            // 이런 프린트문을 써줘야 어디서 잘못된건지 알 수 가 있다 !
//            
//        }.resume()
    }

}

// ⬆️ 위에 dataTask 이름이랑 똑같은거 쓰면 됨!
extension NasaViewController: URLSessionDataDelegate {
    
    // 서버에서 최초로 응답받은 경우에 호출 (ex. 상태코드)
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        
        print("didReceive")

        
        // 직접 구현할 일은 거의 없으니까 흐름만 알면 돼요!
        if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) {
            
            // contentLength -> 파일 크기
            let contentLength = response.value(forHTTPHeaderField: "Content-Length")!
            total = Double(contentLength)!
            
            
            
            return .allow
        } else {
            return .cancel
        }

        
    }
    
    // 서버에서 데이터를 받을 때마다 반복적으로 호출됨
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print("DIDRECEIVE: \(data)")
        
        buffer?.append(data)
        
        
        // 마쟈 아까 buffer 찍어봤을때 nil이였어~~~~~~~~~~~~~
    }
    
    
    // 응답이 완료될 때 호출됨
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            print("오류 발생: \(error)")
        } else {
            print("성공") // completionHandler 시점
            
            guard let buffer = buffer else {
                print("Buffer nil") // ⭐️return에는 항상
                return
            }
            let image = UIImage(data: buffer)
            nasaImageView.image = image
            
        }
    }
    
    
}
