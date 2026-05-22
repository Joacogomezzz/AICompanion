import SwiftUI

struct PermissionWarningView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "mic.slash.fill")
                .font(.system(size: 40))
                .foregroundColor(.orange)

            Text("Permisos requeridos")
                .font(.headline)
                .foregroundColor(.white)

            Text("AICompanion necesita acceso al micrófono y al reconocimiento de voz para funcionar.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)

            Button("Abrir Configuración") {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }
            .font(.subheadline.weight(.semibold))
            .foregroundColor(.black)
            .padding(.horizontal, 24)
            .padding(.vertical, 10)
            .background(Color.white)
            .cornerRadius(10)
        }
        .padding(24)
        .background(Color(white: 0.12))
        .cornerRadius(20)
        .padding(.horizontal, 32)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        PermissionWarningView()
    }
}
