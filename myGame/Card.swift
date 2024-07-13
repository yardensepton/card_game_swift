import Foundation

class Card{
    let value: Int
    let image: String
    
    init(value: Int, image: String) {
        self.value = value
        self.image = image
    }
    
    
    func compare(otherCard: Card)->Int{
        if self.value > otherCard.value{
            return 1
        }else if self.value < otherCard.value{
            return -1
        }else{
            return 0
        }
    }
    

    
    func getImage()->String{
        return self.image
    }
    
    func getValue()->Int{
        return self.value
    }
    
    
    
    
    
    
}
