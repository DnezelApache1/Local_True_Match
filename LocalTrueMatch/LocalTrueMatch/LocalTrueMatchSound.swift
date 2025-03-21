import UIKit
import SpriteKit
import AVFoundation

class LocalTrueMatchSound {
    private var LocalTrueMatchBackgroundAudio: AVAudioPlayer?
    
    static let shared = LocalTrueMatchSound()
    private init() {}
    
    private let LocalTrueMatchAudioQueue = DispatchQueue(label: "com.sound.audioQueue")
    
    func LocalTrueMatchPlayButtonPress() {
        if UserDefaults.standard.bool(forKey: "LocalTrueMatchVibro") {
            let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
            feedbackGenerator.impactOccurred()
        }
        
        if UserDefaults.standard.bool(forKey: "LocalTrueMatchSound") {
            DispatchQueue.global().async {
                guard let soundURL = Bundle.main.url(forResource: "LocalTrueMatchButton", withExtension: "wav") else { return }
                self.LocalTrueMatchAudioPlayer = try? AVAudioPlayer(contentsOf: soundURL)
                self.LocalTrueMatchAudioPlayer?.prepareToPlay()
                self.LocalTrueMatchAudioPlayer?.volume = 0.1
                self.LocalTrueMatchAudioPlayer?.play()
            }
        }
    }
    
    func LocalTrueMatchPlaySound() {
        if UserDefaults.standard.bool(forKey: "LocalTrueMatchSound") {
            DispatchQueue.global().async {
                guard let soundURL = Bundle.main.url(forResource: "LocalTrueMatchEnd", withExtension: "wav") else { return }
                self.LocalTrueMatchAudioPlayer = try? AVAudioPlayer(contentsOf: soundURL)
                self.LocalTrueMatchAudioPlayer?.prepareToPlay()
                self.LocalTrueMatchAudioPlayer?.play()
            }
        }
    }
    
    private var LocalTrueMatchAudioPlayer: AVAudioPlayer?
}

extension UIViewController {
    func LocalTrueMatchPlaySound() {
        LocalTrueMatchSound.shared.LocalTrueMatchPlaySound()
    }
    
    func LocalTrueMatchAddSound(to button: UIButton) {
        button.addTarget(self, action: #selector(LocalTrueMatchHandleButtonTouchDown(sender:)), for: .touchDown)
    }
    
    @objc private func LocalTrueMatchHandleButtonTouchDown(sender: UIButton) {
        LocalTrueMatchSound.shared.LocalTrueMatchPlayButtonPress()
    }
}
