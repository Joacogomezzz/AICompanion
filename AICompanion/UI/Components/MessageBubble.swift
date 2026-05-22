import SwiftUI

struct MessageBubble: View {
    let message: AssistantMessage

    private var isUser: Bool { message.role == .user }

    var body: some View {
        HStack {
            if isUser { Spacer(minLength: 48) }

            Text(message.text)
                .font(.body)
                .foregroundColor(isUser ? .black : .white)
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(isUser ? Color.white : Color(white: 0.2))
                .cornerRadius(16)

            if !isUser { Spacer(minLength: 48) }
        }
    }
}

#Preview {
    VStack(spacing: 12) {
        MessageBubble(message: AssistantMessage(role: .user, text: "Hola, ¿cómo estás?"))
        MessageBubble(message: AssistantMessage(role: .assistant, text: "Entendido. Ya puedo escucharte y responderte en modo MVP."))
    }
    .padding()
    .background(Color.black)
}
