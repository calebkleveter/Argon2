import Foundation
import CArgon2

public typealias Byte = UInt8
public typealias Bytes = [Byte]

public struct Argon2 {
    public func hash(_ bytes: Bytes, context: Context = .default)throws -> Bytes {
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
    
    public func length(of context: Context) -> Int {
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
