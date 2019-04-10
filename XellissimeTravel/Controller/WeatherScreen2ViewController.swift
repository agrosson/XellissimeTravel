//
//  WeatherScreen2ViewController.swift
//  XellissimeTravel
//
//  Created by ALEXANDRE GROSSON on 03/04/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import UIKit

class WeatherScreen2ViewController: UIViewController {
    
    @IBOutlet weak var nyTitleLabel: UILabel!
    @IBOutlet weak var chooseCityLabel: UILabel!
    
    @IBOutlet weak var searchButtonLabel: UIButton!
    
    @IBOutlet weak var currentSV: UIStackView!
    @IBOutlet weak var detailsSV: UIStackView!
    
    @IBOutlet weak var date1Label: UILabel!
    @IBOutlet weak var date2Label: UILabel!
    @IBOutlet weak var date3Label: UILabel!
    @IBOutlet weak var date4Label: UILabel!
    
    @IBOutlet weak var iconDate1: UIImageView!
    @IBOutlet weak var iconDate2: UIImageView!
    @IBOutlet weak var iconDate3: UIImageView!
    @IBOutlet weak var iconDate4: UIImageView!
    
    
    @IBOutlet weak var maxTempDate1: UILabel!
    @IBOutlet weak var maxTempDate2: UILabel!
    @IBOutlet weak var maxTempDate3: UILabel!
    @IBOutlet weak var maxTempDate4: UILabel!
    
    @IBOutlet weak var nextDaysLabel: UILabel!
    @IBOutlet weak var lineDate1: UIImageView!
    @IBOutlet weak var lineDate2: UIImageView!
    @IBOutlet weak var lineDate3: UIImageView!
    @IBOutlet weak var lineDate4: UIImageView!
    
    @IBOutlet weak var minTempDate1: UILabel!
    @IBOutlet weak var minTempDate2: UILabel!
    @IBOutlet weak var minTempDate3: UILabel!
    @IBOutlet weak var minTempDate4: UILabel!
    
    
    @IBOutlet weak var currentWeatherIconNY: UIImageView!
    @IBOutlet weak var currentTempLabelNY: UILabel!
    @IBOutlet weak var currentMinMaxLabelNY: UILabel!
    @IBOutlet weak var currentDetailsLabelNY: UILabel!
    
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentMinMaxLabel: UILabel!
    @IBOutlet weak var currentDetailsLabel: UILabel!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
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
        let targetDays = [0,8,16,24,32]
        
