import Foundation
import CArgon2

public struct Argon2 {
    public func hash(_ bytes: [UInt8], context: Context = .default)throws -> [UInt8] {
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
    
    public func verify(_ bytes: inout [Int8], against hash: [Int8], mode: HashMode = .i)throws {
        let error = mode.verify(hash, bytes, bytes.count)
        
        guard error == 0 else {
            throw Argon2.Error(code: error)
        }
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
