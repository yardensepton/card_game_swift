import Foundation

class GameManager {
    
    static let sharedGameManager = GameManager()
    
    var allCards: [Card]
    var leftPlayer: Player
    var rightPlayer: Player
    let gameTotalRounds: Int = 10
    var gameRoundsCounter: Int = 0
    
    private init() {
        self.allCards = [
            Card(value: 1, image: "1.png"),
            Card(value: 10, image: "10.png"),
            Card(value: 2, image: "2.png"),
            Card(value: 3, image: "3.png"),
            Card(value: 4, image: "4.png"),
            Card(value: 5, image: "5.png"),
            Card(value: 6, image: "6.png"),
            Card(value: 7, image: "7.png"),
            Card(value: 8, image: "8.png"),
            Card(value: 9, image: "9.png"),
            Card(value: 2, image: "Monsters (10).png"),
            Card(value: 3, image: "Monsters (11).png"),
            Card(value: 1, image: "Monsters (9).png"),
        ]
        
        self.allCards.shuffle()
        
        self.leftPlayer = Player(name: "left", currentCard: allCards.randomElement()!)
        self.rightPlayer = Player(name: "right", currentCard: allCards.randomElement()!)
    }
    
    func randomCardsToPlayers() {
        self.leftPlayer.currentCard = allCards.randomElement()!
        self.rightPlayer.currentCard = allCards.randomElement()!
    }
    
        func compareCardsValue()->PlayerBoardPlace{
            //        right value is bigger
            if(rightPlayer.currentCard.compare(otherCard: leftPlayer.currentCard) == 1){
                self.rightPlayer.addScore()
                self.gameRoundsCounter += 1
                return PlayerBoardPlace.right
    
            }
            //        left value is bigger
            else if(rightPlayer.currentCard.compare(otherCard: leftPlayer.currentCard) == -1){
                self.leftPlayer.addScore()
                self.gameRoundsCounter += 1
                return PlayerBoardPlace.left
    
            }
            self.gameRoundsCounter += 1
            return PlayerBoardPlace.none
    
        }
    
    func isGameFinished() -> Bool {
        return self.gameRoundsCounter == gameTotalRounds
    }
    
    func saveUserName(text: String) {
        if !text.isEmpty {
            UserDefaults.standard.set(text, forKey: "userName")
            UserDefaults.standard.synchronize()
        }
    }
    
    func setPlayersNames(){
        let name : String = getUserName()
        let side : String = getUserSide()
        
        if  name != "" {
               if side == "west"{
                   leftPlayer.setName(name:name)
                      rightPlayer.setName(name: "PC")
               }else{
                   rightPlayer.setName(name:name)
                      leftPlayer.setName(name: "PC")
               }
           
            
        }
    }
    
    func saveUserSide(text: String) {
        if !text.isEmpty {
            UserDefaults.standard.set(text, forKey: "side")
            UserDefaults.standard.synchronize()
        }
    }
    
    func getUserSide() -> String {
        return UserDefaults.standard.string(forKey: "side") ?? ""
    }
    
    func getUserName() -> String {
        return UserDefaults.standard.string(forKey: "userName") ?? ""
    }
    
        func getWinner()->Player{
            if leftPlayer.score > rightPlayer.score{
                return leftPlayer
            }else{
                return rightPlayer
            }
        }
    
    func clearGame(){
        self.leftPlayer.score = 0
        self.rightPlayer.score = 0
        self.gameRoundsCounter = 0
    }
    
    func resetData(){
        if let appDomain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: appDomain)
        }
    }
}
