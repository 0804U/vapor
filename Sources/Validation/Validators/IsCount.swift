/// Validates whether the data is within a supplied int range.
/// note: strings have length checked, while integers have their values checked
public struct IsCount: Validator {
    /// See Validator.inverseMessage
    public var inverseMessage: String {
        if let min = self.min, let max = self.max {
            return "larger than \(min) or smaller than \(max)"
        } else if let min = self.min {
            return "larger than \(min)"
        } else if let max = self.max {
            return "smaller than \(max)"
        } else {
            return "valid"
        }
    }

    /// the minimum possible value, if nil, not checked
    /// note: inclusive
    public let min: Int?

    /// the maximum possible value, if nil, not checked
    /// note: inclusive
    public let max: Int?

    /// creates an is count validator using a predefined int range
    ///     1...5
    public init(_ range: Range<Int>) {
        self.min = range.lowerBound
        self.max = range.upperBound
    }

    /// creates an is count validator using a partial range through
    ///     ...5
    public init(_ range: PartialRangeThrough<Int>) {
        self.max = range.upperBound
        self.min = nil
    }

    /// creates an is count validator using a partial range up to
    ///     ..<5
    public init(_ range: PartialRangeUpTo<Int>) {
        self.max = range.upperBound - 1
        self.min = nil
    }

    /// creates an is coutn validator using a partial range from
    ///     5...
    public init(_ range: PartialRangeFrom<Int>) {
        self.max = nil
        self.min = range.lowerBound
    }

    /// See Validator.validate
    public func validate(_ data: ValidationData) throws {
        switch data {
        case .string(let s):
            if let min = self.min {
                guard s.count >= min else {
                    throw BasicValidationError("is not at least \(min) characters")
                }
            }
            if let max = self.max {
                guard s.count <= max else {
                    throw BasicValidationError("is more than \(max) characters")
                }
            }
        case .int(let int):
            if let min = self.min {
                guard int >= min else {
                    throw BasicValidationError("is not larger than \(min)")
                }
            }
            if let max = self.max {
                guard int <= max else {
                    throw BasicValidationError("is larger than \(max)")
                }
            }
        default:
            throw BasicValidationError("is invalid")
        }
    }
}

