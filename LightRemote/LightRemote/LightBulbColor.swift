//
//  LightBulbColor.swift
//  LightRemote
//
//  Created by SAMUEL on 08/12/2023.
//

import Foundation
import SwiftUI
class LightBulbColor{
    var color:Color = .white
    var x = 0.0
    var y = 0.0
    
    init(color:Color,x:Double,y:Double) {
        self.color = color
        self.x = x
        self.y = y
    }
}

class LightBulbColorMnjr{
    func ColorList() -> [LightBulbColor]{
        let pinkp = Color(red: 255 / 255, green: 123 / 255, blue: 202 / 255)
        var colors = [LightBulbColor]()
        
        colors.append(LightBulbColor(color: .red, x: 0.461, y: 0.330))
        colors.append(LightBulbColor(color: .orange, x: 0.570, y: 0.420))
        colors.append(LightBulbColor(color: .green, x: 0.334, y: 0.646))
        colors.append(LightBulbColor(color: .purple, x: 0.230, y: 0.121))
        colors.append(LightBulbColor(color: pinkp, x: 0.371, y: 0.250))
        colors.append(LightBulbColor(color: .blue, x: 0.168, y: 0.172))
        
        
        return colors
    }
}
