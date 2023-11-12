//
//  StoryRowViewModel.swift
//  Spartagram
//
//  Created by Ermiyas Mesfin on 10/26/23.
//

import Foundation

class StoryRowViewModel: ObservableObject {

    @Published var post: Post
    private let service = StoriesService()


    
    init(post: Post) {
        self.post = post
        
        checkIfUserLikedPost()
        checkIfUserSavedPost()
    }
    
    // Timestamp converstion
    func timeElapsedSinceDate(_ date: Date) -> String {
        let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date, to: Date())
        
        if let year = interval.year, year > 0 {
            return year == 1 ? "\(year) y" : "\(year) y"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "\(month) m" : "\(month) m"
        } else if let day = interval.day, day > 0 {
            return day == 1 ? "\(day) d" : "\(day) d"
        } else if let hour = interval.hour, hour > 0 {
            return hour == 1 ? "\(hour) hr ago" : "\(hour) hr ago"
        } else if let minute = interval.minute, minute > 0 {
            return minute == 1 ? "\(minute) min ago" : "\(minute) min ago"
        } else if let second = interval.second, second > 30 {
            return "\(second) seconds ago"
        } else {
            return "Just now"
        }
    }

    // Like Story function
    func likeStory() {
        service.likeStory(post) {
            self.post.didLike = true
        }
    }
    
    // Unlike Story function
    func unlikeStory() {
        service.unlikeStory(post) {
            self.post.didLike = false
        }
    }
    
    // Check If User Liked Post
    func checkIfUserLikedPost() {
        service.checkIfUserLikedPost(post) { didLike in
            if didLike {
                self.post.didLike = true
            }
        }
    }
    
    // save post
    func SavePost() {
        service.SavePost(post){
            self.post.didSave = true
        }
    }
    
    // unsave a post
    func unSavePost() {
        service.unSaveStory(post){
            self.post.didSave = false
        }
    }
    
    // Check if user Saved post
    func checkIfUserSavedPost() {
        service.checkIfUserSavedPost(post) { didSave in
            if didSave {
                self.post.didSave = true
            }
        }
    }
    
    // Delete Story
    func deleteStory() {
        service.deleteStory(post){
            print("DEBUG: Successfully deleted")
        }
    }
    
}
