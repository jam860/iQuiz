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

protocol PopoverDelegate: AnyObject {
    func checkNowPress()
    func alertInvalid()
}

class SettingsController: UIViewController {
    
    @IBOutlet weak var urlInput: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    weak var delegate: PopoverDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorMessage.text = "";
        
    }
    
    
    @IBAction func checkNowTap(_ sender: Any) {
        let url = URL(string: urlInput.text!)
        if url == nil {
         print("URL is Empty.")
            errorMessage.text = "Invalid URL. Please try again."
            self.dismiss(animated: true, completion: self.delegate?.alertInvalid)
//            
//            let alert = UIAlertController(title: "Error", message: "Invalid URL. Please try again.", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
         return
        }
        (URLSession.shared.dataTask(with: url!) {
            data, response, error in
                if error == nil {
//                    print(response!.description)
                    if data == nil {
                        print("no data")
                        self.errorMessage.text = "No data found at this URL."
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        do {
                            print("getting data...")
                            let quizzes = try JSONDecoder().decode([Quiz].self, from: data!)
                            DispatchQueue.main.async {
                                Quizzes.quizzes = quizzes;
                                self.delegate?.checkNowPress()
                                self.errorMessage.text = "Data has been set."
                                self.dismiss(animated: true, completion: nil)
                            }
                        } catch {
                            self.errorMessage.text = "Something happened while trying to parse the JSON."
                        }
                    }
                } else {
                    DispatchQueue.main.async {
//                        print(error!)
//                        print(error!.localizedDescription)
                        self.dismiss(animated: true, completion: nil)
                        let alert = UIAlertController(title: "Error", message: "There was a network issue. Please try again.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        self.errorMessage.text = "There was a network issue. Please try again."
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
