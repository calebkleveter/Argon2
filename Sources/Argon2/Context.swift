import CArgon2

extension Argon2 {
    
    /// The settings used for hashing an array of bytes.
    public struct Context: Codable {
        
        /// The type of hash to run the bytes through.
        ///
        /// See `Argon2.HashMode` for more info.
        public var mode: HashMode
        
        /// The number of iterations the hasher will use on the bytse.
        public var iterations: UInt32
        
        /// The amount of memory reserved for the hashing the bytes.
        public var memory: UInt32
        
        /// The number of threads and compute lanes used for hashing.
        public var parallelism: UInt32
        
        /// The hash's salt.
        public var salt: Bytes
        
        /// The count of elements in the resulting hashed bytes array.
        public var hashLength: UInt32
        
        /// Creates a new `Argon2.Context` instance.
        ///
        /// - Parameters:
        ///   - mode:
        ///   - iterations:
        ///   - memory:
        ///   - parallelism:
        ///   - salt:
        ///   - hashLength:
        public init(mode: HashMode, iterations: UInt32, memory: UInt32, parallelism: UInt32, salt: Bytes, hashLength: UInt32) {
            self.mode = mode
            self.iterations = iterations
            self.memory = memory
            self.parallelism = parallelism
            self.salt = salt
            self.hashLength = hashLength
        }
        
        /// The count of bytes in the salt array, as a `UInt32`.
        public var saltLength: UInt32 {
            return UInt32(self.salt.count)
        }
        
        /// A default context instance that can be used to hash a byte array.
        ///
        /// This context uses the following values for its properties:
        /// - mode: `i`
        /// - iterations: 2
        /// - memory: `1<<16` or 65536
        /// - parallelism: 1
        /// - salt: 16 random unsigned, 8 bit integers.
        /// - hashLength: 32
        public static var `default`: Context {
            let salt = (0...15).map { _ in return UInt8.random(in: 0...UInt8.max) }
            return Context(mode: .i, iterations: 2, memory: 1<<16, parallelism: 1, salt: salt, hashLength: 32)
        }
    }
}
