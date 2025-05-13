//
//  ViewController.swift
//  iQuiz
//
//  Created by James Nguyen on 5/4/25.
//
// network branch

import UIKit

struct Quiz: Codable {
    let title : String
    let desc : String
//    let img : UIImage
    let img : String?
    let questions : [Question]
}

struct Question: Codable {
    let text : String
    let answer : String
    let answers : [String]
}

class Quizzes {
    static var quizzes : [Quiz] = [
        Quiz(title: "Mathematics", desc: "Math questions, ready to do calculus?", img: "math", questions: [Question(text: "What is 2+2?", answer: "1", answers: ["4", "22", "An irrational number", "Nobody knows"]), Question(text: "What is 4+4?", answer: "2", answers: ["42", "8", "kanji tatsumi", "ryuji sakamoto"])]),
        Quiz(title: "Marvel Super Heroes", desc: "Your favorite superheroes!", img: "venom", questions: [Question(text: "Who is Iron Man?", answer: "1", answers: ["Tony Stark", "Obadiah Stane", "A rock hit by Megadeth", "Nobody knows"])]),
        Quiz(title: "Science", desc: "Science questions, volcano goes boom!", img: "science", questions: [Question(text: "What is fire?", answer: "1", answers: ["One of the four classical elements", "A Magical reaction given to us by God", "A band that hasn't yet been discovered", "Fire! Fire! Fire! heh-heh"])])
    ];
    
//    static func getQuizzes() -> [Quiz] {
//        return quizzes
//    }
}

class MainController: UIViewController {
    

    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var setting: UIBarButtonItem!
    
//    var quizzes : [Quiz] = [
//        Quiz(title: "Mathematics", desc: "Math questions, ready to do calculus?", img: "math", questions: [Question(text: "What is 2+2?", answer: "1", answers: ["4", "22", "An irrational number", "Nobody knows"]), Question(text: "What is 4+4?", answer: "2", answers: ["42", "8", "kanji tatsumi", "ryuji sakamoto"])]),
//        Quiz(title: "Marvel Super Heroes", desc: "Your favorite superheroes!", img: "venom", questions: [Question(text: "Who is Iron Man?", answer: "1", answers: ["Tony Stark", "Obadiah Stane", "A rock hit by Megadeth", "Nobody knows"])]),
//        Quiz(title: "Science", desc: "Science questions, volcano goes boom!", img: "science", questions: [Question(text: "What is fire?", answer: "1", answers: ["One of the four classical elements", "A Magical reaction given to us by God", "A band that hasn't yet been discovered", "Fire! Fire! Fire! heh-heh"])])
//    ]
    
    var quizzes = Quizzes.quizzes
            
    @IBAction func settingsTap(_ sender: Any) {
        let alert = UIAlertController(title: "Settings", message: "Settings goes here", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(quizzes);
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        quizzes = Quizzes.quizzes
        tableView.reloadData();
        print("reloaded")
        print(quizzes)
    }
    
    @IBAction func unwindToMain(segue: UIStoryboardSegue) {
        //unwinds
    }

}

//https://stackoverflow.com/questions/2658738/the-simplest-way-to-resize-an-uiimage
extension UIImage {
    func imageWith(newSize: CGSize) -> UIImage {
            let image = UIGraphicsImageRenderer(size: newSize).image { _ in
                draw(in: CGRect(origin: .zero, size: newSize))
            }
            
            return image.withRenderingMode(renderingMode)
        }
}


extension MainController : UITableViewDataSource, UITableViewDelegate {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toQuestion" {
            if let destination = segue.destination as? QuestionController,
                let topic = sender as? Quiz {
                    destination.topic = topic
                }
            }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
//            let labelText = cell.textLabel?.text ?? "No text"
            performSegue(withIdentifier: "toQuestion", sender: quizzes[indexPath.row])
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quizzes.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Quiz Topics"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = quizzes[indexPath.row].title
        cell.textLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        cell.detailTextLabel?.text = quizzes[indexPath.row].desc
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
//        let resizedImage = topics[indexPath.row].img.resize(to: CGSize(width: 80, height: 80))
//        UIImage(named: "math")!
        if quizzes[indexPath.row].img == nil {
            let resizedImage = UIImage(named: quizzes[indexPath.row].title)!.imageWith(newSize: CGSize(width: 80, height: 80))
            cell.imageView?.image = resizedImage

        } else {
            let resizedImage = UIImage(named: quizzes[indexPath.row].img!)!.imageWith(newSize: CGSize(width: 80, height: 80))
            cell.imageView?.image = resizedImage
        }
       

//        cell.imageView?.image = topics[indexPath.row].img
        return cell
    }
    
}
