//
//  WinnerViewController.swift
//  myGame
//
//  Created by Student25 on 13/07/2024.
//

import UIKit

class WinnerViewController: UIViewController {
    @IBOutlet weak var winnerLabel: UILabel!
    
    @IBOutlet weak var backToStartPage: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    let gameManager = GameManager.sharedGameManager
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        backToStartPage.titleLabel?.text = "BACK TO MENU"
        getWinner()
        

    
        
    }
    

    @IBAction func back(_ sender: Any) {
        gameManager.clearGame()
        let storyBoard = self.storyboard?.instantiateViewController(withIdentifier: "firstViewController") as! StartControllerViewController
        self.navigationController?.pushViewController(storyBoard, animated: true)
    }
    
    func getWinner(){
      let  winner : Player = gameManager.getWinner()
        winnerLabel.textAlignment = .center
       scoreLabel.textAlignment = .center
        winnerLabel.text = "The winner is: " + winner.name
        scoreLabel.text = "Score: " + winner.score.description
    }


}
