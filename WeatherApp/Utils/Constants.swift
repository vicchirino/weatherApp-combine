//
//  Constants.swift
//  WeatherApp
//
//  Created by Victor Chirino on 22/06/2022.
//

import Foundation


struct Constants {

    struct URLs {
        static func weather(city: String) -> String {
            guard let path = Bundle.main.path(forResource: "keys", ofType: "plist") else {
                fatalError("Can't find the keys file")
            }
            
            guard let keysDictionary = NSDictionary(contentsOfFile: path) else {
                fatalError("Unable to get keys dictionary from path")
             }
            
            guard let appId = keysDictionary.object(forKey: "OPEN_WEATHER_APP_ID") else {
                fatalError("OPEN_WEATHER_APP_ID is not defined")
            }
            return "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(appId)&units=metric"
        }
    }
}
