# Brukarguide - Lokaltid

## Oppstart

Når du startar appen første gong, vil den be om tilgang til di posisjon. Du kan velja mellom:
- **Omtrentleg posisjon**: Gjev appen ein tilnærma posisjon (nøyaktig nok for soltidsberekningar)
- **Eksakt posisjon**: Gjev full GPS-presisjon

## Hovudskjerm

### Urskiva
Det sentrale elementet er ei analog urskive med **to sett visarar**:

#### Kvite visarar (Soltid)
- **Timevisar**: Kort, tjukk visar
- **Minuttvisar**: Mellomlang visar
- **Sekundvisar**: Lang, tynn visar

Desse viser **soltid** - der klokka 12:00 er når sola står i sør på di lengdegrad.

#### Gråe visarar (Standardtid)
- Same struktur som kvite visarar
- Viser vanleg klokke-tid (din tidssone)

### Informasjonspanel

Under urskiva finn du:

1. **Digital tidsvisning**
   - Soltid (med kvit sirkel-ikon)
   - Standardtid (med grå sirkel-ikon)
   - Båe i HH:mm:ss-format

2. **Offset**
   - Viser tidsskilnaden mellom soltid og standardtid
   - Format: +/-HH:MM:SS
   - Eksempel: "+00:21:17" betyr soltida er 21 minutt og 17 sekund framfor standardtid

3. **Posisjon**
   - Dine GPS-koordinatar
   - Format: latitude°, longitude°
   - Eksempel: "60.3930°, 5.3233°" (Bergen)

### Forklaring
Nedst på skjermen: 
> "Soltid: Klokka 12:00 er når sola står i sør"

## Korleis fungerer soltid?

### Prinsippet
Jorda roterer 360° på 24 timar, altså 15° per time. Soltid er basert på di lokale lengdegrad:

- Kvar 15° lengdegrad = 1 time forskjell
- Kvar 1° lengdegrad = 4 minutt forskjell

### Eksempel: Bergen vs Oslo
- **Bergen**: 5.32° Ø
- **Oslo**: 10.75° Ø
- **Forskjell**: 5.43° = ca. 21.7 minutt

Når sola står i sør i Bergen (soltid 12:00), vil den stå i sør i Oslo om ca. 22 minutt.

### Kvifor soltid?
Før standardtidssoner vart innførte, brukte alle lokalsamfunn soltid. Jernbana og telegraf kravde standardisering, men soltid er framleis den mest "naturlege" tida basert på solens posisjon.

## Tips og triks

### Simulator-testing
På iOS Simulator kan du setja ein posisjon:
1. Features → Location → Custom Location
2. Skriv inn koordinatar, t.d.:
   - Bergen: 60.39299, 5.323333
   - Oslo: 59.91273, 10.74609
   - Tromsø: 69.6492, 18.9553

### Nøyaktigheit
- Appen bruker ei forenkla berekningsmodell
- For høgaste presisjon, kan Rust-biblioteket integrerast
- Noverande presisjon: god nok for dagleg bruk

### Batteri
- GPS bruker batteri
- Appen oppdaterer posisjon kontinuerleg når den er open
- Lukk appen for å spara batteri

## Feilsøking

### "Ventar på posisjon..."
- Sjekk at appen har løyve til å bruka posisjon
- Innstillingar → Personvern og tryggleik → Lokaliseringstenester → Lokaltid
- På simulator: Set ein posisjon manuelt

### Urskiva viser same tid
- Det tyder at offset er 0 (nøyaktig på ein 15°-meridian)
- Eller at posisjon ikkje er tilgjengeleg enno

### App krasjar
- Sikre at iOS-versjonen er 18.0 eller nyare
- Prøv å byggja på nytt i Xcode

## Personvern

Appen:
- Bruker berre posisjon lokalt på eininga
- Sender ingen data til serverar
- Lagrar ingen historikk
- Krev berre posisjonslgløyve (ingen andre løyve)

## Framtidige funksjonar

Sjå [PLAN.md](PLAN.md) for planlagde utvidingar.
