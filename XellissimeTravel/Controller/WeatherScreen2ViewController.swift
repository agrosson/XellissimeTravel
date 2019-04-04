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
        let mytestdays = [0,8,16,24,32]
        //let numberOfDaysForecast = 4
            myWeatherCall.getWeather(fullUrl: url!, method: method, body: body, dayArray: mytestdays) { (success, weatherObject) in
                if weatherObject != nil {
                    for i in 0..<mytestdays.count {
                        print("Nous sommes à \(api.city) avec un essai à \(i), le \(String(describing: weatherObject![i].date)) il fait \(String(describing: weatherObject![i].description))")
                        print("la température est \(String(describing: weatherObject![i].temp)) degrés")
                        print("l'humidité est \(String(describing: weatherObject![i].humidity)) %")
                        print("la pression est \(String(describing: weatherObject![i].pressure)) hpa")
                        print("la vitesse du vent est \(String(describing: weatherObject![i].windSpeed)) km/h")
                        self.iconeWeatherImageView.image = UIImage(named: weatherObject![i].iconString)
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
