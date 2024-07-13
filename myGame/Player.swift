//
//  Player.swift
//  myGame
//
//  Created by Student25 on 10/07/2024.
//

import Foundation

class Player{
    
    var score: Int
    var name: String
    var currentCard : Card

    init( name: String, currentCard: Card) {
        self.score = 0
        self.name = name
        self.currentCard = currentCard
       
    }
    
    func setName(name: String){
        self.name = name
    }
    
    func addScore(){
        self.score += 1
    }
    
    
    
    
}
