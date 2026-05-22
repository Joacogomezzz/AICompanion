# AICompanion MVP

App iOS SwiftUI con entrada y salida de voz. Compila en Codemagic via XcodeGen.

## Stack

- Swift 5.9 / SwiftUI
- iOS 17.0+
- Speech Framework (transcripción)
- AVSpeechSynthesizer (respuesta hablada)
- XcodeGen (generación del proyecto)
- Codemagic (CI/CD)

## Estructura

```
AICompanion/
├── App/               # Entry point y estado global (AssistantState)
├── UI/
│   ├── Screens/       # AssistantScreen
│   └── Components/    # VoiceOrbView, MessageBubble, PermissionWarningView, PrimaryButton
├── Voice/             # SpeechRecognizer, AudioSessionManager, VoiceOutputManager
├── LLM/               # LLMClient (protocolo), MockLLMClient, AssistantResponse
├── Memory/            # AssistantMessage, ConversationStore
├── Permissions/       # PermissionManager
├── Actions/           # (futuro) App Intents
├── Storage/           # (futuro) CoreData / SwiftData
└── Utilities/         # Helpers genéricos
```

## Build local (macOS con Xcode)

```bash
brew install xcodegen
xcodegen generate
open AICompanion.xcodeproj
```

## Build en Codemagic

El proyecto usa XcodeGen. El `codemagic.yaml` instala XcodeGen, genera el `.xcodeproj` y compila para simulador sin firma de código.

## Limitaciones: Simulador vs iPhone real

| Feature | Simulador | iPhone real |
|---|---|---|
| **Compilación** | ✅ Compila | ✅ Compila |
| **UI / navegación** | ✅ Funciona | ✅ Funciona |
| **AVSpeechSynthesizer** | ✅ Funciona (sin audio audible por defecto) | ✅ Funciona con audio |
| **Micrófono** | ❌ No disponible | ✅ Disponible |
| **SFSpeechRecognizer** | ⚠️ API disponible pero sin micrófono real | ✅ Funciona completo |
| **Permisos de micrófono** | ⚠️ El diálogo puede no aparecer | ✅ Diálogo nativo de iOS |
| **Reconocimiento offline** | ❌ Requiere red en simulador | ✅ Puede funcionar offline con modelos on-device |

**Conclusión:** el MVP de voz completo (escuchar → transcribir → responder hablando) requiere iPhone real. El simulador sirve para verificar compilación, UI y flujo de estados.

## Rama activa

`voice-mvp`