        myWeatherCall.getWeather(fullUrl: url!, method: method, body: body, dayArray: allDays) { (success, weatherObject) in
            if weatherObject != nil {
                for i in 0..<targetDays.count {
                    var tempMinDay: Double = weatherObject![targetDays[i]].tempMax
                    var tempMaxDay: Double = weatherObject![targetDays[i]].tempMin
                    for test in targetDays[i]...targetDays[i]+7{
                        tempMaxDay = max(tempMaxDay,weatherObject![test].tempMax)
                        tempMinDay = min(tempMinDay, weatherObject![test].tempMin)
                    }
                    if targetDays[i] == 0 {
                        self.currentWeatherIcon.image = UIImage(named: weatherObject![targetDays[i]].iconString)
                        self.currentTempLabel.text = String(format: "%.1f", weatherObject![targetDays[i]].temp)+"°C"
                        self.currentDetailsLabel.text = "Humidity: \(String(format: "%.1f", weatherObject![targetDays[i]].humidity)) %\nPressure: \(String(format: "%.0f", weatherObject![targetDays[i]].pressure)) hpa\nWind: \(String(format: "%.1f", weatherObject![targetDays[i]].windSpeed*3.6)) km/h"
                        self.currentMinMaxLabel.text = "Temp Max: \(String(format: "%.1f",tempMaxDay))°C\nTemp Min: \(String(format: "%.1f",tempMinDay))°C"
                    }
                    if targetDays[i] == 8 {
                        var dateToDisplay = weatherObject![targetDays[i]].date
                        self.date1Label.text = dateToDisplay.dateReformat()
                        self.iconDate1.image = UIImage(named: weatherObject![targetDays[i]].iconString)
                        self.iconDate1.sizeToFit()
                        self.maxTempDate1.text = "\(String(format: "%.1f",tempMaxDay))°C"
                        self.minTempDate1.text = "\(String(format: "%.1f",tempMinDay))°C"
                    
                    }
                    if targetDays[i] == 16 {
                        var dateToDisplay = weatherObject![targetDays[i]].date
                        self.date2Label.text = dateToDisplay.dateReformat()
                        self.iconDate2.image = UIImage(named: weatherObject![targetDays[i]].iconString)
                        self.iconDate2.sizeToFit()
                        self.maxTempDate2.text = "\(String(format: "%.1f",tempMaxDay))°C"
                        self.minTempDate2.text = "\(String(format: "%.1f",tempMinDay))°C"
                        
                    }
                    if targetDays[i] == 24 {
                        var dateToDisplay = weatherObject![targetDays[i]].date
                        self.date3Label.text = dateToDisplay.dateReformat()
                        self.iconDate3.image = UIImage(named: weatherObject![targetDays[i]].iconString)
                        self.iconDate3.sizeToFit()
                        self.maxTempDate3.text = "\(String(format: "%.1f",tempMaxDay))°C"
                        self.minTempDate3.text = "\(String(format: "%.1f",tempMinDay))°C"
                        
                    }
                    if targetDays[i] == 32 {
                        var dateToDisplay = weatherObject![targetDays[i]].date
                        self.date4Label.text = dateToDisplay.dateReformat()
                        self.iconDate4.image = UIImage(named: weatherObject![targetDays[i]].iconString)
                        self.iconDate4.sizeToFit()
                        self.maxTempDate4.text = "\(String(format: "%.1f",tempMaxDay))°C"
                        self.minTempDate4.text = "\(String(format: "%.1f",tempMinDay))°C"
                        
                    }
                }
                        self.hideLabelAtLaunch(hide: false)
            } else {
                self.presentAlertWeather()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = color3
        self.nyTitleLabel.textColor = .white
        self.chooseCityLabel.textColor = .white
        self.nextDaysLabel.textColor = .white
        self.searchButtonLabel.setTitleColor(.white, for: .normal)
        gestureTapCreation()
        navigationBarColor()
        setNYWeather()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(updateColor), name: .setNewColor1, object: nil)
        
    }
    @objc func updateColor(notification : Notification){
        
        view.backgroundColor = color3
        self.view.backgroundColor = color3
        self.nyTitleLabel.textColor = .white
        self.chooseCityLabel.textColor = .white
        self.nextDaysLabel.textColor = .white
        self.searchButtonLabel.setTitleColor(.white, for: .normal)
        navigationBarColor()
    }
    /**
     Function that creates a tapGestureRecognizer
     */
    private func gestureTapCreation(){
        let mytapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(myTap))
        mytapGestureRecognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(mytapGestureRecognizer)
    }
    /**
     Function that creates an action for a tapGestureRecognizer. Dissmiss Keyboard
     */
    @objc func myTap(){
        countryTextField.resignFirstResponder()
        cityTextField.resignFirstResponder()
    }
    
    private func presentAlertWeather() {
        hideLabelAtLaunch(hide: true)
        Alert.shared.controller = self
        Alert.shared.alertDisplay = .weatherRequestFailed
    }
    
    private func hideLabelAtLaunch(hide: Bool) {
        self.nextDaysLabel.isHidden = hide
        self.currentSV.isHidden = hide
        self.detailsSV.isHidden = hide
    }

    private func setNYWeather(){
        hideLabelAtLaunch(hide: true)
        let api = OpenweathermapAPI(city: "New York", country: "us")
        let method = api.httpMethod
        let body  = api.body
        let myWeatherCall = NetworkManager.shared
        let url = api.createFullUrl()
        var allDays: [Int] {
            var array = [Int]()
            for i in 0...7{
                array.append(i)
            }
            return array
        }
        let targetDays = [0]
        myWeatherCall.getWeather(fullUrl: url!, method: method, body: body, dayArray: allDays) { (success, weatherObject) in
            if weatherObject != nil {
                for i in 0..<targetDays.count {
                    var tempMinDay: Double = weatherObject![targetDays[i]].tempMax
                    var tempMaxDay: Double = weatherObject![targetDays[i]].tempMin
                    for test in targetDays[i]...targetDays[i]+7{
                        tempMaxDay = max(tempMaxDay,weatherObject![test].tempMax)
                        tempMinDay = min(tempMinDay, weatherObject![test].tempMin)
                    }
                    if targetDays[i] == 0 {
                        self.currentWeatherIconNY.image = UIImage(named: weatherObject![targetDays[i]].iconString)
                        // self.currentWeatherIcon.sizeToFit()
                        self.currentTempLabelNY.text = String(format: "%.1f", weatherObject![targetDays[i]].temp)+"°C"
                        self.currentDetailsLabelNY.text = "Humidity: \(String(format: "%.1f", weatherObject![targetDays[i]].humidity)) %\nPressure: \(String(format: "%.0f", weatherObject![targetDays[i]].pressure)) hpa\nWind: \(String(format: "%.1f", weatherObject![targetDays[i]].windSpeed*3.6)) km/h"
                        self.currentMinMaxLabelNY.text = "Temp Max: \(String(format: "%.1f",tempMaxDay))°C\nTemp Min: \(String(format: "%.1f",tempMinDay))°C"
                    }
                }
            } else {
                self.presentAlertWeather()
            }
        }
    }}

extension String {
    mutating func dateReformat() -> String{
        for _ in 1...5 {
            self = String(self.dropFirst())
        }
        for _ in 1...9 {
            self = String(self.dropLast())
        }
        let first2 = String(self.suffix(2))
        let last2 = String(self.prefix(2))
        self = "\(first2)/\(last2)"
        return self
    }
}

extension WeatherScreen2ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        cityTextField.resignFirstResponder()
        countryTextField.resignFirstResponder()
        return true
    }
}
