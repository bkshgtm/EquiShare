import AVFoundation

class AudioManager {
    static let shared = AudioManager()
    
    private init() {}
    
    private var audioPlayer: AVAudioPlayer?
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "click", withExtension: "wav") else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Failed to play sound.")
        }
    }
}

