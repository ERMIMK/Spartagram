//
//  ExplorerViewModel.swift
//  Spartagram
//
//  Created by Ermiyas Mesfin on 10/26/23.
//

import Foundation

class ExplorerViewModel: ObservableObject {
    
    @Published var users = [User]()
    let service = UserService()
    
    @Published var searchText = ""
    var searchableUsers: [User] {
        if searchText.isEmpty {
            return users
        }else{
            let lowercasedQuery = searchText.lowercased()
            
            return users.filter({
                $0.username.contains(lowercasedQuery) ||
                $0.fullname.lowercased().contains(lowercasedQuery)
            })
        }
    }
    
    init(){
        fetchUsers()
    }
    
    func fetchUsers() {
        service.fetchUsers { users in
            self.users = users
            
        }
    }
}
