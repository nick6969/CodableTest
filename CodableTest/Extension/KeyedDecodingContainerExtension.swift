//
//  KeyedDecodingContainerExtension.swift
//  CodableTest
//
//  Created by Nick on 2018/12/13.
//  Copyright © 2018 kciN.niL.App. All rights reserved.
//

import Foundation

public extension KeyedDecodingContainer {
    
    public func decodeToDouble(for key: Key, type: Any.Type) throws -> Double {
        if let val = try? self.decode(String.self, forKey: key) {
            let vTrim = val.trimmingCharacters(in: .whitespaces)
            if let value = Int(vTrim) {
                return Double(value)
            } else if let value = Double(vTrim) {
                return value
            } else {
                throw DecodingError.typeMismatch(type.self,
                                                 DecodingError.Context(codingPath: codingPath,
                                                                       debugDescription: "Wrong for \(type).\(key)"))
            }
        } else if let val = try? self.decode(Double.self, forKey: key) {
            return val
        } else if let val = try? self.decode(Int.self, forKey: key) {
            return Double(val)
        } else {
            throw DecodingError.typeMismatch(type.self,
                                             DecodingError.Context(codingPath: codingPath,
                                                                   debugDescription: "Wrong for \(type).\(key)"))
        }
    }
    
    public func decodeToInt(for key: Key, type: Any.Type) throws -> Int {
        if let val = try? self.decode(String.self, forKey: key) {
            let vTrim = val.trimmingCharacters(in: .whitespaces)
            if let value = Int(vTrim) {
                return value
            } else if let value = Double(vTrim) {
                return Int(value)
            } else {
                throw DecodingError.typeMismatch(type.self,
                                                 DecodingError.Context(codingPath: codingPath,
                                                                       debugDescription: "Wrong for \(type).\(key)"))
            }
        } else if let val = try? self.decode(Int.self, forKey: key) {
            return val
        } else if let val = try? self.decode(Double.self, forKey: key) {
            return Int(val)
        } else {
            throw DecodingError.typeMismatch(type.self,
                                             DecodingError.Context(codingPath: codingPath,
                                                                   debugDescription: "Wrong for \(type).\(key)"))
        }
    }
    
    public func decodeToString(for key: Key, type: Any.Type) throws -> String {
        if let val = try? self.decode(String.self, forKey: key) {
            return val
        } else if let val = try? self.decode(Int.self, forKey: key) {
            return "\(val)"
        } else if let val = try? self.decode(Double.self, forKey: key) {
            return "\(val)"
        } else {
            throw DecodingError.typeMismatch(type.self,
                                             DecodingError.Context(codingPath: codingPath,
                                                                   debugDescription: "Wrong for \(type).\(key)"))
        }
    }
    
    public func decodeToStringCanEmpty(for key: Key) throws -> String {
        if let val = try? self.decode(String.self, forKey: key) {
            return val
        } else if let val = try? self.decode(Int.self, forKey: key) {
            return "\(val)"
        } else if let val = try? self.decode(Double.self, forKey: key) {
            return "\(val)"
        } else {
            return ""
        }
    }
    
}

public extension KeyedDecodingContainer {
    
    public func decodeToBoolFromY(for key: Key) throws -> Bool {
        if let val = try? self.decode(String.self, forKey: key), val == "Y" {
            return true
        } else {
            return false
        }
    }
    
    public func decodeToBoolFrom1(for key: Key) throws -> Bool {
        if let val = try? self.decode(String.self, forKey: key), val == "1" {
            return true
        } else {
            return false
        }
    }
    
}
