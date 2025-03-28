import SwiftUI
import CoreML
import AVFoundation

class LoadingViewModel: ObservableObject{
    var coordinator: NavigationCoordinator 
    let finalSentence: String
    
    // Add these:
    var moodFile: String = ""
    var ambienceFile: String = ""
       
    init(coordinator: NavigationCoordinator, finalSentence:String) {
        self.coordinator = coordinator 
        self.finalSentence = finalSentence
    }
    
    func prepareMusic() {
        print("About to classify finalSentence: \(finalSentence)")
        
        guard let predictedMood = classifyMoodText() else {
            print("moood for: \(finalSentence)")
            return
        }
        // 2) Convert that mood to track filenames
        moodFile = fileNameForMood(predictedMood)
        ambienceFile = parseEnvironment(from: finalSentence)
    }
    
    func classifyMoodText() -> String? {
        do {
            let input = MoodfulMusicMLInput(text: finalSentence)
            
            let model = try MoodfulMusicML(configuration: .init())
            let output = try model.prediction(input: input)
            
            return output.label
            
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    /// Map the ML-predicted mood to the correct melody filename.
    private func fileNameForMood(_ mood: String) -> String {
        switch mood {
        case "Adventurous":
            return "adventurous-melody"
        case "Calm":
            return "calm-melody"
        case "Energetic":
            return "energetic-melody"
        case "Joyful":
            return "joyful-melody"
        case "Sad":
            return "sad-melody"
        case "Reflective":
            return "reflective-melody"
        case "Moody":
            return "moody-melody"
        case "Mystical":
            return "mystical-melody"
        default:
            return "generic-melody"
        }
    }
   
    private func parseEnvironment(from sentence: String) -> String {
        let lower = sentence.lowercased()
        if lower.contains("jungle") {
            return "jungle-ambience"
        } else if lower.contains("mountain") {
            return "mountain-ambience"
        } else if lower.contains("desert") {
            return "desert-ambience"
        } else if lower.contains("garden") {
            return "garden-ambience"
        } else if lower.contains("lake") {
            return "lake-ambience"
        } else if lower.contains("rain") {
            return "rain-ambience"
        } else if lower.contains("stadium") {
            return "stadium-ambience"
        } else if lower.contains("city streets") {
            return "city-ambience"
        }
        return "none"
    }
}
