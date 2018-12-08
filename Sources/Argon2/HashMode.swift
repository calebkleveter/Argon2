import CArgon2

extension Argon2 {
    
    /// The hashing mode to use on the bytes passed into the hasher.
    public enum HashMode: Int, Hashable, CaseIterable, Codable {
        
        /// Uses data-depending memory access, which makes it highly resistant against GPU cracking attacks and suitable for
        /// applications with no threats from side-channel timing attacks.
        ///
        /// This option is faster than `i`.
        case d
        
        /// Uses data-independent memory access, which is preferred for password hashing and password-based key derivation, but it is
        /// slower as it makes more passes over the memory to protect from tradeoff attacks.
        case i
        
        
        /// A hybrid of `i` and `d`, using a combination of data-depending and data-independent memory accesses, which gives some of
        /// `i`'s resistance to side-channel cache timing attacks and much of `d`'s resistance to GPU cracking attacks.
        case id
        
        /// The C hashing function that is used for the given hashing mode.
        public var method: (UInt32, UInt32, UInt32, UnsafeRawPointer?, Int, UnsafeRawPointer?, Int, Int, UnsafeMutablePointer<Int8>?, Int) -> Int32 {
            switch self {
            case .d: return argon2d_hash_encoded
            case .i: return argon2i_hash_encoded
            case .id: return argon2id_hash_encoded
            }
        }
        
        /// The C verification functions used for verifying that a known string matches a hash.
        public var verify: (UnsafePointer<Int8>, UnsafeRawPointer, Int) -> Int32 {
            switch self {
            case .d: return argon2d_verify
            case .i: return argon2i_verify
            case .id: return argon2id_verify
            }
        }
    }
}
