//
//  JSONParameterEncoder.swift
//  Tenderloin
//
//  Created by Zulwiyoza Putra on 08/09/18.
//  Copyright © 2018 Wiyoza. All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]

public struct JSONParameterEncoder: ParameterEncoder {
    public static func encode(request: inout URLRequest, with parameters: Parameters) throws {
        do {
            let data = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            request.httpBody = data
            if request.value(forHTTPHeaderField: "Content-Type") == nil {
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        } catch {
            throw NetworkError.encodingError
        }
    }
}
