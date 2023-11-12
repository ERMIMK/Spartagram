//
//  VideoPlayerView.swift
//  Spartagram
//
//  Created by Ermiyas Mesfin on 11/6/23.
//

import SwiftUI
import AVKit

struct VideoPlayerView: UIViewRepresentable {
    var videoURL: URL

    func makeUIView(context: Context) -> UIView {
        // This method should return a UIView that will be the container for the AVPlayerLayer
        let view = UIView()

        // Configure the player with the video URL
        let player = AVPlayer(url: videoURL)
        player.actionAtItemEnd = .none

        // Create an AVPlayerLayer
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspect
        playerLayer.frame = view.bounds

        // Add it to the view's layer
        view.layer.addSublayer(playerLayer)
        
        // Play the video
        player.play()

        // Subscribe to the player item's didPlayToEndTime notification
        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main
        ) { _ in
            // Loop the video when it ends playing
            player.seek(to: CMTime.zero)
            player.play()
        }

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // Update the AVPlayerLayer frame in case the layout changes
        if let layer = uiView.layer.sublayers?.first as? AVPlayerLayer {
            layer.frame = uiView.bounds
        }
    }
}
