//
//  ViewController.swift
//  Challenge3
//
//  Created by Daniel Ziper on 7/10/20.
//  Copyright © 2020 Daniel Ziper. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currentWord = String()
    var currentLabel = String(){
        didSet{
            let letterArr = Array(currentLabel)
            var newLabel = ""
            for letter in letterArr{
                newLabel += String(letter) + " "
            }
            wordLabel.text = newLabel
        }
    }
    var wordLabel: UILabel!
    var letterButtons = [UIButton]()
    var buttonsView: UIView!
    
    var words = ["CAT", "ANIMAL","COMPUTER", "LEATHER", "FOUNTAIN", "KEYBOARD"]
    
    var lives = 7 {
        didSet{
            livesLabel?.text = "\(lives) Lives"
        }
    }
    var livesLabel: UILabel!
    let alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    var level = 0
    var score: Int = 0{
        didSet{
            scoreLabel?.text = "Score: \(score)"
        }
    }
    var scoreLabel: UILabel!
    
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        
        wordLabel = UILabel()
        wordLabel.font = UIFont.systemFont(ofSize: 44)
        wordLabel.textColor = .black
        wordLabel.translatesAutoresizingMaskIntoConstraints = false
        wordLabel.textAlignment = .center
        
        words.shuffle()

        currentLabel = ""
        currentWord = words[level]
        for _ in currentWord{
            currentLabel += "_"
        }
        
        view.addSubview(wordLabel)
        
        scoreLabel = UILabel()
        scoreLabel.font = UIFont.systemFont(ofSize: 24)
        scoreLabel.textColor = .black
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .left
        score = 0
        view.addSubview(scoreLabel)
        
        livesLabel = UILabel()
        livesLabel.text = "\(lives) Lives"
        livesLabel.font = UIFont.systemFont(ofSize: 24)
        livesLabel.translatesAutoresizingMaskIntoConstraints = false
        livesLabel.textAlignment = .right
        view.addSubview(livesLabel)
        
        buttonsView = UIView()
        buttonsView.backgroundColor = .white
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        let screenSize = UIScreen.main.bounds
        //need constraints in order to show anything on the screen so don't panic
        NSLayoutConstraint.activate([
            wordLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor,constant: 50),
            wordLabel.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -50),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.widthAnchor.constraint(equalToConstant: screenSize.width * 0.7),
            buttonsView.heightAnchor.constraint(equalToConstant: 400),
            
            livesLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            livesLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor)
        
        ])
        
        let width = Int(screenSize.width / 8)
        let height = 80
        var counter = 0
        
        for row in 0...6{
            for col in 0...5{
                if counter >= 26{
                    break
                }
                
                let button = UIButton(type: .system)
                let letter = String(Array(alphabet)[counter])
                button.titleLabel?.font = UIFont.systemFont(ofSize: 44)
                button.setTitle(letter, for: .normal)
                button.titleLabel?.textAlignment = .center
                
                let frame = CGRect(x: col * width, y: row * height, width: width, height: height)
                
                button.frame = frame
                
                button.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                
                
                buttonsView.addSubview(button)
                letterButtons.append(button)
                counter += 1
            }
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @objc func letterTapped(_ sender: UIButton){
        let letter = Character((sender.titleLabel?.text)!)
        
        var didFind = false
        var labelArr = Array(currentLabel)
        
        for (i,l) in currentWord.enumerated(){
            if letter == l{
                labelArr[i] = letter
                didFind = true
            }
        }
        
        currentLabel = String(labelArr)
        
        if !didFind{
            lives -= 1
            if lives == 0{
                restart()
            }
            
        }
        
        sender.isHidden = true
        
        if !currentLabel.contains("_"){
            levelUp()
        }
      
    }
    func restart(){
        let ac = UIAlertController(title: "You lost!", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Restart", style: .default, handler: resetButtons))
        present(ac,animated: true)
        
        words.shuffle()
        level = 0
        score = 0
        lives = 7
        
        currentWord = words[level]
        currentLabel = ""
        for _ in currentWord{
            currentLabel += "_"
        }
        
        
    }
    
    @objc func resetButtons(_ sender: UIAlertAction){
        for button in letterButtons{
            button.isHidden = false
        }
    }
    
    func levelUp(){
        let ac = UIAlertController(title: "You won!", message: "Ready to level up?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac,animated: true)
        
        level += 1
        currentWord = words[level%words.count]
        currentLabel = ""
        for _ in currentWord{
            currentLabel += "_"
        }
        score += lives
        
        for button in letterButtons{
            button.isHidden = false
        }
        
        
    }


}

