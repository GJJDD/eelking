//
//  Account.swift
//  eelking
//
//  Created by dianwoda on 2017/8/23.
//
//

import StORM
import MySQLStORM
import PerfectLib
import Foundation
class Account: MySQLStORM {
    override func table() -> String {
        return "account"
    }
    var accountId: Int = 0
    var uuid: String = ""
    var accountName: String = ""
    var password: String = ""
    var isLogin: Int8 = 0
    var accountToken: String = "" // 令牌用于用户找回密码
    
    
    override func to(_ this: StORMRow) {
        self.accountId(from: this.data["accountId"])
        self.uuid = this.data["uuid"] as? String ?? ""
        self.accountName = this.data["accountName"] as? String ?? ""
        self.password = this.data["password"] as? String ?? ""
        self.isLogin =  Int8(this.data["isLogin"] as? Int8 ?? 0)
        self.accountToken = this.data["accountToken"] as? String ?? ""
    }
    func accountId(from it:Any?) {
        self.accountId = Account.accountId(from: it) ?? 0
    }
    static func accountId(from it:Any?) -> Int? {
        if let it = it as? Int32 {
            return Int(it)
        }
        return nil
    }
    func rows() -> [Account] {
        var rows = [Account]()
        for i in 0 ..< self.results.rows.count {
            let row = Account()
            row.to(self.results.rows[i])
            rows.append(row)
        }
        return rows
    }
    func asDictionary() -> [String:Any] {
        return [
            "accountId" : self.accountId,
            "uuid" : self.uuid,
            "accountName" : self.accountName,
            "password" : self.password,
            "isLogin"  : self.isLogin,
            "accountToken" : self.accountToken,
        ]
    }
    

    // 返回对应uuid的数据
    static func getAccount(matchingUUID uuid:String) throws ->Account {
        let getObj = Account()
        var findObj = [String: Any]()
        findObj["uuid"] = "\(uuid)"
        try getObj.find(findObj)
        return getObj
    }
    // 根据用户名找到用户信息
    static func login(matchingAccountName accountName:String, matchingPassword password:String) throws ->Dictionary<String, String> {
        let getObj = Account()
        var findObj = [String: Any]()
        findObj["accountName"] = "\(accountName)"
        try getObj.find(findObj)
        var dict: [String:String] = Dictionary()
        if getObj.accountName=="" {
            // 提示帐号不存在
            dict["desc"] = "帐号不存在，请注册帐号"
            dict["accountName"] = accountName
        } else{
            // 存在用户，判断密码对不对
            if getObj.password==password {
                // 密码正确改变登录状态
                getObj.isLogin = 1
                do {
                    try getObj.save()
                    dict["desc"] = "登录成功"
                    dict["accountName"] = getObj.accountName
                    dict["accountId"] = String(getObj.accountId)
                } catch  {
                }
            } else {
                // 密码不正确，提示密码不正确
                dict["desc"] = "帐号或密码错误"
                dict["accountName"] = accountName
            }

        }
        return dict
      
    }
    static func register(matchingAccountName accountName:String, matchingPassword password:String, matchAccountToken accountToken:String) throws->Dictionary<String, String> {
        let getObj = Account()
        var findObj = [String: Any]()
        findObj["accountName"] = "\(accountName)"
   
        try getObj.find(findObj)
        var dict: [String:String] = Dictionary()
        if getObj.accountName==accountName {
            // 帐号已存在
            dict["desc"] = "帐号已存在，请直接登录"
            dict["accountName"] = getObj.accountName
   
        } else {
            // 注册帐号
            getObj.accountName = accountName
            getObj.password = password
            getObj.uuid = UUID().string
            getObj.isLogin = 0
            getObj.accountToken = accountToken
            do {
                try getObj.save()
                dict["desc"] = "帐号注册成功"
                dict["accountName"] = getObj.accountName
            } catch  {
                
            }

        }
        return dict
    }
    
    static func findPassword(matchingAccountName accountName:String, matchingPassword password:String, matchAccountToken accountToken:String) throws->Dictionary<String, String>
    {
        let getObj = Account()
        var findObj = [String: Any]()
        findObj["accountName"] = "\(accountName)"
        findObj["accountToken"] = "\(accountToken)"
        try getObj.find(findObj)
        var dict: [String:String] = Dictionary()
        if getObj.accountName=="" {
            // 没找到帐号
            // 提示帐号不存在
            dict["desc"] = "帐号不存在或令牌错误"
            dict["accountName"] = accountName
            dict["accountName"] = accountToken
        } else {
            // 找到帐号
            // 修改密码
            do {
                getObj.password = password
                try getObj.save()
                dict["desc"] = "密码修改成功"

            } catch  {
                
            }
        }
        
        return dict
    }


}
