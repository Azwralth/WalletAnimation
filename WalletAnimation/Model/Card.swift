//
//  Card.swift
//  WalletAnimation
//
//  Created by Владислав Соколов on 04.12.2024.
//

import SwiftUI

struct Card: Identifiable {
    let id: String = UUID().uuidString
    
    let number: String
    let expires: String
    let color: Color
    let balance: String
    
    var cardGeometryId: String {
        "MASTERCARD_\(id)"
    }
}

var cards: [Card] = [
    .init(number: "**** **** **** 4308", expires: "03/28", color: .indigo, balance: "4310 $"),
    .init(number: "**** **** **** 3952", expires: "10/25", color: .green, balance: "30000 руб"),
    .init(number: "**** **** **** 9352", expires: "12/26", color: .blue, balance: "310 $"),
    .init(number: "**** **** **** 3412", expires: "03/27", color: .black, balance: "340000 KZT")
    ]
