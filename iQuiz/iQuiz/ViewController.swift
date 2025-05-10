//
//  ViewController.swift
//  iQuiz
//
//  Created by James Nguyen on 5/4/25.
//
// app branch

import UIKit

struct Topic {
    let title : String
    let description : String
    let img : UIImage
}

class ViewController: UIViewController {
    

    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var setting: UIBarButtonItem!
    
    let topics : [Topic] = [
        Topic(title: "Mathematics", description: "Math questions, ready to do calculus?", img: UIImage(named: "math")!),
        Topic(title: "Marvel Super Heroes", description: "Your favorite superheroes!", img: UIImage(named: "venom")!),
        Topic(title: "Science", description: "Science questions, volcano goes boom!", img: UIImage(named: "science")!)
    ]
    
    @IBAction func settingsTap(_ sender: Any) {
        print("yay works")
        let alert = UIAlertController(title: "Settings", message: "Settings goes here", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: {
            print("it's been completed")
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
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


extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let labelText = cell.textLabel?.text ?? "No text"
            print("Tapped \(labelText)")
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Quiz Topics"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = topics[indexPath.row].title
        cell.textLabel?.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        cell.detailTextLabel?.text = topics[indexPath.row].description
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
//        let resizedImage = topics[indexPath.row].img.resize(to: CGSize(width: 80, height: 80))
        let resizedImage = topics[indexPath.row].img.imageWith(newSize: CGSize(width: 80, height: 80))
        cell.imageView?.image = resizedImage

//        cell.imageView?.image = topics[indexPath.row].img
        return cell
    }
    
}
