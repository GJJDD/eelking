//
//  AccountAPI.swift
//  eelking
//
//  Created by dianwoda on 2017/8/23.
//
//

class AccountAPI {
    // 登录接口
    static func login(withJSONRequest json: String?) throws -> Dictionary<String,String> {
        let loginDict:Dictionary<String,String>
        guard let json = json,
                let dict: [String: String] = try json.jsonDecode() as? [String : String],
                let userName = dict["userName"],
                let password = dict["password"]
            else {
                // 获取不到参数
                loginDict = ["faildMsg":"缺少参数"];
                return loginDict
        }
        let accountDict = try Account.login(matchingAccountName: userName, matchingPassword: password)
        return accountDict
    }
    // 注册接口
    static func register(withJSONRequest json: String?) throws -> Dictionary<String,String> {
        let registerDict:Dictionary<String,String>
        
        guard let json = json,
            let dict: [String: String] = try json.jsonDecode() as? [String : String],
            let userName = dict["userName"],
            let password = dict["password"],
            let accountToken = dict["accountToken"]
            else {
                // 获取不到参数
                registerDict = ["faildMsg":"缺少参数"];
                return registerDict
        }
        
        let accountDict = try Account.register(matchingAccountName: userName, matchingPassword: password, matchAccountToken: accountToken)
 
        return accountDict

    }
    static func findPassword(withJSONRequest json: String?) throws -> Dictionary<String,String> {
        let findPasswordDict:Dictionary<String,String>
        guard let json = json,
            let dict: [String: String] = try json.jsonDecode() as? [String : String],
            let userName = dict["userName"],
            let password = dict["password"],
            let accountToken = dict["accountToken"]
            else {
                // 获取不到参数
                findPasswordDict = ["faildMsg":"缺少参数"];
                return findPasswordDict
        }
        let accountDict = try Account.findPassword(matchingAccountName: userName, matchingPassword: password, matchAccountToken: accountToken)
        return accountDict
    }
}
