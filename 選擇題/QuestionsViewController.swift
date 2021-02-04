//
//  QuestionsViewController.swift
//  選擇題
//
//  Created by Mutyumu on 2021/2/2.
//

import UIKit

class QuestionsViewController: UIViewController {

    var category: passCategory!
    var difficulty: passDifficulty!
    var playerName: passPlayerName!
    var questionsArray :[String] = []
    var correctAnswerArray :[String] = []
    var incorrectAnswerArray :[String] = []
    var j = 1
    var score = 0
    var checkAnswerNumber = 0
    let stopwatch = Stopwatch()

    
    @IBOutlet weak var elapsedTimeLabel: UILabel!
    @IBOutlet weak var questionIndex: UILabel!
    @IBOutlet weak var scoreBoard: UILabel!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var A: UILabel!
    @IBOutlet weak var B: UILabel!
    @IBOutlet weak var C: UILabel!
    @IBOutlet weak var D: UILabel!
    @IBOutlet weak var viewA: WheelView!
    @IBOutlet weak var viewB: WheelView!
    @IBOutlet weak var viewC: WheelView!
    @IBOutlet weak var viewD: WheelView!
    @IBOutlet weak var nextButton: UIButton!
    
    
    
    override func viewDidLoad() {
        
        
        GetQuestions()
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      //  Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (timer) in
       // }
    }
    
    @objc func updateElapsedTimeLabel(_ timer: Timer) {
        if stopwatch.isRunning {
            elapsedTimeLabel.text = stopwatch.elapsedTimeAsString
        } else {
            timer.invalidate()
        }
    }
    
    func GetQuestions() {
        
        var categoryURL: String!
        var difficultyURL: String!
        
        switch category.passCategory {
        case "Any Category":
            categoryURL = ""
        case "General Knowledge":
            categoryURL = "&category=9"
        case "Entertainment: Books":
            categoryURL = "&category=10"
        case "Entertainment: Films":
            categoryURL = "&category=11"
        case "Entertainment: Music":
            categoryURL = "&category=12"
        case "Entertainment: Musicals & Theatres":
            categoryURL = "&category=13"
        case "Entertainment: Television":
            categoryURL = "&category=14"
        case "Entertainment: Video Games":
            categoryURL = "&category=15"
        case "Entertainment: Board Games":
            categoryURL = "&category=16"
        case "Science & Nature":
            categoryURL = "&category=17"
        case "Science : Computers":
            categoryURL = "&category=18"
        case "Science: Mathematics":
            categoryURL = "&category=19"
        case "Mythology":
            categoryURL = "&category=20"
        case "Sports":
            categoryURL = "&category=21"
        case "Geography":
            categoryURL = "&category=22"
        case "History":
            categoryURL = "&category=23"
        case "Politics":
            categoryURL = "&category=24"
        case "Art":
            categoryURL = "&category=25"
        case "Celebrities":
            categoryURL = "&category=26"
        case "Animals":
            categoryURL = "&category=27"
        case "Vehicles":
            categoryURL = "&category=28"
        case "Entertainment: Comics":
            categoryURL = "&category=29"
        case "Science: Gadgets":
            categoryURL = "&category=30"
        case "Entertainment: Japanese Anime & Manga":
            categoryURL = "&category=31"
        case "Entertainment: Cartoon & Animations":
            categoryURL = "&category=32"
        default:
            break
        }
        
        switch difficulty.passDifficulty {
        case "Any Difficulty":
            difficultyURL = ""
        case "Easy":
            difficultyURL = "&difficulty=easy"
        case "Medium":
            difficultyURL = "&difficulty=medium"
        case "Hard":
            difficultyURL = "&difficulty=hard"
        default:
            break
        }
        
        
        
        
        let urlStr = "https://opentdb.com/api.php?amount=10"+categoryURL+difficultyURL+"&type=multiple"
        print(urlStr)
        
        
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { [self] (data, response , error) in
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                if let data = data {
                    do {
                        let questionArray = try decoder.decode(QuestionArray.self, from: data)
                        print(questionArray.results)
                        for i in 0...9 {
                            questionsArray.append(questionArray.results[i].question)
                            correctAnswerArray.append(questionArray.results[i].correct_answer)
                            incorrectAnswerArray.append(questionArray.results[i].incorrect_answers[0])
                            incorrectAnswerArray.append(questionArray.results[i].incorrect_answers[1])
                            incorrectAnswerArray.append(questionArray.results[i].incorrect_answers[2])
                        }
                        DispatchQueue.main.async {
                            self.firstQuestionAnswer(nil)
                            Timer.scheduledTimer(timeInterval: 0.1, target: self,
                                selector: #selector(QuestionsViewController.updateElapsedTimeLabel(_:)), userInfo: nil, repeats: true)
                            stopwatch.start()
                        }
                    }
                    catch{
                        print("error")
                    }
                } else {
                    print("error")
                    
                }
            }.resume()
        }
    }

    @IBAction func firstQuestionAnswer(_ sender: UIButton?) {
        var answerArray:[String] = []
        answerArray.append(correctAnswerArray[0])
        answerArray.append(incorrectAnswerArray[0])
        answerArray.append(incorrectAnswerArray[1])
        answerArray.append(incorrectAnswerArray[2])
        answerArray.shuffle()
        question.text = questionsArray[0]
        A.text = answerArray[0]
        B.text = answerArray[1]
        C.text = answerArray[2]
        D.text = answerArray[3]
        nextButton.isUserInteractionEnabled = false
        
    }
    
