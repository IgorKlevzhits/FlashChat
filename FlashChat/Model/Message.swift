//
//  Message.swift
//  FlashChat
//
//  Created by Игорь Клевжиц on 14.08.2024.
//

import Foundation
import CoreText

enum Sender {
    case me, you
}

struct Message {
    let sender: String
    let body: String
}
