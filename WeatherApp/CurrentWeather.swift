//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Patrick Bellot on 11/22/17.
//  Copyright © 2017 Polestar Interactive LLC. All rights reserved.
//

import Foundation

struct CurrentWeather: Decodable {
  let name: String
  let weather: [Weather]
  let main: Main
}

struct Weather: Decodable {
  let main: String
  let description: String
  let icon: String
}

struct Main: Decodable {
  let temp: Double
  let humidity: Int
  let hiTemp: Double
  let loTemp: Double
  
  private enum CodingKeys: String, CodingKey {
    case temp
    case humidity
    case hiTemp = "temp_max"
    case loTemp = "temp_min"
  }
}
