//
//  ViewController.swift
//  WeatherApp
//
//  Created by Patrick Bellot on 11/22/17.
//  Copyright © 2017 Polestar Interactive LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var cityLabel: UILabel!
  @IBOutlet weak var mainLabel: UILabel!
  @IBOutlet weak var tempLabel: UILabel!
  @IBOutlet weak var humidityLabel: UILabel!
  @IBOutlet weak var hiTempLabel: UILabel!
  @IBOutlet weak var loTempLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var iconImage: UIImageView!
  
  let shared = WeatherService.shared
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    searchCity()
    self.shared.getWeather(forCity: (self.cityLabel.text)!) { (success, response, error) in
      if success {
        guard let currentWeather = response as? CurrentWeather else { return }
        // TODO: Get current weather values
        if weather == currentWeather.list {
          self.mainLabel.text = currentWeather.list[0].weather[0].main-
        }
      
      
        // TODO: Update outlets with values
      } else if let error = error {
        print(error)
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
      self.shared.getWeather(forCity: (self.cityLabel.text?.uppercased())!, completion: { (success, response, error) in
        if success {
          print("City name selected")
        } else if let error = error {
          print(error)
        }
      })
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