    @IBAction func nextQuestion(_ sender: Any) {
        
        if j >= 10 {
            stopwatch.stop()
            performSegue(withIdentifier: "score", sender: nil)
        }
        else{
            var answerArray:[String] = []
            answerArray.append(correctAnswerArray[0+j])
            answerArray.append(incorrectAnswerArray[0+3*j])
            answerArray.append(incorrectAnswerArray[1+3*j])
            answerArray.append(incorrectAnswerArray[2+3*j])
            answerArray.shuffle()
            question.text = questionsArray[0+j]
            A.text = answerArray[0]
            B.text = answerArray[1]
            C.text = answerArray[2]
            D.text = answerArray[3]
            j += 1
            questionIndex.text = String(j)
            ResetViewBackgroundColor()
            ViewsEnabled()
            nextButton.isUserInteractionEnabled = false
        }
    }
    
    
    func ResetViewBackgroundColor() {
        viewA.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        viewB.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        viewC.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        viewD.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    func ViewsEnabled() {
        viewA.isUserInteractionEnabled = true
        viewB.isUserInteractionEnabled = true
        viewC.isUserInteractionEnabled = true
        viewD.isUserInteractionEnabled = true
    }
    
    func ViewsDisable() {
        viewA.isUserInteractionEnabled = false
        viewB.isUserInteractionEnabled = false
        viewC.isUserInteractionEnabled = false
        viewD.isUserInteractionEnabled = false
    }
    
    @IBAction func selectA(_ sender: Any) {
        
        if A.text == correctAnswerArray[j-1] {
            viewA.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.8)
            
            
            if checkAnswerNumber >= 3 {
                score = score + 30
            }
            else{
                score = score + 10
            }
            checkAnswerNumber += 1
            scoreBoard.text = String(score)
            
        }
        else{
            switch correctAnswerArray[j-1] {
            case B.text:
                viewB.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.8)
            case C.text:
                viewC.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.8)
            case D.text:
                viewD.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.8)
            default:
                break
            }
            viewA.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.8)
            if checkAnswerNumber >= 3 {
                score = score - 10
            }
            checkAnswerNumber = 0
            scoreBoard.text = String(score)
        }
        ViewsDisable()
        nextButton.isUserInteractionEnabled = true
    }
    
    @IBAction func selectB(_ sender: Any) {
        if B.text == correctAnswerArray[j-1] {
            viewB.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.8)
            
            if checkAnswerNumber >= 3 {
                score = score + 30
            }
            else{
                score = score + 10
            }
            checkAnswerNumber += 1
            scoreBoard.text = String(score)
        }
        else{
            switch correctAnswerArray[j-1] {
            case A.text:
                viewA.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.8)
            case C.text:
                viewC.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.8)
            case D.text:
                viewD.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.8)
            default:
                break
            }
            viewB.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.8)
            if checkAnswerNumber >= 3 {
                score = score - 10
            }
            checkAnswerNumber = 0
            scoreBoard.text = String(score)
        }
        ViewsDisable()
        nextButton.isUserInteractionEnabled = true
    }
    
    @IBAction func selectC(_ sender: Any) {
        if C.text == correctAnswerArray[j-1] {
            viewC.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.8)
            
            if checkAnswerNumber >= 3 {
                score = score + 30
            }
            else{
                score = score + 10
            }
            checkAnswerNumber += 1
            scoreBoard.text = String(score)
        }
        else{
            switch correctAnswerArray[j-1] {
            case A.text:
                viewA.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.8)
            case B.text:
                viewB.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.8)
            case D.text:
                viewD.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.8)
            default:
                break
            }
            viewC.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.8)
            if checkAnswerNumber >= 3 {
                score = score - 10
            }
            checkAnswerNumber = 0
            scoreBoard.text = String(score)
        }
        ViewsDisable()
        nextButton.isUserInteractionEnabled = true
    }
    
    @IBAction func selectD(_ sender: Any) {
        if D.text == correctAnswerArray[j-1] {
            viewD.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.8)
            
            if checkAnswerNumber >= 3 {
                score = score + 30
            }
            else{
                score = score + 10
            }
            checkAnswerNumber += 1
            scoreBoard.text = String(score)
        }
        else{
            switch correctAnswerArray[j-1] {
            case A.text:
                viewB.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.8)
            case B.text:
                viewC.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.8)
            case C.text:
                viewD.backgroundColor = UIColor(red: 0, green: 1, blue: 0, alpha: 0.8)
            default:
                break
            }
            viewD.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.8)
            if checkAnswerNumber >= 3 {
                score = score - 10
            }
            checkAnswerNumber = 0
            scoreBoard.text = String(score)
        }
        ViewsDisable()
        nextButton.isUserInteractionEnabled = true
    }
    
    @IBSegueAction func passFinalScore(_ coder: NSCoder) -> ScoreViewController? {
        let controller = ScoreViewController(coder: coder)
        controller?.finalScore = passScore(score: score)
        controller?.finalTimer = passTimer(timer: String(elapsedTimeLabel.text!))
        controller?.playerName = passPlayerName(name: playerName.name)
       
        return controller
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
