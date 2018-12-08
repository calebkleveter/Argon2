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
    }
}
