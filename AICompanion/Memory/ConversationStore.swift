import Foundation

@MainActor
final class ConversationStore: ObservableObject {
    @Published private(set) var messages: [AssistantMessage] = []

    func add(_ message: AssistantMessage) {
        messages.append(message)
    }

    func clear() {
        messages.removeAll()
    }
}
