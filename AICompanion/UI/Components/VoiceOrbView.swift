import SwiftUI

struct VoiceOrbView: View {
    let state: AssistantState
    let action: () -> Void

    private var orbColor: Color {
        switch state {
        case .idle:          return .white
        case .listening:     return .red
        case .transcribing:  return .orange
        case .thinking:      return .blue
        case .speaking:      return .green
        case .error:         return .gray
        }
    }

    private var isPulsing: Bool {
        state.isActive
    }

    var body: some View {
        Button(action: action) {
            ZStack {
                if isPulsing {
                    Circle()
                        .fill(orbColor.opacity(0.3))
                        .frame(width: 100, height: 100)
                        .scaleEffect(isPulsing ? 1.25 : 1.0)
                        .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: isPulsing)
                }

                Circle()
                    .fill(orbColor)
                    .frame(width: 72, height: 72)

                Image(systemName: iconName)
                    .font(.system(size: 26, weight: .semibold))
                    .foregroundColor(.black)
            }
        }
        .buttonStyle(.plain)
    }

    private var iconName: String {
        switch state {
        case .idle:          return "mic"
        case .listening:     return "stop.fill"
        case .transcribing:  return "waveform"
        case .thinking:      return "ellipsis"
        case .speaking:      return "speaker.wave.2.fill"
        case .error:         return "exclamationmark.triangle"
        }
    }
}

#Preview {
    VStack(spacing: 24) {
        VoiceOrbView(state: .idle) {}
        VoiceOrbView(state: .listening) {}
        VoiceOrbView(state: .speaking) {}
    }
    .padding()
    .background(Color.black)
}
