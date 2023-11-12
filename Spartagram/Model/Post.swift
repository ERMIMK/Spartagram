//
//  Post.swift
//  Spartagram
//
//  Created by Ermiyas Mesfin on 10/26/23.
//

import FirebaseFirestoreSwift
import Firebase

// Fetched Post data from Firebase database
struct Post: Identifiable, Decodable {
    @DocumentID var id: String?
    let caption: String             // story caption
    let timestamp: Timestamp        // story timestamp
    let uid: String                 // User Id
    let likes: Int                  // post likes
    let saves: Int                  // Saves count
    var imageUrl: String?           // the image URL
    var user: User?                 // User
    
    var didLike: Bool? = false
    var didSave: Bool? = false
    
}
