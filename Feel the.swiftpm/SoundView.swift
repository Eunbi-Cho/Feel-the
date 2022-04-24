//
//  File.swift
//  Feel the
//
//  Created by 조은비 on 2022/04/24.
//

import SwiftUI
import UIKit
import AVKit

class SoundManager {
    
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    enum SoundOption: String {
        case come
        case go
    }
    
    func playSound(sound: SoundOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else { return }
        do {
        player = try AVAudioPlayer(contentsOf: url)
        player?.play()
        } catch let error {
            print("Error playing sound. \(error.localizedDescription)")
        }
    }
}

class ProximityObserver {
    @objc func didChange(notification: NSNotification) {
        print("MyView::ProximityObserver.didChange")
//        if let device = notification.object as? UIDevice {
        var device = notification.object as? UIDevice
        if device!.proximityState == true {
            SoundManager.instance.playSound(sound: .go)
        }else {
            SoundManager.instance.playSound(sound: .come)
        }
    }
//        @objc func didProximityChange(notification: NSNotification) {
//            if UIDevice.current.proximityState == true {
//                SoundManager.instance.playSound(sound: .go)
//            }else {
//                SoundManager.instance.playSound(sound: .come)
//            }
//        }
    
}



struct SoundView: View {
    @Environment(\.presentationMode) var presentationMode
    var proximityObserver = ProximityObserver()
    
    func activateProximitySensor() {
        SoundManager.instance.playSound(sound: .come)
        UIDevice.current.isProximityMonitoringEnabled = true
        
        if UIDevice.current.isProximityMonitoringEnabled {
            NotificationCenter.default.addObserver(proximityObserver,
                selector: #selector(proximityObserver.didChange),
                name: UIDevice.proximityStateDidChangeNotification,
                object: UIDevice.current)

        }
    }
    
    func deactivateProximitySensor() {
        SoundManager.instance.playSound(sound: .go)
        UIDevice.current.isProximityMonitoringEnabled = false
        NotificationCenter.default.removeObserver(proximityObserver,
                    name: UIDevice.proximityStateDidChangeNotification,
                    object: UIDevice.current)
    }


    
    var body: some View {
        NavigationView{
        ZStack{
            Color(.white)
                .ignoresSafeArea()
            VStack {
                Text("Come Closer")
                        .onAppear() {
                            self.activateProximitySensor()
    //                        SoundManager.instance.playSound(sound: .come)
    //                    }.onDisappear() {
    //                        SoundManager.instance.playSound(sound: .go)
    //                        self.deactivateProximitySensor()
                    }
                Spacer()
            }
        }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(trailing: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "xmark")
                .foregroundColor(.black)
        }
    ))
    }
}
