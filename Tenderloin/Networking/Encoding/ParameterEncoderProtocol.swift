//
//  ParameterEncoderProtocol.swift
//  Tenderloin
//
//  Created by Zulwiyoza Putra on 08/09/18.
//  Copyright © 2018 Wiyoza. All rights reserved.
//

import Foundation

public protocol ParameterEncoder {
    static func encode(request: inout URLRequest, with parameters: Parameters) throws
}
