import SwiftUI
import AVFoundation

@Observable
class MusicViewModel {
    var coordinator: NavigationCoordinator
    var isPlaying = false
    var showThankYouMessage: Bool = false
    let moodTrack: String
    let ambienceTrack: String
    private var moodPlayer: AVAudioPlayer?
    private var ambiencePlayer: AVAudioPlayer?
    private var moodFadeTimer: Timer?
    private var ambienceFadeTimer: Timer?
    private let fadeDuration: TimeInterval = 3.0
    private let totalAllowedPlayTime: TimeInterval = 30.0
    private var cumulativePlayTime: TimeInterval = 0.0
    private var lastResumeTime: Date?
    private var playTimer: Timer?
    
    
    init(coordinator: NavigationCoordinator, moodTrack: String, ambienceTrack: String) {
        self.coordinator = coordinator 
        self.moodTrack = moodTrack
        self.ambienceTrack = ambienceTrack
    }
    
    func titleForMood () -> String{
        switch moodTrack {
        case "adventurous-melody":
            return "Embrace the adventure!"
        case "calm-melody":
            return "Take a deep breath, unwind..."
        case "energetic-melody":
            return "Feel the energy surging!"
        case "joyful-melody":
            return "Let the joy lift you up!"
        case "sad-melody":
            return "It’s okay to feel blue sometimes."
        case "reflective-melody":
            return "Pause and reflect..."
        case "moody-melody":
            return "Ride the emotional waves..."
        case "mystical-melody":
            return "Enter a realm of wonder..."
        default:
            return "Relax, take a deep breath"
        }
    }
    
    func startMusic() {
        // Stop any existing playback
        stopMusic(resetCumulative: true)
        
        cumulativePlayTime = 0.0
        lastResumeTime = Date()
        
        if let moodURL = Bundle.main.url(forResource: moodTrack, withExtension: "mp3") {
            do {
                moodPlayer = try AVAudioPlayer(contentsOf: moodURL)
                // Instead of starting at full volume, start at 0 and fade in:
                moodPlayer?.volume = 0.0
                moodPlayer?.numberOfLoops = 0
                moodPlayer?.play()
               fadeInMood(player: moodPlayer, targetVolume: 1.0, duration: fadeDuration)
            } catch {
                print("Failed to play mood track: \(error)")
            }
        } else {
            print("Mood track not found: \(moodTrack).mp3")
        }
        
        if ambienceTrack != "none",
           let ambienceURL = Bundle.main.url(forResource: ambienceTrack, withExtension: "mp3") {
            do {
                ambiencePlayer = try AVAudioPlayer(contentsOf: ambienceURL)
                ambiencePlayer?.volume = 0.0
                ambiencePlayer?.numberOfLoops = 0
                ambiencePlayer?.play()
                fadeInAmbience(player: ambiencePlayer, targetVolume: 0.3, duration: fadeDuration)            } catch {
                print("Failed to play ambience track: \(error)")
            }
        } else {
            print("Ambience track not found or 'none': \(ambienceTrack).mp3")
        }
        
        isPlaying = true
        // Schedule timer for the full 30 seconds
        scheduleTimer(for: totalAllowedPlayTime)
    }
    
    // Resumes music playback from where it left off without restarting the cumulative counter
    func resumeMusic() {
        guard !isPlaying else { return }
        
        lastResumeTime = Date()
        moodPlayer?.play()
        ambiencePlayer?.play()
        isPlaying = true
        
        // Calculate remaining time from the cumulative play time
        let remainingTime = totalAllowedPlayTime - cumulativePlayTime
        scheduleTimer(for: remainingTime)
    }
    
    func pauseMusic() {
        guard isPlaying else { return }
        
        moodPlayer?.pause()
        ambiencePlayer?.pause()
        isPlaying = false
        
        if let lastStart = lastResumeTime {
            cumulativePlayTime += Date().timeIntervalSince(lastStart)
        }
        invalidateTimer()
    }
    
