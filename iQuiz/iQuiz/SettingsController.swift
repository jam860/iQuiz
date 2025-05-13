//
//  SettingsController.swift
//  iQuiz
//
//  Created by James Nguyen on 5/13/25.
//

import UIKit


//struct Quiz: Codable {
//    let title: String
//    let desc: String
//    let img : String?
//    let questions: [Question] //question already defined
//}

//struct Question: Codable {
//    let text : String
//    let answer : Int
//    let answers : [String]
//}

class SettingsController: UIViewController {
    
    var addressField = "http://tednewardsandbox.site44.com/questions.json";
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://tednewardsandbox.site44.com/questions.json")
            if url == nil {
              print("Bad address")
              return
            }
        
        (URLSession.shared.dataTask(with: url!) {
            data, response, error in
            
            DispatchQueue.global().async {
                if error == nil {
//                    print(response!.description)
                    if data == nil {
                        print("no data")
                    } else {
                        do {
                            print("getting data...")
                            let newObject = try JSONSerialization.jsonObject(with: data!)
                            let quizzes = try JSONDecoder().decode([Quiz].self, from: data!)
//                            let jsonData = try JSONSerialization.data(withJSONObject: newObject)
//                            let newDataString = String(data: jsonData, encoding: .utf8)
                            DispatchQueue.main.async {
                                print("this is the data")
                                Quizzes.quizzes = quizzes;
                            }
                        } catch {
                            print("something happened while serializing data.. :(")
                            print(error)
                        }
                        
                    }
                } else {
                    DispatchQueue.main.async {
                        print(error!)
                        print(error!.localizedDescription)
                    }
                }
            }
        }).resume()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
