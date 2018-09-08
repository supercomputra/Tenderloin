//
//  Router.swift
//  Tenderloin
//
//  Created by Zulwiyoza Putra on 08/09/18.
//  Copyright © 2018 Wiyoza. All rights reserved.
//

import Foundation

class NetworkRouter<Route: RouteType>: NetworkRouterProtcol {
    
    private var task: URLSessionTask?
    
    func request(_ route: Route, completionHandler: @escaping NetworkRouterCompletionHandler) {
        let session = URLSession.shared
        do {
            let request = try buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
                completionHandler(data, response, error)
            })
        } catch {
            completionHandler(nil, nil, error)
        }
        
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
}

extension NetworkRouter {
    fileprivate func setParameters(request: inout URLRequest, bodyParameters: Parameters? = nil, urlParameters: Parameters? = nil) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(request: &request, with: bodyParameters)
            }
            
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(request: &request, with: urlParameters)
            }
        } catch {
            throw error
        }
    }
    
    fileprivate func setHeader(request: inout URLRequest, _ header: HTTPHeader?) {
        guard let header = header else { return }
        for (key, value) in header {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
    fileprivate func buildRequest(from route: Route) throws -> URLRequest {
        let url = route.baseURL.appendingPathComponent(route.path)
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        request.httpMethod = route.httpMethod.rawValue
        
        do {
            switch route.httpTask {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestWithParameters(bodyParameters: let bodyParameters, urlParameters: let urlParameters):
                try setParameters(request: &request, bodyParameters: bodyParameters, urlParameters: urlParameters)
            case .requeestWithParametersAndHeaders(bodyParameters: let bodyParameters, urlParameters: let urlParameters, header: let header):
                setHeader(request: &request , header)
                try setParameters(request: &request, bodyParameters: bodyParameters, urlParameters: urlParameters)
            }
            return request
        } catch {
            throw error
        }
    }
}
