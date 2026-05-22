import Foundation

enum AssistantState: Equatable {
    case idle
    case listening
    case transcribing
    case thinking
    case speaking
    case error(String)

    var label: String {
        switch self {
        case .idle:          return "Listo"
        case .listening:     return "Escuchando..."
        case .transcribing:  return "Transcribiendo..."
        case .thinking:      return "Pensando..."
        case .speaking:      return "Hablando..."
        case .error(let msg): return "Error: \(msg)"
        }
    }

    var isActive: Bool {
        switch self {
        case .idle, .error: return false
        default:            return true
        }
    }
}

@MainActor
final class AppState: ObservableObject {
    @Published var assistantState: AssistantState = .idle
    @Published var isSessionActive: Bool = false
}
