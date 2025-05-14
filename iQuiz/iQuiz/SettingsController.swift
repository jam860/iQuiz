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
    
    @IBOutlet weak var urlInput: UITextField!
    var addressField = "http://tednewardsandbox.site44.com/questions.json";
    
    
    @IBOutlet weak var errorMessage: UILabel!
    @IBAction func checkNowTap(_ sender: Any) {
        
        let url = URL(string: urlInput.text!)
        if url == nil {
         print("URL is Empty.")
         print(urlInput.text!)
         errorMessage.text = "URL is Empty."
         return
        }
        (URLSession.shared.dataTask(with: url!) {
            data, response, error in
                if error == nil {
//                    print(response!.description)
                    if data == nil {
                        print("no data")
                        self.errorMessage.text = "No data found at this URL."
                    } else {
                        do {
                            print("getting data...")
                            let quizzes = try JSONDecoder().decode([Quiz].self, from: data!)
                            DispatchQueue.main.async {
                                Quizzes.quizzes = quizzes;
                                self.errorMessage.text = "Data has been set."
                            }
                        } catch {
                            self.errorMessage.text = "Something happened while trying to parse the JSON."
                        }
                    }
                } else {
                    DispatchQueue.main.async {
//                        print(error!)
//                        print(error!.localizedDescription)
                        let alert = UIAlertController(title: "Error", message: "There was a network issue. Please try again.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        self.errorMessage.text = "There was a network issue. Please try again."
                    }
                }
        }).resume()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        errorMessage.text = "";
        
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
