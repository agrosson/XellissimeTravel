//
//  WeatherScreen2ViewController.swift
//  XellissimeTravel
//
//  Created by ALEXANDRE GROSSON on 03/04/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import UIKit

class WeatherScreen2ViewController: UIViewController {

    
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var currentTempLabel: UILabel!
    
    @IBOutlet weak var currentMinMax: UILabel!
    @IBOutlet weak var currentDetailsLabel: UILabel!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var iconeWeatherImageView: UIImageView!
    @IBAction func getWeatherButtonPressed(_ sender: UIButton) {
        let city = cityTextField.text
        let countryCode = countryTextField.text
        let api = OpenweathermapAPI(city: city!, country: countryCode!)
        let method = api.httpMethod
        let body  = api.body
        let myWeatherCall = NetworkManager.shared
        let url = api.createFullUrl()
        var allDays: [Int] {
            var array = [Int]()
            for i in 0...39{
                array.append(i)
            }
            return array
        }
        let mytestdays = [0,8,16,24,32]
        //let numberOfDaysForecast = 4
            myWeatherCall.getWeather(fullUrl: url!, method: method, body: body, dayArray: allDays) { (success, weatherObject) in
                if weatherObject != nil {
                    
                    // Get value for current condition
                    // mytestdays[i]
                    
                    
                    
                    for i in 0..<mytestdays.count {
                        print("Nous sommes à \(api.city) avec un essai à \(mytestdays[i]), le \(String(describing: weatherObject![mytestdays[i]].date)) il fait \(String(describing: weatherObject![mytestdays[i]].description))")
                        print("la température est \(String(describing: weatherObject![mytestdays[i]].temp)) degrés")
                        var tempMinDay: Double = weatherObject![mytestdays[i]].tempMax
                        var tempMaxDay: Double = weatherObject![mytestdays[i]].tempMin
                        for test in mytestdays[i]...mytestdays[i]+7{
                            tempMaxDay = max(tempMaxDay,weatherObject![test].tempMax)
                            tempMinDay = min(tempMinDay, weatherObject![test].tempMin)
                        }
                        print("la température minimale du jour est \(String(describing: tempMinDay)) degrés")
                        print("la température maximale du jour est \(String(describing: tempMaxDay)) degrés")
                        print("l'humidité est \(String(describing: weatherObject![mytestdays[i]].humidity)) %")
                        print("la pression est \(String(describing: weatherObject![mytestdays[i]].pressure)) hpa")
                        print("la vitesse du vent est \(String(describing: weatherObject![mytestdays[i]].windSpeed*3.6)) km/h")
                        if mytestdays[i] == 0 {
                            self.currentWeatherIcon.image = UIImage(named: weatherObject![mytestdays[i]].iconString)
                           // self.currentWeatherIcon.sizeToFit()
                            self.currentTempLabel.text = String(format: "%.1f", weatherObject![mytestdays[i]].temp)+"°C"
                            self.currentDetailsLabel.text = "Humidity: \(String(format: "%.1f", weatherObject![mytestdays[i]].humidity)) %\nPressure: \(String(format: "%.0f", weatherObject![mytestdays[i]].pressure)) hpa\nWind: \(String(format: "%.1f", weatherObject![mytestdays[i]].windSpeed*3.6)) km/h"
                            self.currentMinMax.text = "Temp Max: \(String(format: "%.1f",tempMaxDay))\nTemp Min: \(String(format: "%.1f",tempMinDay))"
                        }
                        self.iconeWeatherImageView.image = UIImage(named: weatherObject![mytestdays[i]].iconString)
                        self.iconeWeatherImageView.sizeToFit()
                    }

                } else {
                    print("to be completed because erreur")
                }
            }
        

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
