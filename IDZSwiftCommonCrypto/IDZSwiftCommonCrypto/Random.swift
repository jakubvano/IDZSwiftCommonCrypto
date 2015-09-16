//
//  Random.swift
//  SwiftCommonCrypto
//
//  Created by idz on 9/19/14.
//  Copyright (c) 2014 iOS Developer Zone. All rights reserved.
//
// https://opensource.apple.com/source/CommonCrypto/CommonCrypto-60061/lib/CommonRandom.c

import Foundation
import CommonCrypto

public typealias RNGStatus = Status

public class Random
{
    /**
    Wraps native CCRandomeGenerateBytes call.
    
    :note: CCRNGStatus is typealiased to CCStatus but this routine can only return kCCSuccess or kCCRNGFailure
    
    - parameter bytes: a pointer to the buffer that will receive the bytes
    - return: .Success or .RNGFailure as appropriate.
    
     */
    public class func generateBytes(bytes : UnsafeMutablePointer<Void>, byteCount : Int ) -> RNGStatus
    {
        let status = Status(rawValue: CCRandomGenerateBytes(bytes, byteCount))
        if(status == nil)
        {
            fatalError("")
        }
        return status!
    }
    /**
    Generates an array of random bytes.
    
    - parameter bytesCount: number of random bytes to generate
    - return: an array of random bytes
    */
    public class func generateBytes(byteCount : Int ) throws -> [UInt8]
    {
        if(byteCount <= 0)
        {
            fatalError("generateBytes: byteCount must be positve and non-zero")
        }
        var bytes : [UInt8] = Array(count:byteCount, repeatedValue:UInt8(0))
        CCRandomGenerateBytes(&bytes, byteCount)
        return bytes
    }
    
    /**
     A version of generateBytes that always throws an error.
    
     Use it to test that code handles this.
    
    - parameter bytesCount: number of random bytes to generate
    - return: an array of random bytes
     */
    public class func generateBytesThrow(byteCount : Int ) throws -> [UInt8]
    {
        if(byteCount <= 0)
        {
            fatalError("generateBytes: byteCount must be positve and non-zero")
        }
        var bytes : [UInt8] = Array(count:byteCount, repeatedValue:UInt8(0))
        let status = generateBytes(&bytes, byteCount: byteCount)
        throw status
        //return bytes
    }
}