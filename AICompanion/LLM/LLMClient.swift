import Foundation

protocol LLMClient {
    func respond(to input: String) async throws -> AssistantResponse
}
