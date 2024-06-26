//
//  Mood.swift
//  Shake-It
//
//  Created by Rui on 2024/6/13.
//

import SwiftUI

struct MoodType: Codable, Hashable, Identifiable {
  var id: String { name }
  let name: String
  let colorName: String
  
  var color: Color {
    .systemColor[colorName, default: .black]
  }
}

struct MoodItem: Codable, Hashable, Identifiable {
  var id: String { name }
  var type: String
  var name: String
  var colorName: String
  
  var color: Color {
    let colors: [CustomColor] = Bundle.main.decode(form: "appColors.json")
    return colors.first{ $0.name == colorName }?.color ?? .black
  }
}

@Observable
class Moods: Identifiable {
  var items = [MoodItem]() {
    didSet {
      Bundle.main.encode(to: "moods.json", from: items)
    }
  }
  
  init() {
    if let data: [MoodItem] = Bundle.main.decode(form: "moods.json") {
      items = data
      return
    }
    
    items = []
  }
}
