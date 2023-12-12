//
//  CustomSessionDelegate.swift
//  LightRemote
//
//  Created by SAMUEL on 05/12/2023.
//

import Foundation
class CustomSessionDelegate: NSObject, URLSessionDelegate{
    func urlSession(
            _ session: URLSession,
            didReceive challenge: URLAuthenticationChallenge,
            completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void
        ) {
            if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
                completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
            }
        }
}
