import CArgon2

extension Argon2 {
    public struct Context: Codable {
        public var mode: HashMode
        public var iterations: UInt32
        public var memory: UInt32
        public var parallelism: UInt32
        public var salt: Bytes
        public var hashLength: UInt32
        
        public init(mode: HashMode, iterations: UInt32, memory: UInt32, parallelism: UInt32, salt: Bytes, hashLength: UInt32) {
            self.mode = mode
            self.iterations = iterations
            self.memory = memory
            self.parallelism = parallelism
            self.salt = salt
            self.hashLength = hashLength
        }
        
        public var saltLength: UInt32 {
            return UInt32(self.salt.count)
        }
        
        public static var `default`: Context {
            let salt = (0...15).map { _ in return UInt8.random(in: 0...UInt8.max) }
            return Context(mode: .i, iterations: 2, memory: 1<<16, parallelism: 1, salt: salt, hashLength: 32)
        }
    }
}
