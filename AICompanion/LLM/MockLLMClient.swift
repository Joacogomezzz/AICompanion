import Foundation

final class MockLLMClient: LLMClient {
    func respond(to input: String) async throws -> AssistantResponse {
        // Simulates network latency for realistic UX testing
        try await Task.sleep(nanoseconds: 800_000_000)
        return AssistantResponse(text: "Entendido. Ya puedo escucharte y responderte en modo MVP.")
    }
}
