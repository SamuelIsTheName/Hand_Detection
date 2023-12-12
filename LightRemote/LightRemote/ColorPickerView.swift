//
//  ColorPickerView.swift
//  LightRemote
//
//  Created by SAMUEL on 08/12/2023.
//

import SwiftUI

struct ColorPickerView: View {
    let manager = LightBulbColorMnjr()
    let colors : [LightBulbColor]
    let regular = Color(red: 255 / 255, green: 190 / 255, blue: -139 / 255)
        
    init() {
        self.colors = manager.ColorList()
        }
        
        var body: some View {
            
            VStack {
                Text("Lightbulb Colors").font(.system(size: 25))
                        ForEach(0..<2) { row in
                            HStack {
                                ForEach(0..<3) { column in
                                    let index = row * 3 + column
                                    Button(action: {
                                        ColorSetter(theX: colors[index].x, theY: colors[index].y)
//                                        print("Color: \(colors[index].color) at (x: \(colors[index].x), y: \(colors[index].y)) tapped!")
                                    }) {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(colors[index].color)
                                            .frame(width: 80, height: 80)
                                            .padding(5)
                                    }
                                }
                            }
                        }
                Button(action:{
                    ColorSetter(theX: 0.4573, theY: 0.41)
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(regular)
                            .frame(width: 275, height: 80)
                            .padding(5)
                        Text("Regular Light")
                            .foregroundColor(.black)
                            .font(.system(size: 25))
                    }
                }
                    }
                    .padding()
        }
    func ColorSetter(theX:Double , theY:Double){
        let lightID = "b39673d2-5492-419e-a4e2-c8b2f7c2ed04"
            let urlString = "https://192.168.178.45/clip/v2/resource/light/\(lightID)"
            
            guard let url = URL(string: urlString) else {
                print("Invalid URL")
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            
            
            request.setValue("4c8YxJqixFicuEX83r2U3zcckk9D-kvY841VAS8C", forHTTPHeaderField: "hue-application-key")
        
        let bodyData: [String: [String: [String: Double]]] = ["color": ["xy": ["x":theX,"y":theY]]]
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
   
}

#Preview {
    ColorPickerView()
}
