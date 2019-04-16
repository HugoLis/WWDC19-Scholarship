import Foundation

public struct PhysicsCategory {
    static let none:  UInt32 = 0
    static let all:   UInt32 = UInt32.max
    static let boat:  UInt32 = 0x1 << 0
    static let coin:  UInt32 = 0x1 << 1
    static let edge:  UInt32 = 0x1 << 2
    static let boost: UInt32 = 0x1 << 3
    static let swirl: UInt32 = 0x1 << 4
    static let particleField: UInt32 = 0x1 << 5
    static let boatField: UInt32 = 0x1 << 6
    static let finishLine: UInt32 = 0x1 << 7
}
