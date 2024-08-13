//
//  Message.swift
//  FlashChat
//
//  Created by Игорь Клевжиц on 14.08.2024.
//

import Foundation

struct Message {
    enum Sender {
        case me, you
    }
    
    let sender: Sender
    let body: String
}

extension Message {
    static func getMessages() -> [Message]{
        
        
        return [
            Message(sender: .you, body: "Hey! How are you today? 🌞"),
            Message(sender: .me, body: "Hi! I'm doing great, thanks! 😊 How about you?"),
            Message(sender: .you, body: "I'm good too, thanks for asking! Any exciting plans for the weekend? 🎉"),
            Message(sender: .me, body: "Actually, yes! I'm going on a hiking trip with some friends."),
            Message(sender: .me, body: "🥾🏞️ We're going to explore a national park nearby. How about you?"),
            Message(sender: .you, body: "Sounds amazing! I'm planning to catch up on some reading and maybe go for a bike ride. 📚🚲"),
            Message(sender: .me, body: "That sounds relaxing. Enjoy your time! 😄"),
            Message(sender: .you, body: "Thank you! Have a fantastic hiking trip, and let's catch up soon! 👋🏼"),
            Message(sender: .me, body: "Absolutely! Take care and talk to you later! 👍🏼😊")
        ]
    }
}
