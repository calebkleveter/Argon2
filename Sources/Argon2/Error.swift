extension Argon2 {
    
    /// An error that can occur when hashing or verifying bytes.
    public struct Error: Swift.Error {
        
        /// The Argon 2 error code.
        public let code: Int32
        
        /// Creates a new `Argon2.Error` instance.
        ///
        /// - Parameter code: The Argon 2 error code from the function that failed.
        public init(code: Int32) {
            self.code = code
        }
    }
}
