//
//  NetworkRouterProtocol.swift
//  Tenderloin
//
//  Created by Zulwiyoza Putra on 08/09/18.
//  Copyright © 2018 Wiyoza. All rights reserved.
//

import Foundation

public typealias NetworkRouterCompletionHandler = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()

protocol NetworkRouterProtcol: class {
    associatedtype Route: RouteType
    func request(_ route: Route, completionHandler: @escaping NetworkRouterCompletionHandler)
    func cancel()
}
