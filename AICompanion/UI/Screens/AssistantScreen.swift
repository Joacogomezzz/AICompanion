import SwiftUI

struct AssistantScreen: View {
    @EnvironmentObject private var appState: AppState

    @StateObject private var permissions = PermissionManager()
    @StateObject private var speechRecognizer = SpeechRecognizer()
    @StateObject private var voiceOutput = VoiceOutputManager()
    @StateObject private var conversation = ConversationStore()

    private let llm: LLMClient = MockLLMClient()

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 0) {
                header

                if permissions.microphoneStatus == .denied || permissions.speechStatus == .denied {
                    Spacer()
                    PermissionWarningView()
                    Spacer()
                } else {
                    messageList
                    liveTranscriptBanner
                    controls
                }
            }
        }
        .task {
            permissions.checkAll()
        }
    }

    // MARK: - Subviews

    private var header: some View {
        VStack(spacing: 4) {
            Text("AICompanion MVP")
                .font(.title2).bold()
                .foregroundColor(.white)
            Text(appState.assistantState.label)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(.top, 56)
        .padding(.bottom, 12)
    }

    private var messageList: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(conversation.messages) { msg in
                        MessageBubble(message: msg)
                            .padding(.horizontal, 16)
                            .id(msg.id)
                    }
                }
                .padding(.vertical, 12)
            }
            .onChange(of: conversation.messages.count) { _, _ in
                if let last = conversation.messages.last {
                    withAnimation { proxy.scrollTo(last.id, anchor: .bottom) }
                }
            }
        }
    }

    @ViewBuilder
    private var liveTranscriptBanner: some View {
        if appState.assistantState == .listening, !speechRecognizer.transcript.isEmpty {
            Text(speechRecognizer.transcript)
                .font(.footnote)
                .foregroundColor(.white.opacity(0.7))
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(white: 0.12))
        }
    }

    private var controls: some View {
        VStack(spacing: 20) {
            VoiceOrbView(state: appState.assistantState, action: handleOrbTap)
                .padding(.bottom, 8)
        }
        .padding(.bottom, 48)
    }

    // MARK: - Logic

    private func handleOrbTap() {
        switch appState.assistantState {
        case .listening:
            stopAndProcess()
        case .idle, .error:
            startListening()
        default:
            break
        }
    }

    private func startListening() {
        Task {
            if !permissions.allGranted {
                await permissions.requestAll()
                guard permissions.allGranted else { return }
            }

            do {
                appState.assistantState = .listening
                try speechRecognizer.startListening()
            } catch {
                appState.assistantState = .error(error.localizedDescription)
            }
        }
    }

    private func stopAndProcess() {
        speechRecognizer.stopListening()
        let userText = speechRecognizer.transcript.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !userText.isEmpty else {
            appState.assistantState = .idle
            return
        }

        Task {
            appState.assistantState = .transcribing
            conversation.add(AssistantMessage(role: .user, text: userText))

            appState.assistantState = .thinking
            do {
                let response = try await llm.respond(to: userText)
                conversation.add(AssistantMessage(role: .assistant, text: response.text))

                appState.assistantState = .speaking
                voiceOutput.speak(response.text) {
                    appState.assistantState = .idle
                }
            } catch {
                appState.assistantState = .error(error.localizedDescription)
            }
        }
    }
}

#Preview {
    AssistantScreen()
        .environmentObject(AppState())
}
