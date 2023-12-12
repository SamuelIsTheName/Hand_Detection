//
//  Brightness.swift
//  LightRemote
//
//  Created by SAMUEL on 07/12/2023.
//

import Foundation

func TheBrightness(brightness : Int){
    let lightID = "b39673d2-5492-419e-a4e2-c8b2f7c2ed04"
        let urlString = "https://192.168.178.45/clip/v2/resource/light/\(lightID)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        
        
        request.setValue("4c8YxJqixFicuEX83r2U3zcckk9D-kvY841VAS8C", forHTTPHeaderField: "hue-application-key")
    
    let bodyData: [String: [String: Int]] = ["dimming": ["brightness": brightness]]
    guard let requestBody = try? JSONSerialization.data(withJSONObject: bodyData) else {
        print("Error creating request body")
        return
    }
    
    request.httpBody = requestBody
    
    let delegate = CustomSessionDelegate()
    let session = URLSession(configuration: .default, delegate: delegate, delegateQueue: nil)
    
    let task = session.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error: \(error)")
            return
        }
        
        
        if let httpResponse = response as? HTTPURLResponse {
            print("Response status code: \(httpResponse.statusCode)")
            
            if let responseData = data{
                do{
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(HueLightControllerResponse.self, from: responseData)
                    
                    if let firstLightData = response.data.first{
                        print("Light ID: \(firstLightData.rid)")
                        print("Light Type: \(firstLightData.rtype)")
                    }
                    if response.errors.isEmpty{
                        print("Request successful")
                    }else{
                        print("Errors occured: \(response.errors)")
                    }
                }catch{
                    print("Error decoding response: \(error)")
                }
            }
        }
    }
    task.resume()
}
