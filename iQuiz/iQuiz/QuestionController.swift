//
//  ViewController2.swift
//  iQuiz
//
//  Created by James Nguyen on 5/9/25.
//

import UIKit

class QuestionController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var topic : Topic?
    var currQuestion : Int = 0;
    var selectedAnswer : String = "";
    var answersCorrect : Int = 0;
    @IBOutlet weak var topicTitleLabel: UILabel!
    @IBOutlet weak var questionTitleLabel: UILabel!
    @IBOutlet weak var questionTableView: UITableView!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionTableView.delegate = self;
        questionTableView.dataSource = self;
        questionTitleLabel.text = topic?.questions[currQuestion].text;
        topicTitleLabel.text = "\(topic?.title ?? "")"
        submitButton.isEnabled = false;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        questionTableView.reloadData();
        questionTitleLabel.text = topic?.questions[currQuestion].text;
        submitButton.isEnabled = false;
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topic?.questions[currQuestion].answers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            submitButton.isEnabled = true;
            selectedAnswer = cell.textLabel!.text ?? "";
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "answerCell", for: indexPath)
        cell.textLabel?.text = topic?.questions[currQuestion].answers[indexPath.row]
        return cell;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAnswer" {
            if let destination = segue.destination as? AnswerController {
                if let sender = sender as? (answerResult : Bool, correctAnswer : String, selectedAnswer : String, question : String, topicFinished : Bool, totalQuestions : Int, answersCorrect : Int) {
                    destination.answerResult = sender.answerResult;
                    destination.correctAnswer = sender.correctAnswer;
                    destination.selectedAnswer = sender.selectedAnswer
                    destination.question = sender.question
                    destination.topicFinished = sender.topicFinished
                    destination.totalQuestions = sender.totalQuestions
                    destination.answersCorrect = sender.answersCorrect
                }
            }
        }
        
    }
    
    
    @IBAction func submitBtn(_ sender: Any?) {
        let answerIndex = (topic?.questions[currQuestion].answerIndex ?? 1) - 1
        let answer : String = topic?.questions[currQuestion].answers[answerIndex] ?? ""
        if selectedAnswer == answer {
            answersCorrect += 1;
        }
        performSegue(withIdentifier: "toAnswer", sender: (answerResult: selectedAnswer == answer, correctAnswer: answer, selectedAnswer: selectedAnswer, question: topic?.questions[currQuestion].text, topicFinished: currQuestion + 1 >= topic?.questions.count ?? 1, totalQuestions: topic?.questions.count, answersCorrect: answersCorrect))
        currQuestion += 1
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
