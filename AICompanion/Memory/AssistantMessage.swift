import Foundation

enum MessageRole {
    case user
    case assistant
}

struct AssistantMessage: Identifiable {
    let id: UUID
    let role: MessageRole
    let text: String
    let timestamp: Date

    init(role: MessageRole, text: String) {
        self.id = UUID()
        self.role = role
        self.text = text
        self.timestamp = Date()
    }
}
