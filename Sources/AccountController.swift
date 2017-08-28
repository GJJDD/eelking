//
//  AccountController.swift
//  eelking
//
//  Created by dianwoda on 2017/8/23.
//
//

import Foundation
import PerfectLib
import PerfectHTTP
import PerfectHTTPServer


class AccountController :BaseController,ControllerProtocol {
    var routes: [Route] {
        return [
            Route(method: .post, uri:"/login", handler: self.login),
            Route(method: .post, uri:"/register", handler: self.register),
            Route(method: .post, uri:"/findPassword", handler: self.findPassword)
        ]
    }
    
    func login(request: HTTPRequest, response: HTTPResponse) {
        do {
            let loginDict = try AccountAPI.login(withJSONRequest: request.postBodyString)
            let jsonString = self.baseResponseBodyJSONData(status: 200, message: "request success", data: loginDict)
                response.setBody(string: jsonString)
                    .setHeader(.contentType, value: "application/json")
                    .completed()
        } catch {
            response.setBody(string: "Error handling request: \(error)")
                .completed(status: .internalServerError)
        }
    }
    func register(request: HTTPRequest, response: HTTPResponse) {
        do {
            let registerDict = try AccountAPI.register(withJSONRequest: request.postBodyString)
            let jsonString = self.baseResponseBodyJSONData(status: 200, message: "request success", data: registerDict)
            response.setBody(string: jsonString)
                .setHeader(.contentType, value: "application/json")
                .completed()
        } catch {
            response.setBody(string: "Error handling request: \(error)")
                .completed(status: .internalServerError)
        }
        
        
    }
    
    func findPassword(request: HTTPRequest, response: HTTPResponse) {
        do {
            let findPasswordDict = try AccountAPI.findPassword(withJSONRequest: request.postBodyString)
            let jsonString = self.baseResponseBodyJSONData(status: 200, message: "request success", data: findPasswordDict)
            response.setBody(string: jsonString)
                .setHeader(.contentType, value: "application/json")
                .completed()
        } catch {
            response.setBody(string: "Error handling request: \(error)")
                .completed(status: .internalServerError)
        }
    }
    

}
