//
//  ViewController.swift
//  選擇題
//
//  Created by Mutyumu on 2021/2/1.
//

import UIKit

class StartViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    
    let category = ["Any Category","General Knowledge","Entertainment: Books","Entertainment: Films","Entertainment: Music","Entertainment: Musicals & Theatres","Entertainment: Television","Entertainment: Video Games","Entertainment: Board Games","Science & Nature","Science : Computers","Science: Mathematics","Mythology","Sports","Geography","History","Politics","Art","Celebrities","Animals","Vehicles","Entertainment: Comics","Science: Gadgets","Entertainment: Japanese Anime & Manga","Entertainment: Cartoon & Animations"]
    let difficulty = ["Any Difficulty","Easy","Medium","Hard"]
    
    let categoryPickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 300))
    let difficultyPickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 300))
    
    
    @IBOutlet weak var categoryText: UILabel!
    
    @IBOutlet weak var playerName: UITextField!
    @IBOutlet weak var difficultyText: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerName.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == categoryPickerView {
            return category.count
        } else if pickerView == difficultyPickerView{
            return difficulty.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == categoryPickerView {
            return category[row]
        } else if pickerView == difficultyPickerView{
            return difficulty[row]
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == categoryPickerView {
            categoryText.text = category[row]
            
        } else if pickerView == difficultyPickerView{
            difficultyText.text = difficulty[row]
        }
        
    }
    
    
    @IBAction func ChooseCategory(_ sender: Any) {
        
        let alert = UIAlertController(title: "SELECT CATEGORY", message: nil, preferredStyle: .alert)
        
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250,height: 300)
        categoryPickerView.dataSource = self
        categoryPickerView.delegate = self
        vc.view.addSubview(categoryPickerView)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func ChooseDifficulty(_ sender: Any) {
        
        let alert = UIAlertController(title: "SELECT DIFFICULTY", message: nil, preferredStyle: .alert)
        
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250,height: 300)
        difficultyPickerView.dataSource = self
        difficultyPickerView.delegate = self
        vc.view.addSubview(difficultyPickerView)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    

    @IBSegueAction func PassCatDiff(_ coder: NSCoder) -> QuestionsViewController? {
        let controller = QuestionsViewController(coder: coder)
        let category = categoryText.text
        let difficulty = difficultyText.text
        let Name = playerName.text
        
        controller?.category = passCategory(passCategory: String(category!))
        controller?.difficulty = passDifficulty(passDifficulty: String(difficulty!))
        controller?.playerName = passPlayerName(name: Name!)
        return controller
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {

    }
    
}

