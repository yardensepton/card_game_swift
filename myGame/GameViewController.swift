//
//  ViewController.swift
//  myGame
//
//  Created by Student25 on 10/07/2024.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var rightPlayerImage: UIImageView!
    @IBOutlet weak var rightPlayerScore: UILabel!
    @IBOutlet weak var leftPlayerImage: UIImageView!
    @IBOutlet weak var leftPlayerScore: UILabel!
    @IBOutlet weak var rightPlayerName: UILabel!
    @IBOutlet weak var leftPlayerName: UILabel!
    
    @IBOutlet weak var roundNumber: UILabel!
       let gameManager = GameManager.sharedGameManager
    var gameTimer : Timer?
       
    var isFront : Bool = false
    var timerCounter : Int = 0
    let timeToShowFront : Int = 2
    let timeToShowBack : Int = 6
    
   override func viewDidLoad() {
        super.viewDidLoad()
          self.navigationItem.hidesBackButton = true
       rightPlayerImage.image = UIImage(named: "card.jpeg")
       leftPlayerImage.image = UIImage(named: "card.jpeg")
       leftPlayerScore.text = "0"
       rightPlayerScore.text = "0"
       roundNumber.text = "Rounds"
       
       checkName()
          
       gameTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self,selector: #selector(gameRounds),userInfo: nil,repeats: true)
    
       
   }
    
    func checkName(){
           gameManager.setPlayersNames()
           rightPlayerName.text = gameManager.rightPlayer.name
           leftPlayerName.text = gameManager.leftPlayer.name
    }
    

    
    @objc func gameRounds(){
           if gameManager.isGameFinished() {
                  stopGameTimer()
                  let storyBoard = self.storyboard?.instantiateViewController(withIdentifier: "winnerPage") as! WinnerViewController
                  self.navigationController?.pushViewController(storyBoard, animated: true)
                  
                  
              }
        if(timerCounter == timeToShowFront){
            showFrontCard()
               setScore()
        }else if(timerCounter == timeToShowBack){
            showBackCard()
            timerCounter = 0
        }
        timerCounter += 1

    }
       
      private func goToWinnerPage(){
     
       }
    
 

    
    
    
       func animateFlip(imageView:UIImageView,animation:UIView.AnimationOptions){
              UIView.transition(with: imageView, duration: 0.4, options: animation, animations:nil)
              
       }

       
       func stopGameTimer() {
            gameTimer?.invalidate()
            gameTimer = nil
        }
        
        deinit {
            stopGameTimer()
        }

       
       func showFrontCard(){
              gameManager.randomCardsToPlayers()
           
           rightPlayerImage.image = UIImage(named: gameManager.rightPlayer.currentCard.image)
           leftPlayerImage.image = UIImage(named: gameManager.leftPlayer.currentCard.image)
              animateFlip(imageView: leftPlayerImage, animation: .transitionFlipFromLeft)
              animateFlip(imageView: rightPlayerImage, animation: .transitionFlipFromRight)
              
       }
    
    func showBackCard(){
        rightPlayerImage.image = UIImage(named: "card.jpeg")
        leftPlayerImage.image = UIImage(named: "card.jpeg")
        animateFlip(imageView: leftPlayerImage, animation: .transitionFlipFromLeft)
        animateFlip(imageView: rightPlayerImage, animation: .transitionFlipFromRight)
    }
       
       func setScore() {
           let result: PlayerBoardPlace = gameManager.compareCardsValue()
           
           switch result {
           case .left:
               scoreAnimation(for: leftPlayerScore)
           case .right:
               scoreAnimation(for: rightPlayerScore)
           case .none:
                  break
           }
           
           leftPlayerScore.text = gameManager.leftPlayer.score.description
           rightPlayerScore.text = gameManager.rightPlayer.score.description
           roundNumber.text = "Round: " + gameManager.gameRoundsCounter.description 
       }

       func scoreAnimation(for scoreLabel: UILabel) {
              UIView.animate(withDuration: 0.3, animations: {
                         // Make the label bigger
                         scoreLabel.transform = CGAffineTransform(scaleX: 3, y: 3)
                         scoreLabel.alpha = 1.0  // Fade in the label
                     }) { (finished) in
                         UIView.animate(withDuration: 0.3, animations: {
                             // Return the label to its original size
                             scoreLabel.transform = .identity
                         })
                     }
       }

              
       }




