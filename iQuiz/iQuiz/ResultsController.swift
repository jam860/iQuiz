//
//  MathResultsController.swift
//  iQuiz
//
//  Created by James Nguyen on 5/10/25.
//

import UIKit

class ResultsController: UIViewController {
    var totalQuestions : Int = 0;
    var answersCorrect : Int = 0;

    @IBOutlet weak var scoreResultsLabel: UILabel!
    @IBOutlet weak var performanceLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        if answersCorrect == totalQuestions {
            performanceLabel.text = "Perfect! You got everything correct."
        } else if answersCorrect == 0 {
            performanceLabel.text = "Better luck next time. You got nothing correct. :("
        } else {
            performanceLabel.text = "You did well! You got some questions correct."
        }
        scoreResultsLabel.text = "You got \(answersCorrect) out of \(totalQuestions) correct."

        // Do any additional setup after loading the view.
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
