//
//  CallViewController.swift
//  AccountScrollView
//
//  Created by Mereke on 30.03.2023.
//

import SwiftUI

struct CallViewController: View {

    @State private var isMuted = false
    @State private var isSpeakerOn = false
    @State private var isKeypadShown = false

    var body: some View {
        VStack(spacing: 0) {
            // Contact Name and Timer
            HStack(alignment: .center, spacing: 16) {
                Text("John Doe")
                    .font(.title)
                    .bold()
                Spacer()
                Text("00:00")
                    .font(.headline)
            }
            .padding(.vertical, 32)
            .padding(.horizontal, 24)

            // Keypad
            if isKeypadShown {
                Text("Keypad")
            }

            // Buttons
            HStack(spacing: 32) {
                Button(action: {
                    // Mute action
                    isMuted.toggle()
                }) {
                    Image(systemName: isMuted ? "mic.slash.fill" : "mic.fill")
                }

                Button(action: {
                    // Speaker action
                    isSpeakerOn.toggle()
                }) {
                    Image(systemName: isSpeakerOn ? "speaker.wave.3.fill" : "speaker.wave.1.fill")
                }

                Button(action: {
                    // Keypad action
                    isKeypadShown.toggle()
                }) {
                    Image(systemName: "phone.circle.fill")
                }

                Button(action: {
                    // Add call action
                }) {
                    Image(systemName: "plus.circle.fill")
                }
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 16)

            HStack(spacing: 32) {
                Button(action: {
                    // FaceTime action
                }) {
                    Image(systemName: "video.circle.fill")
                }

                Button(action: {
                    // Contacts action
                }) {
                    Image(systemName: "person.crop.circle.fill")
                }

                Button(action: {
                    // Stop call action
                }) {
                    Image(systemName: "phone.down.circle.fill")
                }
            }
            .padding(.horizontal, 32)
        }
    }
}

struct CallViewController_Previews: PreviewProvider {
    static var previews: some View {
        CallViewController()
    }
}