    func stopMusic(resetCumulative: Bool = false) {
        
        fadeOutMood(player: moodPlayer, duration: fadeDuration) { [weak self] in
            self?.moodPlayer = nil
        }
        fadeOutAmbience(player: ambiencePlayer, duration: fadeDuration) { [weak self] in
            self?.ambiencePlayer = nil
        }
        
        isPlaying = false
        invalidateTimer()
        
        if resetCumulative {
            cumulativePlayTime = 0.0
        } else {
            if let lastStart = lastResumeTime, !isPlaying {
                cumulativePlayTime += Date().timeIntervalSince(lastStart)
            }
        }
    }
    
    private func autoStopMusic() {
        // Stop the music (with resetting cumulative play time)
        stopMusic(resetCumulative: true)
        withAnimation(.easeIn(duration: 1)) {
            showThankYouMessage = true
        }
    }
    
    private func scheduleTimer(for seconds: TimeInterval) {
        invalidateTimer()
        playTimer = Timer.scheduledTimer(withTimeInterval: seconds, repeats: false) { [weak self] _ in
            self?.autoStopMusic()
        }
    }
    
    private func invalidateTimer() {
        playTimer?.invalidate()
        playTimer = nil
    }
    
    func skipForward5s() {
        guard let moodPlayer = moodPlayer else { return }
        moodPlayer.currentTime = min(moodPlayer.currentTime + 5, totalAllowedPlayTime)
        if let ambiencePlayer = ambiencePlayer {
            ambiencePlayer.currentTime = min(ambiencePlayer.currentTime + 5, totalAllowedPlayTime)
        }
    }
    
    func skipBackward5s() {
        guard let moodPlayer = moodPlayer else { return }
        moodPlayer.currentTime = max(moodPlayer.currentTime - 5, 0)
        if let ambiencePlayer = ambiencePlayer {
            ambiencePlayer.currentTime = max(ambiencePlayer.currentTime - 5, 0)
        }
    }
    
    private func fadeInMood(player: AVAudioPlayer?, targetVolume: Float, duration: TimeInterval) {
        guard let player = player else { return }
        player.volume = 0.0
        let steps = 20.0
        let interval = duration / steps
        let volumeIncrement = targetVolume / Float(steps)
        var currentStep = 0
        
        moodFadeTimer?.invalidate()
        moodFadeTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
            currentStep += 1
            let newVolume = min(Float(currentStep) * volumeIncrement, targetVolume)
            player.volume = newVolume
            if currentStep >= Int(steps) {
                timer.invalidate()
            }
        }
    }
    
    private func fadeOutMood(player: AVAudioPlayer?, duration: TimeInterval, completion: (() -> Void)? = nil) {
        guard let player = player else {
            completion?()
            return
        }
        let steps = 20.0
        let interval = duration / steps
        let volumeDecrement = player.volume / Float(steps)
        var currentStep = 0
        
        moodFadeTimer?.invalidate()
        moodFadeTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
            currentStep += 1
            let newVolume = max(player.volume - volumeDecrement, 0)
            player.volume = newVolume
            if currentStep >= Int(steps) {
                timer.invalidate()
                player.stop()
                player.currentTime = 0
                completion?()
            }
        }
    }
    
    // MARK: - Fade Functions for Ambience
    
    private func fadeInAmbience(player: AVAudioPlayer?, targetVolume: Float, duration: TimeInterval) {
        guard let player = player else { return }
        player.volume = 0.0
        let steps = 20.0
        let interval = duration / steps
        let volumeIncrement = targetVolume / Float(steps)
        var currentStep = 0
        
        ambienceFadeTimer?.invalidate()
        ambienceFadeTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
            currentStep += 1
            let newVolume = min(Float(currentStep) * volumeIncrement, targetVolume)
            player.volume = newVolume
            if currentStep >= Int(steps) {
                timer.invalidate()
            }
        }
    }
    
    private func fadeOutAmbience(player: AVAudioPlayer?, duration: TimeInterval, completion: (() -> Void)? = nil) {
        guard let player = player else {
            completion?()
            return
        }
        let steps = 20.0
        let interval = duration / steps
        let volumeDecrement = player.volume / Float(steps)
        var currentStep = 0
        
        ambienceFadeTimer?.invalidate()
        ambienceFadeTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
            currentStep += 1
            let newVolume = max(player.volume - volumeDecrement, 0)
            player.volume = newVolume
            if currentStep >= Int(steps) {
                timer.invalidate()
                player.stop()
                player.currentTime = 0
                completion?()
            }
        }
    }
}
