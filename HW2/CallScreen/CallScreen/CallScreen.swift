//
//  ViewController.swift
//  CallScreen
//
//  Created by Mereke on 02.04.2023.
//

import SwiftUI

struct EndpointLabel: View {
    var displayName: String

    var body: some View {
        Text(displayName)
            .font(.largeTitle)
            .fontWeight(.regular)
            .padding(.top, 36)
    }
}

struct CircleButtonWithLabel: View {
    var label: String
    var systemName: String

    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .foregroundColor(.white)
                    .opacity(0.1)
                    .frame(width: 80, height: 80)
                Image(systemName: systemName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 32, height: 32)
                    .foregroundColor(.white)
                    .opacity(0.9)
            }

            Text(label)
                .font(.caption)
        }
    }
}


struct LabelWithTimer: View {
    var duration: TimeInterval

    var body: some View {
        VStack {

            Text(String(format: "%.0f:%02.0f", duration/60, duration.truncatingRemainder(dividingBy: 60)))
                .font(.title3)
                .fontWeight(.light)
                .opacity(0.8)
        }
    }
}

struct SpeakerboxView: View {

    var body: some View {
        ZStack {
            Image("bg")
                .resizable()
                .edgesIgnoringSafeArea(.all)

            VStack {
                EndpointLabel(displayName: "Mereke Atrauov")
                LabelWithTimer(duration: 0)

                Spacer()

                HStack(spacing: 24) {
                    CircleButtonWithLabel(label: "mute", systemName: "mic.slash.fill")
                    CircleButtonWithLabel(label: "keypad", systemName: "circle.grid.3x3.fill")
                    CircleButtonWithLabel(label: "speaker", systemName: "speaker.wave.2.fill")
                }
                .padding(.bottom, 24)

                HStack(spacing: 24) {
                    CircleButtonWithLabel(label: "add call", systemName: "plus")
                    CircleButtonWithLabel(label: "FaceTime", systemName: "video.fill")
                    CircleButtonWithLabel(label: "contacts", systemName: "person.crop.circle")
                }
                .padding(.bottom, 96)

                HStack {
                    Spacer()
                    ZStack {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 90, height: 80)
                            .overlay(
                                Circle()
                                    .strokeBorder(Color.white, lineWidth: 0)
                                    .frame(width: 64, height: 64)
                            )
                        Image(systemName: "phone.down.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 36, height: 36)
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
            }
            .padding(.bottom, 96)
        }
        .foregroundColor(.white)
    }
}

struct ContentView: View {
    var body: some View {
        SpeakerboxView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
