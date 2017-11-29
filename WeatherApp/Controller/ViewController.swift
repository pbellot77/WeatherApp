//
//  ViewController.swift
//  WeatherApp
//
//  Created by Patrick Bellot on 11/22/17.
//  Copyright © 2017 Polestar Interactive LLC. All rights reserved.
//

import UIKit

enum APIError: Error {
  case apiError
  case responseError
  case jsonDecoder
  case unknown
}

class ViewController: UIViewController {

  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var mainLabel: UILabel!
  @IBOutlet weak var tempLabel: UILabel!
  @IBOutlet weak var humidityLabel: UILabel!
  @IBOutlet weak var hiTempLabel: UILabel!
  @IBOutlet weak var loTempLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var iconImage: UIImageView!
  
  var defaults: UserDefaults = UserDefaults.standard
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    defaults.set(true, forKey: self.cityLabel.text!)
    
    searchCity()
  }
  
  func getWeather(forCity: String) {
    guard let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(forCity)&APPID=ba639933d32f48c47d197ac099fa0ec4") else { return }
    let session = URLSession.shared
    session.dataTask(with: url) { (data, response, error) in
      guard error == nil else {
        print("Error: \(APIError.apiError)")
        return
      }
      guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
        print("Error: \(APIError.responseError)")
        return
      }
      guard let data = data else { return }
      do {
        let currentWeather = try JSONDecoder().decode(CurrentWeather.self, from: data)
        print(currentWeather)
        DispatchQueue.main.async {
          self.mainLabel.text = currentWeather.weather[0].main
          self.descriptionLabel.text = currentWeather.weather[0].description
          self.tempLabel.text = String(currentWeather.main.temp)
          self.hiTempLabel.text = String(currentWeather.main.hiTemp)
          self.loTempLabel.text = String(currentWeather.main.loTemp)
          self.humidityLabel.text = String(currentWeather.main.humidity)
          let icon = currentWeather.weather[0].icon
          self.getImage(icon: icon)
        }
      } catch {
        print("Error: \(APIError.jsonDecoder)")
        DispatchQueue.main.async {
          print(error)
        }
      }
    }.resume()
  }
  
  func getImage(icon: String) {
    let url = "http://openweathermap.org/img/w/\(icon).png"
    DispatchQueue.global().async {
      let data = try? Data(contentsOf: URL(string: url)!)
        DispatchQueue.main.async {
          self.iconImage.image = UIImage(data: data!)
      }
    }
  }
  
  func searchCity() {
    let alert = UIAlertController(title: "City", message: "Enter a city", preferredStyle: .alert)
    let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    let ok = UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction) in
      print("OK pressed")
      let textField = alert.textFields?[0]
      self.cityLabel.text = textField?.text!
      self.getWeather(forCity: (self.cityLabel.text?.uppercased())!)
    }
    alert.addTextField { (textfield: UITextField) in
      textfield.placeholder = "City Name"
    }
    alert.addAction(cancel)
    alert.addAction(ok)
    
    present(alert, animated: true, completion: nil)
  }
  
  @IBAction func searchTapped(_ sender: Any) {
    searchCity()
  }
} // end of class
