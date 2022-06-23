//
//  Webservice.swift
//  WeatherApp
//
//  Created by Victor Chirino on 22/06/2022.
//

import Foundation
import Combine

class Webservice {
    func fetchWeather(city: String) -> AnyPublisher<Weather, Error> {
        guard let url = URL(string: Constants.URLs.weather(city: city)) else {
            fatalError("Invalid URL")
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .handleEvents(receiveSubscription: { _ in print("Recieve subscription")}, receiveCompletion: { _ in
                print("recieve completion")
            }, receiveCancel: {
                print("recieve cancel")
            }, receiveRequest: { _ in
                print("recieve request")
            })
            .map { $0.data }
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .map { $0.main }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher() // When you return a publisher is going to box the publisher and return it
    }
}
