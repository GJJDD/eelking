//
//  BaseController.swift
//  eelking
//
//  Created by dianwoda on 2017/8/23.
//
//

import Foundation
import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

class BaseController {
 

    //MARK: 通用响应格式
    func baseResponseBodyJSONData(status: Int, message: String, data: Any!) -> String {
        
        var result = Dictionary<String, Any>()
        result.updateValue(status, forKey: "status")
        result.updateValue(message, forKey: "message")
        if (data != nil) {
            result.updateValue(data, forKey: "data")
        }else{
            result.updateValue("", forKey: "data")
        }
        guard let jsonString = try? result.jsonEncodedString() else {
            return ""
        }
        return jsonString
        
    }
    
}
