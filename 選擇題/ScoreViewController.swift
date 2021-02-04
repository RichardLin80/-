//
//  ScoreViewController.swift
//  選擇題
//
//  Created by Mutyumu on 2021/2/3.
//

import UIKit

class ScoreViewController: UIViewController {
    
    var finalScore: passScore!
    var finalTimer: passTimer!
    var playerName: passPlayerName!
    
    @IBOutlet weak var scoreText: UILabel!
    @IBOutlet weak var finalTime: UILabel!
    @IBOutlet var Top3Name: [UILabel]!
    @IBOutlet var Top3Score: [UILabel]!
    @IBOutlet var Top3Date: [UILabel]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getHighScore()
        scoreText.text = String(finalScore.score)
        finalTime.text = finalTimer.timer
        for i in 0...2 {
            if top3Score.top3Score[i] == 0 {
                Top3Score[i].text = ""
            }
            else{
                Top3Score[i].text = String(top3Score.top3Score[i])
            }
        }
        for i in 0...2 {
            Top3Name[i].text = top3Name.top3Name[i]
        }
        for i in 0...2 {
            Top3Date[i].text = top3Date.top3Date[i]
        }
        
        // Do any additional setup after loading the view.
    }
    
    func getHighScore() {
        let currentDate = Date()
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "YYYY.MM.dd"
        let stringDate = dataFormatter.string(from: currentDate)
        
        if finalScore.score > top3Score.top3Score[2] {
            if finalScore.score > top3Score.top3Score[0] {
                top3Score.top3Score[2] = top3Score.top3Score[1]
                top3Score.top3Score[1] = top3Score.top3Score[0]
                top3Score.top3Score[0] = finalScore.score
                
                top3Name.top3Name[2] = top3Name.top3Name[1]
                top3Name.top3Name[1] = top3Name.top3Name[0]
                top3Name.top3Name[0] = playerName.name
                
                top3Date.top3Date[2] = top3Date.top3Date[1]
                top3Date.top3Date[1] = top3Date.top3Date[0]
                top3Date.top3Date[0] = stringDate
                
            }
            else if finalScore.score > top3Score.top3Score[1] {
                top3Score.top3Score[2] = top3Score.top3Score[1]
                top3Score.top3Score[1] = finalScore.score
                
                top3Name.top3Name[2] = top3Name.top3Name[1]
                top3Name.top3Name[1] = playerName.name
                
                top3Date.top3Date[2] = top3Date.top3Date[1]
                top3Date.top3Date[1] = stringDate
            }
            else if finalScore.score > top3Score.top3Score[2]{
                top3Score.top3Score[2] = finalScore.score
                
                top3Name.top3Name[2] = playerName.name
                
                top3Date.top3Date[2] = stringDate
            }
        }
    }
    
    @IBAction func playAgain(_ sender: Any) {
        self.performSegue(withIdentifier: "playAgain", sender: self)
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
