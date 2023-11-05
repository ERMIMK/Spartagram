//
//  UploadStoryViewModel.swift
//  Spartagram
//
//  Created by Ermiyas Mesfin on 10/26/23.
//

import Foundation

class UploadStoryViewModel: ObservableObject {
    
    @Published var didUploadStory = false
    let service = StoriesService()
    
    func uploadStory(withCaption caption: String, imageUrl: String?) {
        service.uploadStory(caption: caption, imageUrl: imageUrl) { success in
            if success {
                self.didUploadStory = true
            } else {
                // handle the error scenario
            }
        }
    }
}
