import AVFoundation
import Speech

enum PermissionStatus {
    case granted
    case denied
    case notDetermined
}

@MainActor
final class PermissionManager: ObservableObject {
    @Published var microphoneStatus: PermissionStatus = .notDetermined
    @Published var speechStatus: PermissionStatus = .notDetermined

    var allGranted: Bool {
        microphoneStatus == .granted && speechStatus == .granted
    }

    func checkAll() {
        microphoneStatus = currentMicStatus()
        speechStatus = currentSpeechStatus()
    }

    func requestAll() async {
        await requestMicrophone()
        await requestSpeech()
    }

    // MARK: - Private

    private func currentMicStatus() -> PermissionStatus {
        switch AVAudioApplication.shared.recordPermission {
        case .granted:       return .granted
        case .denied:        return .denied
        case .undetermined:  return .notDetermined
        @unknown default:    return .notDetermined
        }
    }

    private func currentSpeechStatus() -> PermissionStatus {
        switch SFSpeechRecognizer.authorizationStatus() {
        case .authorized:           return .granted
        case .denied, .restricted:  return .denied
        case .notDetermined:        return .notDetermined
        @unknown default:           return .notDetermined
        }
    }

    private func requestMicrophone() async {
        let granted = await AVAudioApplication.requestRecordPermission()
        microphoneStatus = granted ? .granted : .denied
    }

    private func requestSpeech() async {
        await withCheckedContinuation { continuation in
            SFSpeechRecognizer.requestAuthorization { status in
                Task { @MainActor in
                    switch status {
                    case .authorized:           self.speechStatus = .granted
                    case .denied, .restricted:  self.speechStatus = .denied
                    default:                    self.speechStatus = .notDetermined
                    }
                    continuation.resume()
                }
            }
        }
    }
}
