import Firebase
import FirebaseFirestoreSwift

struct StoriesService {

    // Upload story without an image
    func uploadStory(caption: String, completion: @escaping (Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        let data = ["uid": uid,
                    "caption": caption,
                    "likes": 0,
                    "saves": 0,
                    "timestamp": Timestamp(date: Date())] as [String: Any]

        Firestore.firestore().collection("posts").document()
            .setData(data) { error in
                if let error = error {
                    print("DEBUG: Failed to upload story \(error.localizedDescription)")
                    completion(false)
                    return
                }
                completion(true)
            }
    }

    // Upload story with an optional image URL
    func uploadStory(caption: String, imageUrl: String?, completion: @escaping (Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        var data: [String: Any] = [
            "uid": uid,
            "caption": caption,
            "likes": 0,
            "saves": 0,
            "timestamp": Timestamp(date: Date())
        ]

        if let imageUrl = imageUrl {
            data["imageUrl"] = imageUrl
        }

        Firestore.firestore().collection("posts").document()
            .setData(data) { error in
                if let error = error {
                    print("DEBUG: Failed to upload story with image \(error.localizedDescription)")
                    completion(false)
                    return
                }
                completion(true)
            }
    }

    // Fetch all stories
    func fetchStories(completion: @escaping ([Post]) -> Void) {
        Firestore.firestore().collection("posts")
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let posts = documents.compactMap { try? $0.data(as: Post.self) }
                completion(posts)
            }
    }

    // Fetch posts by user ID
    func fetchPosts(uid: String, completion: @escaping ([Post]) -> Void) {
        Firestore.firestore().collection("posts")
            .whereField("uid", isEqualTo: uid)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let posts = documents.compactMap { try? $0.data(as: Post.self) }
                completion(posts.sorted { $0.timestamp.dateValue() > $1.timestamp.dateValue() })
            }
    }

    // Like a story
    func likeStory(_ post: Post, completion: @escaping () -> Void) {
        guard let uid = Auth.auth().currentUser?.uid, let postId = post.id else { return }

        let userLikeRef = Firestore.firestore().collection("users").document(uid).collection("user-like")

        Firestore.firestore().collection("posts").document(postId)
            .updateData(["likes": post.likes + 1]) { _ in
                userLikeRef.document(postId).setData([:]) { _ in
                    completion()
                }
            }
    }

    // Unlike a story
    func unlikeStory(_ post: Post, completion: @escaping () -> Void) {
        guard let uid = Auth.auth().currentUser?.uid, let postId = post.id, post.likes > 0 else { return }

        let userLikeRef = Firestore.firestore().collection("users").document(uid).collection("user-like")

        Firestore.firestore().collection("posts").document(postId)
            .updateData(["likes": post.likes - 1]) { _ in
                userLikeRef.document(postId).delete { _ in
                    completion()
                }
            }
    }

    // Check if user liked a post
    func checkIfUserLikedPost(_ post: Post, completion: @escaping (Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid, let postId = post.id else { return }

        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-like")
            .document(postId).getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                completion(snapshot.exists)
            }
    }

    // Fetch liked posts for a specific user ID
    func fetchLikedPosts(forUid uid: String, completion: @escaping ([Post]) -> Void) {
        var posts = [Post]()

        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-like")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }

                documents.forEach { doc in
                    let postId = doc.documentID

                    Firestore.firestore().collection("posts")
                        .document(postId)
                        .getDocument { snapshot, _ in
                            guard let post = try? snapshot?.data(as: Post.self) else { return }
                            posts.append(post)

                            // Ensure the completion handler is called once all posts are fetched.
                            if posts.count == documents.count {
                                completion(posts)
                            }
                        }
                }
            }
    }
    
    // Save Story
    func SavePost(_ post: Post, completion: @escaping () -> Void) {
        guard let uid = Auth.auth().currentUser?.uid, let postId = post.id else { return }
        
        let userLikeRef = Firestore.firestore().collection("users").document(uid).collection("user-save")
        
        Firestore.firestore().collection("posts").document(postId)
            .updateData(["saves": post.saves + 1]) { _ in
                userLikeRef.document(postId).setData([:]) { _ in
                    completion()
                }
            }
    }
    
    //unSave Story
    func unSaveStory(_ post: Post, completion: @escaping () -> Void) {
        guard let uid = Auth.auth().currentUser?.uid, let postId = post.id, post.saves > 0 else { return }

        let userLikeRef = Firestore.firestore().collection("users").document(uid).collection("user-save")

        Firestore.firestore().collection("posts").document(postId)
            .updateData(["saves": post.saves - 1]) { _ in
                userLikeRef.document(postId).delete { _ in
                    completion()
                }
            }
    }
    
    // Save: check If User Saved Post
    func checkIfUserSavedPost(_ post: Post, completion: @escaping (Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid, let postId = post.id else { return }

        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-save")
            .document(postId).getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                completion(snapshot.exists)
            }
    }
    
    // fetchSavedPosts
    func fetchSavedPosts(forUid uid: String, completion: @escaping ([Post]) -> Void) {
        var posts = [Post]()

        Firestore.firestore().collection("users")
            .document(uid)
            .collection("user-save")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }

                documents.forEach { doc in
                    let postId = doc.documentID

                    Firestore.firestore().collection("posts")
                        .document(postId)
                        .getDocument { snapshot, _ in
                            guard let post = try? snapshot?.data(as: Post.self) else { return }
                            posts.append(post)

                            // Ensure the completion handler is called once all posts are fetched.
                            if posts.count == documents.count {
                                completion(posts)
                            }
                        }
                }
            }
    }
    
    // Delete Story 
    func deleteStory(_ post: Post, completion: @escaping () -> Void) {
        guard let uid = Auth.auth().currentUser?.uid, let postId = post.id else { return }
        
        Firestore.firestore().collection("posts").document(postId)
            .delete() { error in
                if let error = error {
                    print("DEBUG: Failed to delete story \(error.localizedDescription)")
                    completion()
                    return
                }
                completion()
            }
       
    }
    

    
}
