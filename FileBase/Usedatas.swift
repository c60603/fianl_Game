//
//  Usedatas.swift
//  fianl_Game
//
//  Created by 陳奇松 on 2021/6/30.
//

import Foundation
import SwiftUI

struct offsetXY : Identifiable{
    var id = UUID()
    var x :CGFloat
    var y :CGFloat
}

struct mapItem :Identifiable{
    var id = UUID()
    var index : Int
    var itemlevel:Int
    var itemName:String
    var x :CGFloat
    var y :CGFloat
    var playerColorIndex : Int
}

let Role = [
    "人物1",
    "人物2",
    "人物3",
    "人物4",
    "人物5",
]

struct house {
    var level1 : String
    var level2 : String
    var level3 :String
}

var playerColor = [
    Color.clear,
    Color.red,
    Color.blue,
    Color.yellow,
    Color.orange,
]



let roleOffset = [
    offsetXY(x: 0, y: 0),
    offsetXY(x: 30, y: -15),
    offsetXY(x: 0, y: -30),
    offsetXY(x: -30, y: -15)
]




struct PlayerMove {
    var targetLocation = 0
    var currentLocation = 0
}
