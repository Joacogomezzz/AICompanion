import SwiftUI

struct AssistantScreen: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 24) {
                Spacer()

                Text("AICompanion MVP")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Text("Asistente IA por voz")
                    .font(.title3)
                    .foregroundColor(.gray)

                Spacer()

                PrimaryButton(title: "Iniciar") {
                    appState.isSessionActive = true
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 48)
            }
        }
    }
}

#Preview {
    AssistantScreen()
        .environmentObject(AppState())
}
