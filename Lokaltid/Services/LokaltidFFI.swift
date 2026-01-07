import Foundation

// This file re-exports the auto-generated UniFFI bindings from Generated/lokaltid.swift
// and provides a fallback implementation when the Rust library is not available.

#if canImport(lokaltidFFI)
// When the Rust library is available, import and use the generated bindings
// The lokaltid.swift file in Generated/ will automatically import lokaltidFFI
// and provide the public API functions that match our needs.

// Since the generated code is in the same module, we can directly use its types and functions.
// No need to re-export anything here - just ensure Generated/lokaltid.swift is included in the build.

#else

// MARK: - Fallback implementation when Rust library is not available

public enum LokaltidError: Error {
    case InvalidCoordinate
}

public struct MobileSolarTime {
    public let timeString: String
    public let offsetSeconds: Double
    public let offsetMinutes: Double
    public let offsetHours: Double
    public let offsetFormatted: String
    public let unixTimestamp: Int64
    
    public init(timeString: String, offsetSeconds: Double, offsetMinutes: Double, 
                offsetHours: Double, offsetFormatted: String, unixTimestamp: Int64) {
        self.timeString = timeString
        self.offsetSeconds = offsetSeconds
        self.offsetMinutes = offsetMinutes
        self.offsetHours = offsetHours
        self.offsetFormatted = offsetFormatted
        self.unixTimestamp = unixTimestamp
    }
}

public func calculateSolarTimeForLocation(
    latitude: Double,
    longitude: Double,
    unixTimestamp: Int64
) throws -> MobileSolarTime {
    guard latitude >= -90 && latitude <= 90 else {
        throw LokaltidError.InvalidCoordinate
    }
    guard longitude >= -180 && longitude <= 180 else {
        throw LokaltidError.InvalidCoordinate
    }
    
    // Simple solar time calculation based on longitude
    let offsetSeconds = (longitude / 15.0) * 3600.0
    let offsetMinutes = offsetSeconds / 60.0
    let offsetHours = offsetSeconds / 3600.0
    
    let totalSeconds = abs(Int(offsetSeconds))
    let hours = totalSeconds / 3600
    let minutes = (totalSeconds % 3600) / 60
    let seconds = totalSeconds % 60
    let sign = offsetSeconds >= 0 ? "+" : "-"
    let offsetFormatted = String(format: "%@%02d:%02d:%02d", sign, hours, minutes, seconds)
    
    let solarTimestamp = unixTimestamp + Int64(offsetSeconds)
    let date = Date(timeIntervalSince1970: TimeInterval(solarTimestamp))
    
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    let timeString = formatter.string(from: date)
    
    return MobileSolarTime(
        timeString: timeString,
        offsetSeconds: offsetSeconds,
        offsetMinutes: offsetMinutes,
        offsetHours: offsetHours,
        offsetFormatted: offsetFormatted,
        unixTimestamp: solarTimestamp
    )
}

public func calculateSolarTimeNow(
    latitude: Double,
    longitude: Double
) throws -> MobileSolarTime {
    let now = Int64(Date().timeIntervalSince1970)
    return try calculateSolarTimeForLocation(
        latitude: latitude,
        longitude: longitude,
        unixTimestamp: now
    )
}

#endif

