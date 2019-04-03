//
//  WeatherScreen2ViewController.swift
//  XellissimeTravel
//
//  Created by ALEXANDRE GROSSON on 03/04/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import UIKit

class WeatherScreen2ViewController: UIViewController {

    @IBAction func getWeatherButtonPressed(_ sender: UIButton) {
        
        let api = OpenweathermapAPI(city: "Malaga", country: "es")
        let method = api.httpMethod
        let body  = api.body
        let myWeatherCall = NetworkManager.shared
        let url = api.createFullUrl()
        myWeatherCall.getWeather(fullUrl: url!, method: method, body: body) { (success, weatherObject) in
            if weatherObject != nil {
                print("Nous sommes à \(api.city), le \(String(describing: weatherObject!.date)) il fait \(String(describing: weatherObject!.description))")
                print("la température est \(String(describing: weatherObject!.temp)) degrés")
                 print("l'humidité est \(String(describing: weatherObject!.humidity)) %")
                 print("la pression est \(String(describing: weatherObject!.pressure)) hpa")
                 print("la vitesse du vent est \(String(describing: weatherObject!.windSpeed)) km/h")
                
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
