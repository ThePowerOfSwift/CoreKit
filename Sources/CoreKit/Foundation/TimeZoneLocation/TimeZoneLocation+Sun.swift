//
//  TimeZoneLocation+Sun.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import Foundation.NSDate
import Foundation.NSTimeZone


//public extension TimeZoneLocation
//{
//    public func sunData(date: NSDate) -> SunriseSunsetData {
//        return SunriseSunsetData(date: date, timeZone: self.timezone, latitude: self.latitude, longitude: self.longitude)
//    }
//}
//
//public class SunriseSunsetData : CustomStringConvertible
//{
//    ///////////////////////////////////////////////////////////////////////////////////////////////////
//    //  MARK: properties
//    ///////////////////////////////////////////////////////////////////////////////////////////////////
//
//    private var latitude: Double
//    private var longitude: Double
//    private var timeZone: NSTimeZone
//    private var utcTimeZone: NSTimeZone
//    private var calendar: NSCalendar
//    private var date: NSDate
//
//    ///////////////////////////////////////////////////////////////////////////////////////////////////
//    //  MARK: calculated properties
//    ///////////////////////////////////////////////////////////////////////////////////////////////////
//
//    public var sunset: NSDate!
//    public var sunrise: NSDate!
//    public var civilTwilightStart: NSDate!
//    public var civilTwilightEnd : NSDate!
//    public var nauticalTwilightStart: NSDate!
//    public var nauticalTwilightEnd : NSDate!
//    public var astronomicalTwilightStart: NSDate!
//    public var astronomicalTwilightEnd : NSDate!
//
//    public var localSunrise: NSDateComponents!
//    public var localSunset: NSDateComponents!
//    public var localCivilTwilightStart: NSDateComponents!
//    public var localCivilTwilightEnd: NSDateComponents!
//    public var localNauticalTwilightStart: NSDateComponents!
//    public var localNauticalTwilightEnd: NSDateComponents!
//    public var localAstronomicalTwilightStart: NSDateComponents!
//    public var localAstronomicalTwilightEnd: NSDateComponents!
//
//    public init(date: NSDate, timeZone: NSTimeZone, latitude: Double, longitude: Double) {
//        self.latitude    = latitude
//        self.longitude   = longitude
//        self.timeZone    = timeZone
//        self.date        = date
//        self.calendar    = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
//        self.utcTimeZone = NSTimeZone(abbreviation: "UTC")!
//
//        self.calculate()
//    }
//
//    ///////////////////////////////////////////////////////////////////////////////////////////////////
//    //  MARK: private properties
//    ///////////////////////////////////////////////////////////////////////////////////////////////////
//
//    private let secondsInHour : Double = 60.0 * 60.0
//    private let inv360 : Double         = 1.0 / 360.0
//    private let radeg : Double          = 180.0 / M_PI
//    private let degrad : Double         = M_PI / 180.0
//
//    ///////////////////////////////////////////////////////////////////////////////////////////////////
//    //  MARK: private functions
//    ///////////////////////////////////////////////////////////////////////////////////////////////////
//
//    private func sind(x: Double) -> Double {
//        return sin(x * self.degrad)
//    }
//    private func cosd(x: Double) -> Double {
//        return cos(x * self.degrad)
//    }
//    private func tand(x: Double) -> Double {
//        return tan(x * self.degrad)
//    }
//
//    private func atand(x: Double) -> Double {
//        return atan(x) * self.radeg
//    }
//    private func asind(x: Double) -> Double {
//        return asin(x) * self.radeg
//    }
//    private func acosd(x: Double) -> Double {
//        return acos(x) * self.radeg
//    }
//
//    private func atan2d(x: Double, _ y: Double) -> Double {
//        return atan2(x, y) * self.radeg
//    }
//
//    private func daysSince2000Jan0(y: Int, _ m:Int, _ d:Int) -> Int {
//        return (367*(y)-((7*((y)+(((m)+9)/12)))/4)+((275*(m))/9)+(d)-730530)
//    }
//
//    //Reduce angle to within 0..360 degrees
//    private func revolution(x: Double) -> Double {
//        return (x - 360.0 * floor(x * self.inv360))
//    }
//    //Reduce angle to within -180..+180 degrees
//    private func rev180(x: Double) -> Double {
//        return (x - 360.0 * floor(x * self.inv360 + 0.5))
//    }
//
//    private func GMST0(d: Double) -> Double {
//        return self.revolution((180.0 + 356.0470 + 282.9404) + (0.9856002585 + 4.70935e-5) * d)
//    }
//
//    private func sunposAtDay(d: Double, inout lon: Double, inout r: Double) {
//        let M = self.revolution(356.0470 + 0.9856002585 * d)
//        let w = 282.9404 + 4.70935e-5 * d
//        let e = 0.016709 - 1.151e-9 * d
//
//        let E = M + e * self.radeg * self.sind(M) * (1.0 + e * self.cosd(M))
//        let x = self.cosd(E) - e
//        let y = sqrt(1.0 - e*e) * self.sind(E)
//        r     = sqrt(x*x + y*y)
//        let v = self.atan2d(y, x)
//        lon   = v + w
//        if lon >= 360.0  {
//            lon  -= 360.0
//        }
//    }
//
//    private func sun_RA_decAtDay(d: Double, inout RA: Double, inout dec: Double, inout r: Double) {
//        var lon : Double = 0
//
//        self.sunposAtDay(d, lon: &lon, r: &r)
//
//        let xs      = r * self.cosd(lon)
//        let ys      = r * self.sind(lon)
//        let obl_ecl = 23.4393 - 3.563E-7 * d
//        let xe      = xs
//        let ye      = ys * self.cosd(obl_ecl)
//        let ze      = ys * self.sind(obl_ecl)
//        RA          = self.atan2d(ye, xe)
//        dec         = self.atan2d(ze, sqrt(xe*xe + ye*ye))
//    }
//
//    private func sunRiseSetForYear(year: Int, month: Int, day: Int, lon: Double, lat: Double, inout trise: Double, inout tset: Double) -> Int {
//        return self.sunRiseSetHelperForYear(year, month: month, day: day, lon: lon, lat: lat, altit: (-35.0/60.0), upper_limb: 1, trise: &trise , tset: &tset)
//    }
//
//    private func civilTwilightForYear(year: Int, month: Int, day: Int, lon: Double, lat: Double, inout trise: Double, inout tset: Double) -> Int {
//        return self.sunRiseSetHelperForYear(year, month: month, day: day, lon: lon, lat: lat, altit: -6.0, upper_limb: 0, trise: &trise , tset: &tset)
//    }
//
//    private func nauticalTwilightForYear(year: Int, month: Int, day: Int, lon: Double, lat: Double, inout trise: Double, inout tset: Double) -> Int {
//        return self.sunRiseSetHelperForYear(year, month: month, day: day, lon: lon, lat: lat, altit: -12.0, upper_limb: 0, trise: &trise , tset: &tset)
//    }
//
//    private func astronomicalTwilightForYear(year: Int, month: Int, day: Int, lon: Double, lat: Double, inout trise: Double, inout tset: Double) -> Int {
//        return self.sunRiseSetHelperForYear(year, month: month, day: day, lon: lon, lat: lat, altit: -18.0, upper_limb: 0, trise: &trise , tset: &tset)
//    }
//
//
//    private func sunRiseSetHelperForYear(year: Int, month: Int, day: Int, lon: Double, lat: Double, altit: Double, upper_limb: Int,
//                                         inout trise: Double, inout tset: Double) -> Int
//    {
//        var rc            = 0
//        var sRA : Double  = 0
//        var sdec : Double = 0
//        var sr : Double   = 0
//        var t : Double    = 0
//        let d             = self.daysSince2000Jan0(year, month, day).toDouble + 0.5 - lon/360.0
//        let sidtime       = self.revolution(self.GMST0(d) + 180.0 + lon)
//
//        self.sun_RA_decAtDay(d, RA: &sRA, dec: &sdec, r: &sr)
//
//        let tsouth = 12.0 - self.rev180(sidtime - sRA) / 15.0
//        let sradius = 0.2666 / sr
//
//        var alt = altit
//        if upper_limb == 1 {
//            alt -= sradius
//        }
//
//        let cost = (self.sind(alt) - self.sind(lat) * self.sind(sdec)) / (self.cosd(lat) * self.cosd(sdec))
//        if cost >= 1.0 {
//            rc = -1
//            t = 0.0
//        }
//        else if ( cost <= -1.0 ) {
//            rc = +1
//            t = 12.0
//        }
//        else {
//            t = self.acosd(cost)/15.0
//        }
//
//        trise = tsouth - t
//        tset  = tsouth + t
//
//        return rc
//    }
//
//    private func utcTime(dateComponents: NSDateComponents, interval: NSTimeInterval) -> NSDate {
//        self.calendar.timeZone = self.utcTimeZone
//        return self.calendar.dateFromComponents(dateComponents)!.dateByAddingTimeInterval(interval)
//    }
//
//    private func localTime(refDate: NSDate) -> NSDateComponents {
//        self.calendar.timeZone = self.timeZone
//        return self.calendar.components([.Hour, .Minute, .Second], fromDate: refDate)
//    }
//
//
//    private func calculateSunriseSunset() {
//        var rise : Double      = 0.0
//        var set : Double       = 0.0
//        self.calendar.timeZone = self.timeZone
//        let dcs                = self.calendar.components([.Year, .Month, .Day], fromDate: self.date)
//
//        self.sunRiseSetForYear(dcs.year, month: dcs.month, day: dcs.day, lon: self.longitude, lat: self.latitude, trise: &rise, tset: &set)
//        self.sunrise      = self.utcTime(dcs, interval: rise * self.secondsInHour)
//        self.sunset       = self.utcTime(dcs, interval: set * self.secondsInHour)
//        self.localSunrise = self.localTime(self.sunrise)
//        self.localSunset  = self.localTime(self.sunset)
//    }
//
//    private func calculateTwilight() {
//        var start : Double     = 0.0
//        var end : Double       = 0.0
//        self.calendar.timeZone = self.timeZone
//        let dcs                = self.calendar.components([.Year, .Month, .Day], fromDate: self.date)
//
//        self.civilTwilightForYear(dcs.year, month: dcs.month, day: dcs.day, lon: self.longitude, lat: self.latitude, trise: &start, tset: &end)
//        self.civilTwilightStart      = self.utcTime(dcs, interval: start*self.secondsInHour)
//        self.civilTwilightEnd        = self.utcTime(dcs, interval: end*self.secondsInHour)
//        self.localCivilTwilightStart = self.localTime(self.civilTwilightStart)
//        self.localCivilTwilightEnd   = self.localTime(self.civilTwilightEnd)
//
//
//        self.nauticalTwilightForYear(dcs.year, month: dcs.month, day: dcs.day, lon: self.longitude, lat: self.latitude, trise: &start, tset: &end)
//        self.nauticalTwilightStart      = self.utcTime(dcs, interval: start*self.secondsInHour)
//        self.nauticalTwilightEnd        = self.utcTime(dcs, interval: end*self.secondsInHour)
//        self.localNauticalTwilightStart = self.localTime(self.nauticalTwilightStart)
//        self.localNauticalTwilightEnd   = self.localTime(self.nauticalTwilightEnd)
//
//
//        self.astronomicalTwilightForYear(dcs.year, month: dcs.month, day: dcs.day, lon: self.longitude, lat: self.latitude, trise: &start, tset: &end)
//        self.astronomicalTwilightStart      = self.utcTime(dcs, interval: start*self.secondsInHour)
//        self.astronomicalTwilightEnd        = self.utcTime(dcs, interval: end*self.secondsInHour)
//        self.localAstronomicalTwilightStart = self.localTime(self.astronomicalTwilightStart)
//        self.localAstronomicalTwilightEnd   = self.localTime(self.astronomicalTwilightEnd)
//    }
//
//    private func calculate() {
//        self.calculateSunriseSunset()
//        self.calculateTwilight()
//    }
//
//    public var description : String {
//        let format = "" +
//            "Date: %@\nTimeZone: %@\n" +
//            "Local Sunrise: %@\n" +
//            "Local Sunset: %@\n" +
//            "Local Civil Twilight Start: %@\n" +
//            "Local Civil Twilight End: %@\n" +
//            "Local Nautical Twilight Start: %@\n" +
//            "Local Nautical Twilight End: %@\n" +
//            "Local Astronomical Twilight Start: %@\n" +
//        "Local Astronomical Twilight End: %@\n"
//
//        return String(format: format,
//                      self.date.description, self.timeZone.name,
//                      self.localSunrise.description, self.localSunset.description,
//                      self.localCivilTwilightStart, self.localCivilTwilightEnd,
//                      self.localNauticalTwilightStart, self.localNauticalTwilightEnd,
//                      self.localAstronomicalTwilightStart, self.localAstronomicalTwilightEnd
//        )
//
//    }
//}
//
//
//
