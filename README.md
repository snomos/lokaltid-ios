# Soltid - iOS App

Ein iOS-app som viser både **soltid** og **standardtid** samtidig på ei tradisjonell analog urskive.

## 🌞 Kva er soltid?

Soltid er eit tidssystem der klokka 12:00 alltid er når sola står i sør (på den lokale meridianen). Dette er forskjellig frå standardtidssoner som er faste regionar.

Utrekninga er basert på lengdegrad:
- Kvar 15° lengdegrad = 1 time forskjell
- Kvar 1° lengdegrad = 4 minutt forskjell

## ⌚️ Funksjonar

- **Analog urskive** med to sett visarar:
  - **Kvite visarar**: Viser soltid
  - **Gråe visarar**: Viser standardtid (systemtid)
- **GPS-basert berekningar**: Appen bruker di noverande posisjon til å berekna soltid
- **Realtidsoppdatering**: Begge klokkene oppdaterer seg kvar sekund
- **Visuell info**: Viser offset mellom soltid og standardtid
- **Posisjonsinformasjon**: Viser koordinatane som vert brukt

## 📱 Skjermbilete

Appen viser:
- Ei stor analog urskive med to sett visarar
- Digital visning av begge tider nedanfor urskiva
- Offset mellom soltid og standardtid
- Dine GPS-koordinatar

## 🔐 Løyve

Appen treng berre **posisjonslgløyve** (GPS):
- Brukaren vel sjølv mellom "Omtrentleg" eller "Eksakt" posisjon
- Ingen andre løyve er nødvendig
- Ingen nettverkstilkopling krevd (alle utrekningar skjer lokalt)

## Prosjektstruktur

```
lokaltid-ios/
├── Soltid.xcodeproj/          # Xcode-prosjektfil
├── Soltid/                     # Hovudkatalogen for appkoden
│   ├── SoltidApp.swift        # App entry point
│   ├── ContentView.swift        # Hovudvisning med urskive
│   ├── Models/
│   │   └── Location.swift       # Geografisk posisjon
│   ├── Views/
│   │   └── AnalogClockView.swift # Analog urskive med to sett visarar
│   ├── ViewModels/
│   │   └── ClockViewModel.swift  # State og tidsoppdateringar
│   ├── Services/
│   │   ├── LocationManager.swift     # GPS-håndtering
│   │   └── SolarTimeCalculator.swift # Soltidsberekningar
│   └── Assets.xcassets/         # Bilder og fargeressursar
├── README.md
└── PLAN.md
```

## Teknologi

- **Platform:** iOS 18.0+
- **Språk:** Swift 6.0
- **Framework:** SwiftUI med @Observable
- **Lokasjon:** CoreLocation
- **IDE:** Xcode 16.2

## Implementasjon

Appen består av fleire hovudkomponentar:

## Implementasjon

Appen består av fleire hovudkomponentar:

### 1. Models
- **Location**: Representerer geografisk posisjon (latitude, longitude)

### 2. Services
- **LocationManager**: Handterer GPS-posisjon via CoreLocation
- **SolarTimeCalculator**: Bereknar soltid basert på lengdegrad

### 3. Views
- **AnalogClockView**: Analog urskive med to sett visarar
  - Kvite visarar for soltid
  - Gråe visarar for standardtid
  - Time-, minutt- og sekundvisarar
  - Timetall og minutt-markeringar

### 4. ViewModels
- **ClockViewModel**: Handterer tidsoppdateringar og state
  - Timer som oppdaterer kvar sekund
  - Integrerer LocationManager
  - Bereknar soltid kontinuerleg

### 5. UI-struktur
```
ContentView
├── Gradient bakgrunn
├── AnalogClockView (hovudklokke)
├── Digital tidsvisning (begge tider)
├── Offset-informasjon
└── Posisjonsinformasjon
```

## 🧮 Soltidsberekningar

Noverande implementasjon bruker ein forenkla algoritme:
```
offset_seconds = (longitude / 15.0) * 3600.0
solar_time = standard_time + offset_seconds
```

### Framtidig forbetring
For meir presis soltid kan ein integrera [soltid Rust-biblioteket](https://github.com/snomos/soltid) som støttar:
- Høgare presisjon (ned til boge-sekund)
- "Equation of time" for ekstra nøyaktigheit
- Automatisk genererte Swift bindings via UniFFI

## Korleis opna prosjektet

1. Opna terminalen
2. Naviger til prosjektmappa:
   ```bash
   cd /Users/smo036/gitlangtech/lokaltid-ios
   ```
3. Opna prosjektet i Xcode:
   ```bash
   open Soltid.xcodeproj
   ```

## Bygging og køyring

1. Opna `Soltid.xcodeproj` i Xcode
2. Vel ein simulator eller fysisk einheit
3. Trykk Cmd+R for å byggja og køyra appen
4. Godta posisjonslgløyve når appen spør

**Merk:** På simulatoren må du setja ein posisjon:
- Features → Location → Custom Location (t.d. Bergen: 60.39299, 5.323333)

## Status

✅ Prosjektstruktur oppretta  
✅ LocationManager implementert
✅ SolarTimeCalculator implementert
✅ Analog urskive med to sett visarar
✅ ClockViewModel med realtidsoppdatering
✅ ContentView med full UI
✅ Posisjonslgløyve konfigurert

## Moglege utvidingar

- 🦀 Integrera Rust-biblioteket for høgare presisjon
- 📊 Visualisering av solvegen gjennom dagen
- 🌍 Støtte for "equation of time"
- ⌚️ Apple Watch companion app
- 🎨 Tilpassa urskivedesign og fargar
- 📍 Lagra favorittplassar
- 🌓 Visualisering av soloppgang/solnedgang

## Lisens

Privat prosjekt - gitlangtech
