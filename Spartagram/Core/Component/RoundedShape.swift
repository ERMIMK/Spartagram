//
//  RoundedShape.swift
//  Spartagram
//
//  Created by Ermiyas Mesfin on 10/24/23.
//

import SwiftUI

// Round the edges of shapes 
struct RoundedShape: Shape {
    var corners: UIRectCorner
    
    func path(in react: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: react, byRoundingCorners: corners, cornerRadii: CGSize(width: 60, height: 60))
        
        return Path(path.cgPath)
    }
}
