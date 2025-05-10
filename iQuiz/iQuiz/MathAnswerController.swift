//
//  MathAnswerController.swift
//  iQuiz
//
//  Created by James Nguyen on 5/10/25.
//

import UIKit

class MathAnswerController: UIViewController {
    
    var answerResult : Bool = false
    var selectedAnswer : String = ""
    var correctAnswer : String = ""
    var question : String = ""
    var topicFinished : Bool = false;
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var correctAnswerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = "Question: \n\(question)"
        correctAnswerLabel.text = "The correct answer was:  \n\(correctAnswer)"
        if answerResult == false {
            resultLabel.text = "Your answer was incorrect."
        } else if answerResult == true {
            resultLabel.text = "Your answer was correct."
        }
    }
    

    @IBAction func nextBtn(_ sender: Any) {
        if topicFinished {
            print("yay")
        } else if !topicFinished {
//            performSegue(withIdentifier: "backToMath", sender: nil)
            navigationController?.popViewController(animated: true)

        }
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
