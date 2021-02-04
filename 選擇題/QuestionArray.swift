//
//  questionArray.swift
//  autolayout
//
//  Created by Mutyumu on 2021/2/1.
//

import Foundation

struct QuestionArray: Codable {
    let response_code: Int
    let results: [StoreItem]
}

struct StoreItem: Codable {
    let category: String
    let type: String
    let difficulty: String
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]
}

struct passCategory {
    let passCategory: String
}

struct passDifficulty {
    let passDifficulty: String
}

struct passScore {
    let score: Int
}

class Stopwatch {
    
    private var startTime: Date?

    var elapsedTime: TimeInterval {
        if let startTime = self.startTime {
            return -startTime.timeIntervalSinceNow
        } else {
            return 0
        }
    }
    
    var elapsedTimeAsString: String {
        return String(format: "%02d:%02d.%d",
            Int(elapsedTime / 60), Int(elapsedTime.truncatingRemainder(dividingBy: 60)), Int((elapsedTime * 10).truncatingRemainder(dividingBy: 10)))
    }
    
    var isRunning: Bool {
        return startTime != nil
    }
    
    func start() {
        startTime = Date()
    }
    
    func stop() {
        startTime = nil
    }
    
}

struct passTimer {
    var timer: String
}

struct top3Score {
    static var top3Score = [0,0,0]
}

struct top3Name {
    static var top3Name = ["","",""]
}

struct top3Date {
    static var top3Date = ["","",""]
}

struct passPlayerName {
    var name: String
}
