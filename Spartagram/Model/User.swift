//
//  User.swift
//  Spartagram
//
//  Created by Ermiyas Mesfin on 10/25/23.
//

import FirebaseFirestoreSwift
import Firebase


struct User: Identifiable, Decodable {
    
    // Fetched User data from Firebase database
    @DocumentID var id: String?
    let username: String            // Fetched User Name
    let fullname: String            // ... Fullname
    var profileImageUrl: String     // ... Profile Image
    let email: String               // ... Email
    
    var isCurrentUser: Bool {return Auth.auth().currentUser?.uid == id}
}

