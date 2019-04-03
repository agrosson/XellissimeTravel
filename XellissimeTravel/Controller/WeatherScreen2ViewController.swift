//
//  WeatherScreen2ViewController.swift
//  XellissimeTravel
//
//  Created by ALEXANDRE GROSSON on 03/04/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import UIKit

class WeatherScreen2ViewController: UIViewController {

    
    
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
        myWeatherCall.getWeather(fullUrl: url!, method: method, body: body) { (success, weatherObject) in
            if weatherObject != nil {
                print("Nous sommes à \(api.city), le \(String(describing: weatherObject!.date)) il fait \(String(describing: weatherObject!.description))")
                print("la température est \(String(describing: weatherObject!.temp)) degrés")
                 print("l'humidité est \(String(describing: weatherObject!.humidity)) %")
                 print("la pression est \(String(describing: weatherObject!.pressure)) hpa")
                 print("la vitesse du vent est \(String(describing: weatherObject!.windSpeed)) km/h")
                self.iconeWeatherImageView.image = UIImage(data: weatherObject!.iconData)
              
                self.iconeWeatherImageView.sizeToFit()
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
