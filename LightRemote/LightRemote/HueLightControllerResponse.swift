//
//  HueLightControllerResponse.swift
//  LightRemote
//
//  Created by SAMUEL on 25/11/2023.
//

import Foundation
struct HueLightControllerResponse: Decodable{
    let data: [LightControlData]
    let errors: [String]
}
struct LightControlData: Decodable{
    let rid: String
    let rtype: String
}
