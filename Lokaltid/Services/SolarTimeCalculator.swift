import Foundation

/// Resultat frå soltidsutrekning
struct SolarTime {
    let date: Date
    let offsetSeconds: Double
    
    var offsetMinutes: Double {
        offsetSeconds / 60.0
    }
    
    var offsetHours: Double {
        offsetSeconds / 3600.0
    }
    
    var offsetFormatted: String {
        let totalSeconds = abs(Int(offsetSeconds))
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        let sign = offsetSeconds >= 0 ? "+" : "-"
        return String(format: "%@%02d:%02d:%02d", sign, hours, minutes, seconds)
    }
}

/// Bereknar soltid basert på geografisk posisjon
/// Dette er ein forenkla implementasjon basert på lokaltid-biblioteket sitt API
class SolarTimeCalculator {
    
    /// Bereknar soltid for gitt posisjon og tid
    /// Basert på enkelt prinsipp: 15° lengdegrad = 1 time forskjell
    /// Dette er ein forenkla versjon - for full presisjon bør ein bruka Rust-biblioteket
    static func calculate(for location: Location, at date: Date = Date()) -> SolarTime {
        // Berekn offset basert på lengdegrad
        // 15° lengdegrad = 1 time (3600 sekund)
        // 1° lengdegrad = 4 minutt (240 sekund)
        let offsetSeconds = (location.longitude / 15.0) * 3600.0
        
        // Legg til offset på datoen
        let solarDate = date.addingTimeInterval(offsetSeconds)
        
        return SolarTime(date: solarDate, offsetSeconds: offsetSeconds)
    }
    
    /// Bereknar soltid for noverande tidspunkt
    static func calculateNow(for location: Location) -> SolarTime {
        return calculate(for: location, at: Date())
    }
}
