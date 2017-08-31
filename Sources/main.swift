//
//  main.swift
//

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

Environment.initializeDatabaseConnector()


let files = FilesController()
let accounts = AccountController()
let server = HTTPServer()
server.serverName = Environment.serverName
server.serverPort = Environment.serverPort
server.addRoutes(Routes(accounts.routes))
server.addRoutes(Routes(files.routes))

if let tls = Environment.tls {
    server.ssl              = (tls.certPath, tls.keyPath ?? tls.certPath)
    server.caCert           = tls.caCertPath
    server.certVerifyMode   = tls.certVerifyMode
    server.cipherList       = tls.cipherList
}

do {
    try server.start()
} catch PerfectError.networkError(let err, let msg) {
    print("Network error thrown: \(err) \(msg)")
}

