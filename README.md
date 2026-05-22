# AICompanion MVP

App iOS SwiftUI minimalista. Base de compilación verificada en Codemagic.

## Stack

- Swift 5.9 / SwiftUI
- iOS 17.0+
- XcodeGen (generación del proyecto)
- Codemagic (CI/CD)

## Estructura

```
AICompanion/
├── App/               # Entry point y estado global
├── UI/
│   ├── Screens/       # Pantallas
│   └── Components/    # Componentes reutilizables
├── Voice/             # (futuro) AVFoundation / Speech
├── LLM/               # (futuro) Integración con modelos
├── Actions/           # (futuro) App Intents
├── Memory/            # (futuro) Persistencia de contexto
├── Permissions/       # (futuro) Manejo de permisos
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

El proyecto usa XcodeGen. El `codemagic.yaml` instala XcodeGen, genera el `.xcodeproj` y compila para simulador.

No se requiere firma de código para la verificación de compilación inicial.

## Rama activa

`mvp-minimal-ios-app`
