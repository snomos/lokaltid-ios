# Linking the Rust Library

This document explains how to link the Rust library (`lokaltid.xcframework`) into the Xcode project.

## What's Been Done

1. ✅ Built the Rust library for all iOS targets (device + simulator)
2. ✅ Generated Swift bindings using UniFFI
3. ✅ Created `lokaltid.xcframework` in `Frameworks/` directory
4. ✅ Generated Swift bindings file: `Lokaltid/Generated/lokaltid.swift`

## What Needs to Be Done in Xcode

To complete the integration, you need to manually add the framework and generated Swift file to your Xcode project:

### Step 1: Add the Generated Swift File

1. Open `Lokaltid.xcodeproj` in Xcode
2. Right-click on the `Lokaltid` folder in the Project Navigator
3. Select **Add Files to "Lokaltid"...**
4. Navigate to `Lokaltid/Generated/`
5. Select `lokaltid.swift`
6. Make sure **"Copy items if needed"** is **UNCHECKED** (the file is already in the right place)
7. Make sure **"Add to targets: Lokaltid"** is **CHECKED**
8. Click **Add**

### Step 2: Add the XCFramework

1. Select the `Lokaltid` **project** (blue icon) in the Project Navigator
2. Select the `Lokaltid` **target** in the main editor
3. Go to the **"Frameworks, Libraries, and Embedded Content"** section
4. Click the **+** button
5. Click **"Add Other..."** → **"Add Files..."**
6. Navigate to the `Frameworks/` folder
7. Select `lokaltid.xcframework`
8. Click **Open**
9. In the added framework row, set **"Embed"** to **"Do Not Embed"** (it's a static library)

### Step 3: Configure Import Paths

The bridging header should already be configured by the XCFramework. If you get import errors:

1. Select the `Lokaltid` target
2. Go to **Build Settings**
3. Search for **"Import Paths"**
4. Under **Swift Compiler - Search Paths**, add:
   - `$(PROJECT_DIR)/Frameworks/lokaltid.xcframework/ios-arm64/Headers`
   - `$(PROJECT_DIR)/Frameworks/lokaltid.xcframework/ios-arm64_x86_64-simulator/Headers`

### Step 4: Build and Run

1. Select a simulator (e.g., iPhone 16 Pro)
2. Build and run (Cmd+R)
3. The app should now use the actual Rust library for solar time calculations!

## Verifying the Integration

Once linked, you can verify the integration:

1. The app should build without errors
2. In the Console, you shouldn't see any "using fallback implementation" messages
3. The solar time calculations should be more accurate (using proper astronomical algorithms)

## Files Overview

```
lokaltid-ios/
├── Frameworks/
│   └── lokaltid.xcframework/          # Rust library packaged for iOS
│       ├── ios-arm64/                 # Device (iPhone/iPad)
│       │   ├── liblokaltid.a
│       │   └── Headers/
│       │       ├── lokaltidFFI.h
│       │       └── module.modulemap
│       └── ios-arm64_x86_64-simulator/  # Simulator
│           ├── liblokaltid.a
│           └── Headers/
│               ├── lokaltidFFI.h
│               └── module.modulemap
├── Lokaltid/
│   ├── Generated/
│   │   └── lokaltid.swift             # Auto-generated Swift bindings
│   └── Services/
│       ├── LokaltidFFI.swift          # Wrapper with fallback
│       └── SolarTimeCalculator.swift  # Uses LokaltidFFI
└── lokaltid-rust/
    ├── src/                           # Rust source code
    ├── build-xcframework.sh           # Build script
    └── generate-bindings.rs           # Binding generator
```

## Troubleshooting

### "Module 'lokaltidFFI' not found"

- Make sure the XCFramework is added to **Frameworks, Libraries, and Embedded Content**
- Check that Import Paths are configured correctly in Build Settings

### "Cannot find 'MobileSolarTime' in scope"

- Make sure `Generated/lokaltid.swift` is added to the target
- Check that the file appears in the **Compile Sources** build phase

### Build fails with architecture errors

- Make sure you're building for a supported platform (iOS 18.0+)
- The XCFramework includes both device (arm64) and simulator (arm64 + x86_64) architectures

### Fallback implementation is still being used

- Check that `#if canImport(lokaltidFFI)` condition is true
- Look for build warnings about the framework
- Make sure the framework is not embedded (should be "Do Not Embed")

## Rebuilding the XCFramework

If you need to rebuild the XCFramework:

```bash
cd lokaltid-rust
./build-xcframework.sh
```

This will:
1. Build the Rust library for all targets
2. Generate Swift bindings
3. Create the XCFramework
4. Copy it to `../Frameworks/`

You don't need to re-add the framework in Xcode after rebuilding.
