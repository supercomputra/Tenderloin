//
//  RouteType.swift
//  Tenderloin
//
//  Created by Zulwiyoza Putra on 08/09/18.
//  Copyright © 2018 Wiyoza. All rights reserved.
//

import Foundation

protocol RouteType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var httpTask: HTTPTask { get }
    var httpHeader: HTTPHeader? { get }
}
