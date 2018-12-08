extension Argon2 {
    public struct Context: Codable {
        public var mode: HashMode
        
        public init(mode: HashMode) {
            self.mode = mode
        }
        
        public static var `default`: Context {
            return Context(mode: .i)
        }
    }
}
