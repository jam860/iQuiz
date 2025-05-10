//
//  ViewController2.swift
//  iQuiz
//
//  Created by James Nguyen on 5/9/25.
//

import UIKit

class MathQuestionController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var mathQuestion: UILabel!
    var topic : Topic?
    var currQuestion : Int = 0;
    var selectedAnswer : String = "";
    @IBOutlet weak var mathTableView: UITableView!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(topic ?? "");
        mathTableView.delegate = self;
        mathTableView.dataSource = self;
        mathQuestion.text = topic?.questions[currQuestion].text;
        submitButton.isEnabled = false;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(currQuestion)
        mathTableView.reloadData();
        mathQuestion.text = topic?.questions[currQuestion].text;
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "mathCell", for: indexPath)
        cell.textLabel?.text = topic?.questions[currQuestion].answers[indexPath.row]
        return cell;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mathAnswer" {
            if let destination = segue.destination as? MathAnswerController {
                if let sender = sender as? (answerResult : Bool, correctAnswer : String, selectedAnswer : String, question : String, topicFinished : Bool) {
                    destination.answerResult = sender.answerResult;
                    destination.correctAnswer = sender.correctAnswer;
                    destination.selectedAnswer = sender.selectedAnswer
                    destination.question = sender.question
                    destination.topicFinished = sender.topicFinished
                }
            }
        }
        
    }
    
    
    @IBAction func submitBtn(_ sender: Any?) {
        let answerIndex = (topic?.questions[currQuestion].answerIndex ?? 1) - 1
        let answer : String = topic?.questions[currQuestion].answers[answerIndex] ?? ""
        performSegue(withIdentifier: "mathAnswer", sender: (answerResult: selectedAnswer == answer, correctAnswer: answer, selectedAnswer: selectedAnswer, question: topic?.questions[currQuestion].text, topicFinished: currQuestion + 1 >= topic?.questions.count ?? 1))
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
