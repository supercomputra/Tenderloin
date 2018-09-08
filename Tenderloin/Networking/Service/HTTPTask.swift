//
//  HTTPTask.swift
//  Tenderloin
//
//  Created by Zulwiyoza Putra on 08/09/18.
//  Copyright © 2018 Wiyoza. All rights reserved.
//

import Foundation

enum HTTPTask {
    case request
    case requestWithParameters(bodyParameters: Parameters?, urlParameters: Parameters?)
    case requeestWithParametersAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, header: HTTPHeader?)
}
