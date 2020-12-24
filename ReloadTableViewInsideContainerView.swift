//
//  ReloadTableViewInsideContainerView.swift
//  
//
//  Created by Ossama Abdelwahab on 24/12/20.
//

import Foundation
import Uikit

class HomeController: UIViewController {
 
    // Controller
    var lessonController: LessonController!
    
    // Your Array To Send
    var lessons: [Lesson] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func reloadTableViewInContainer(_ sender: UIButton) {
        // Now You can send your Array with the Func you're created in lessonController
        // reload tableView in lessonController & Send Data
        lessonController.reloadLessonData(lesson: lessons)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? LessonController,
           segue.identifier == "lessonController" {
            self.lessonController = vc
            vc.homeController = self
            vc.lessons = self.lessons
        }
    }
    
}


// This View is assigned to Container View
class LessonController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet var tableView: UITableView!
    @IBOutlet var noResultsLabel: UILabel!
    
    // Your Array
    var lessons: [Lesson] = []
    
    // Controller
    var homeController: HomeController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        homeController.lessonController = self
    }
    
    // This func recive data From HomeController
    func reloadLessonData(lesson: [Lesson]){
        self.lessons = lesson
        self.tableView.reloadData()
        
        if lesson.count <= 0 {
            self.noResultsLabel.isHidden = false
        }else{
            self.noResultsLabel.isHidden = true
        }
    }
    
    
    
    //MARK:- TableView
    // numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lessons.count
    }
    
    // cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseCell", for: indexPath) as! CourseCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        cell.labelTitle.text = lessons[indexPath.row].title
       
        return cell
    }
    
}

