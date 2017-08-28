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
        return "sub.your-domain.com"
    }
    
    static var serverPort : UInt16 {
        return self.isXcode ? 8081 : 80 // change to 443 once you have the cert prepared! 
    }
    
    static var documentRoot : String {
        return "./webroot"
    }
    
    static var tls : TLSConfiguration? {
        guard self.isNotXcode else { return nil }
        return TLSConfiguration(certPath: "/etc/letsencrypt/live/\(self.serverName)/fullchain.pem", keyPath: "/etc/letsencrypt/keys/0000_key-certbot.pem", certVerifyMode: OpenSSLVerifyMode.sslVerifyPeer)
    }
    
    static func initializeDatabaseConnector() {
        MySQLConnector.host     = "122.152.201.121"
        MySQLConnector.username = "root"
        MySQLConnector.password = "eelking"
        MySQLConnector.database = "eelking"
    }
}
