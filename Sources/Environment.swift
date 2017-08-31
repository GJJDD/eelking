//
//  Created by Mark Morrill on 2017/06/16.
//
//

import Foundation
import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import PerfectNet
import MySQLStORM

class Environment {
    static var isXcode : Bool {
        #if Xcode
            return true
        #else
            return false
        #endif
    }
    static var isNotXcode : Bool {
        return !self.isXcode
    }
    
    static var serverName : String {
        return "eelking.com"
    }
    
    static var serverPort : UInt16 {
        return self.isXcode ? 8081 : 443 // change to 443 once you have the cert prepared!
    }
    
    static var documentRoot : String {
        return "./webroot"
    }
    
    static var tls : TLSConfiguration? {
        guard self.isNotXcode else { return nil }
        return TLSConfiguration(certPath: "/etc/letsencrypt/live/\(self.serverName)/214151109780209.pem", keyPath: "/etc/letsencrypt/keys/214151109780209.key", certVerifyMode: OpenSSLVerifyMode.sslVerifyPeer)
    }
    
    static func initializeDatabaseConnector() {
        MySQLConnector.host     = "127.0.0.1"
        MySQLConnector.username = "root"
        MySQLConnector.password = "eelking"
        MySQLConnector.database = "eelking"
    }
}
