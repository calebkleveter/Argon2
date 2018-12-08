import Foundation
import CArgon2

public struct Argon2 {
    
    /// Hashes a byte array using the Argon 2 algorithm.
    ///
    /// - Parameters:
    ///   - bytes: The byte array to hash.
    ///   - context: Information used to create the hash, such as an iteration count and salt.
    ///     This defaults to the default `Argon2.Context` instance.
    ///
    /// - Returns: The hashed and encoded byte array.
    public static func hash(_ bytes: [UInt8], context: Context = .default)throws -> [UInt8] {
        var result: [Int8] = []
        
        let error = context.mode.method(
            context.iterations,
            context.memory,
            context.parallelism,
            bytes,
            bytes.count,
            context.salt,
            context.salt.count,
            Int(context.hashLength),
            &result,
            self.length(of: context)
        )
        
        guard error == 0 else {
            throw Argon2.Error(code: error)
        }
        
        return result.map(UInt8.init)
    }
    
    /// Hashes a stringusing the Argon 2 algorithm.
    ///
    /// - Parameters:
    ///   - string: The string to hash.
    ///   - context: Information used to create the hash, such as an iteration count and salt.
    ///     This defaults to the default `Argon2.Context` instance.
    ///
    /// - Returns: The hashed and encoded string.
    /// - Throws: An `Argon2.Error` instance with a status code of `1` if the `String`/`Bytes` conversion fails.
    public static func hash(_ string: String, context: Context = .default)throws -> String {
        guard let data = string.data(using: .utf8) else { throw Argon2.Error(code: 1) }
        
        let hash = try self.hash(Array(data), context: context)
        guard let hashString = String(bytes: hash, encoding: .utf8) else { throw Argon2.Error(code: 1) }
        
        return hashString
    }
    
    
    /// Verifies that a byte array matches a hashed bytes array if hashed with the same context.
    ///
    /// - Parameters:
    ///   - bytes: The bytes to check if they match the hash.
    ///   - hash: The hash to check the bytes against.
    ///   - mode: The `HashMode` that the hashed bytes where hashed with. Defaults to the `i` case.
    ///
    /// - Returns: Void if the bytes match the hash.
    public static func verify(_ bytes: [Int8], against hash: [Int8], mode: HashMode = .i)throws {
        let error = mode.verify(hash, bytes, bytes.count)
        
        guard error == 0 else {
            throw Argon2.Error(code: error)
        }
    }
    
    /// Verifies that a string matches a hashed string if hashed with the same context.
    ///
    /// - Parameters:
    ///   - string: The string to check if it matches the hash.
    ///   - hash: The hash to check the string against.
    ///   - mode: The `HashMode` that the hashed string was hashed with. Defaults to the `i` case.
    ///
    /// - Returns: Void if the string match the hash.
    /// - Throws: An `Argon2.Error` instance with a status code of `1` if the `String`/`Bytes` conversion fails.
    public static func verify(_ string: String, against hashString: String, mode: HashMode = .i)throws {
        guard let bytes = string.data(using: .utf8), let hash = hashString.data(using: .utf8) else {
            throw Argon2.Error(code: 1)
        }
        
        let error = mode.verify(hash.map(Int8.init(bitPattern:)), bytes.map(Int8.init(bitPattern:)), bytes.count)
        
        guard error == 0 else {
            throw Argon2.Error(code: error)
        }
    }
    
    
    /// Calculates a length of the final encoded hash based on a context.
    ///
    /// - Parameter context: The context to get the information for hashing a byte array.
    ///
    /// - Returns: The length that an encoded hash will if encoded with the given context.
    public static  func length(of context: Context) -> Int {
        return argon2_encodedlen(
            context.iterations,
            context.memory,
            context.parallelism,
            context.saltLength,
            context.hashLength,
            argon2_type(UInt32(context.mode.rawValue))
        )
    }
}
