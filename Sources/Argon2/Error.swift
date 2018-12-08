extension Argon2 {
    public struct Error: Swift.Error {
        public let code: Int32
        
        public init(code: Int32) {
            self.code = code
        }
    }
}
