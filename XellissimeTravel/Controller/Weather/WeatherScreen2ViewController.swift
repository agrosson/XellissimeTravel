//
//  WeatherScreen2ViewController.swift
//  XellissimeTravel
//
//  Created by ALEXANDRE GROSSON on 03/04/2019.
//  Copyright © 2019 GROSSON. All rights reserved.
//

import UIKit

class WeatherScreen2ViewController: UIViewController {
    
    
    @IBOutlet weak var popoverCityLabel: UILabel!
    @IBOutlet var popoverView: UIView!
    
    @IBAction func popoverButtonBackPressed(_ sender: Any) {
        self.popoverView.removeFromSuperview()
        hideViewWhenPopover(hide: false)
    }
    @IBOutlet weak var nextDayButton: UIButton!
    @IBAction func nextDaysButtonPressed(_ sender: Any) {
        if chooseCityLabel.text == weatherLabelChooseCityText {
            Alert.shared.controller = self
            Alert.shared.alertDisplay = .pressSearchFirst
        } else {
            
            self.popoverCityLabel.text = cityTextField.text?.uppercased()
            //   hideViewWhenPopover(hide: true)
            self.view.addSubview(popoverView)
            popoverView.backgroundColor = Parameter.shared.colors[0]
            let test = self.tabBarController?.tabBar.frame.height
            print(test! as Any)
            popoverView.center = CGPoint(x: view.frame.width/2,
                                         y: (view.frame.height-popoverView.frame.height/2)-test!-1)
        }

    }

    // MARK: - Outlets - Labels
    // Labels for NY block
    @IBOutlet weak var nyTitleLabel: UILabel!
    @IBOutlet weak var currentTempLabelNY: UILabel!
    @IBOutlet weak var currentMinMaxLabelNY: UILabel!
    @IBOutlet weak var currentDetailsLabelNY: UILabel!
    // Labels for research city block
    @IBOutlet weak var chooseCityLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var currentMinMaxLabel: UILabel!
    @IBOutlet weak var currentDetailsLabel: UILabel!

    // Labels details date
    @IBOutlet weak var date1Label: UILabel!
    @IBOutlet weak var date2Label: UILabel!
    @IBOutlet weak var date3Label: UILabel!
    @IBOutlet weak var date4Label: UILabel!
    // Labels details maxTemp
    @IBOutlet weak var maxTempDate1: UILabel!
    @IBOutlet weak var maxTempDate2: UILabel!
    @IBOutlet weak var maxTempDate3: UILabel!
    @IBOutlet weak var maxTempDate4: UILabel!
    @IBOutlet weak var minTempDate1: UILabel!
    // Labels details minTemp
    @IBOutlet weak var minTempDate2: UILabel!
    @IBOutlet weak var minTempDate3: UILabel!
    @IBOutlet weak var minTempDate4: UILabel!
    // MARK: - Outlets - StackViews
    @IBOutlet weak var currentSV: UIStackView!
    @IBOutlet weak var detailsSV: UIStackView!
    @IBOutlet weak var nySV: UIStackView!
    @IBOutlet weak var inputSV: UIStackView!
    // MARK: - Outlets - ImageViews
    // Image for NY Block
    @IBOutlet weak var currentWeatherIconNY: UIImageView!
    // Image for current city Block
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    // Images for details
    @IBOutlet weak var iconDate1: UIImageView!
    @IBOutlet weak var iconDate2: UIImageView!
    @IBOutlet weak var iconDate3: UIImageView!
    @IBOutlet weak var iconDate4: UIImageView!
    @IBOutlet weak var lineDate1: UIImageView!
    @IBOutlet weak var lineDate2: UIImageView!
    @IBOutlet weak var lineDate3: UIImageView!
    @IBOutlet weak var lineDate4: UIImageView!
    // MARK: - Outlets - TextFields
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    // MARK: - Outlets - Button
    @IBOutlet weak var searchButtonLabel: UIButton!
    // MARK: - Outlets - Activity indicator
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    // MARK: - Actions
    /**
     Action that launches request to get weather from a given city
     */
    @IBAction func getWeatherButtonPressed(_ sender: UIButton) {
        countryTextField.resignFirstResponder()
        cityTextField.resignFirstResponder()
        chooseCityLabel.text = "\(cityTextField.text?.capitalized ?? "")"
        toggleActivityIndicator(shown: true)
        // get city from textField
        let city = cityTextField.text
        // get country from textField
        let countryCode = countryTextField.text
        // Prepare request
        let api = OpenweathermapAPI(city: city!, country: countryCode!)
        let method = api.httpMethod
        let body  = api.body
        let myWeatherCall = NetworkManager.shared
        let url = api.createFullUrl()
        /// Create an array to retrieve items in json dictionary
        var allDays: [Int] {
            var array = [Int]()
            for item in 0...39{
                array.append(item)
            }
            return array
        }
        /// Array that sets the targeted days : each day has 8 weatherObject items
        let targetDays = [0, 8, 16, 24, 32]
        // Send request
        myWeatherCall.getWeather(fullUrl: url!, method: method, body: body, dayArray: allDays) { (success, weatherObject) in
            self.toggleActivityIndicator(shown: false)
            if weatherObject != nil {
                // for each day...
                for element in 0..<targetDays.count {
                    // ... we create 2 variables...
                    var tempMinDay: Double = weatherObject![targetDays[element]].tempMax
                    var tempMaxDay: Double = weatherObject![targetDays[element]].tempMin
                    // ... and get the max et min value in the range of 8 weatherObject items of the selected day
                    for test in targetDays[element]...targetDays[element]+7{
                        tempMaxDay = max(tempMaxDay,weatherObject![test].tempMax)
                        tempMinDay = min(tempMinDay, weatherObject![test].tempMin)
                    }
                    // For current Day, information are displayed in first block
                    if targetDays[element] == 0 {
                        self.currentWeatherIcon.image = UIImage(named: weatherObject![targetDays[element]].iconString)
                        self.currentTempLabel.text = String(format: "%.1f", weatherObject![targetDays[element]].temp)+"°C"
                        self.currentDetailsLabel.text = "Humidity: \(String(format: "%.1f", weatherObject![targetDays[element]].humidity)) %\nPressure: \(String(format: "%.0f", weatherObject![targetDays[element]].pressure)) hpa\nWind: \(String(format: "%.1f", weatherObject![targetDays[element]].windSpeed*3.6)) km/h"
                        self.currentMinMaxLabel.text = "Temp Max: \(String(format: "%.1f", tempMaxDay))°C\nTemp Min: \(String(format: "%.1f",tempMinDay))°C"
                    }
                    // for next 4 days ( i = 8 or 16 or 24 or 32), info displayed in details block
                    if targetDays[element] == 8 {
                        var dateToDisplay = weatherObject![targetDays[element]].date
                        self.date1Label.text = dateToDisplay.dateReformat()
                        self.iconDate1.image = UIImage(named: weatherObject![targetDays[element]].iconString)
                        self.iconDate1.sizeToFit()
                        self.maxTempDate1.text = "\(String(format: "%.1f", tempMaxDay))°C"
                        self.minTempDate1.text = "\(String(format: "%.1f", tempMinDay))°C"
                    }
                    if targetDays[element] == 16 {
                        var dateToDisplay = weatherObject![targetDays[element]].date
                        self.date2Label.text = dateToDisplay.dateReformat()
                        self.iconDate2.image = UIImage(named: weatherObject![targetDays[element]].iconString)
                        self.iconDate2.sizeToFit()
                        self.maxTempDate2.text = "\(String(format: "%.1f",tempMaxDay))°C"
                        self.minTempDate2.text = "\(String(format: "%.1f",tempMinDay))°C"
                    }
                    if targetDays[element] == 24 {
                        var dateToDisplay = weatherObject![targetDays[element]].date
                        self.date3Label.text = dateToDisplay.dateReformat()
                        self.iconDate3.image = UIImage(named: weatherObject![targetDays[element]].iconString)
                        self.iconDate3.sizeToFit()
                        self.maxTempDate3.text = "\(String(format: "%.1f",tempMaxDay))°C"
                        self.minTempDate3.text = "\(String(format: "%.1f",tempMinDay))°C"
                    }
                    if targetDays[element] == 32 {
                        var dateToDisplay = weatherObject![targetDays[element]].date
                        self.date4Label.text = dateToDisplay.dateReformat()
                        self.iconDate4.image = UIImage(named: weatherObject![targetDays[element]].iconString)
                        self.iconDate4.sizeToFit()
                        self.maxTempDate4.text = "\(String(format: "%.1f",tempMaxDay))°C"
                        self.minTempDate4.text = "\(String(format: "%.1f",tempMinDay))°C"
                    }
                }
                    self.hideLabelAtLaunch(hide: false)
            } else {
                self.hideLabelAtLaunch(hide: true)
                Alert.shared.controller = self
                Alert.shared.alertDisplay = .weatherRequestFailed
            }
        }
    }
    // MARK: - Methods - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Parameter.shared.colors[2]
        popoverView.layer.cornerRadius = 50
        self.nyTitleLabel.textColor = .white
        self.chooseCityLabel.textColor = .white
        self.chooseCityLabel.text = weatherLabelChooseCityText
        self.nextDayButton.tintColor = .white
        self.searchButtonLabel.setTitleColor(.white, for: .normal)
        gestureTapCreation()
        gestureSwipeCreation()
        navigationBarColor()
        setNYWeather()
    }
    // MARK: - Methods - ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(updateColor), name: .setNewColor1, object: nil)
        
    }
    // MARK: - Methods
    /**
     Function to show/hide activity indicator
     */
    private func toggleActivityIndicator(shown: Bool){
        activityIndicator.isHidden = !shown
        searchButtonLabel.isHidden = shown
    }
    /**
     Function to get USD/EUR rate
     */
    @objc func updateColor(notification : Notification){
        view.backgroundColor = Parameter.shared.colors[2]
        self.view.backgroundColor = Parameter.shared.colors[2]
        self.popoverView.backgroundColor = Parameter.shared.colors[0]
        self.nyTitleLabel.textColor = .white
        self.chooseCityLabel.textColor = .white
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
     Function that creates a SwipeGestureRecognizer
     */
    private func gestureSwipeCreation(){
        let mySwipeGestureRecognizer =
            UISwipeGestureRecognizer(target: self, action: #selector(myTap))
    mySwipeGestureRecognizer.direction = .down
    self.view.addGestureRecognizer(mySwipeGestureRecognizer)
    }
    
    /**
     Function that creates an action for a tapGestureRecognizer. Dissmiss Keyboard
     */
    @objc func myTap(){
        countryTextField.resignFirstResponder()
        cityTextField.resignFirstResponder()
        popoverView.removeFromSuperview()
    }
    /**
     Function that hides or displays labels and stackviews
     */
    private func hideLabelAtLaunch(hide: Bool) {
        self.currentSV.isHidden = hide
        self.nextDayButton.isHidden = hide
    }
    
    private func hideViewWhenPopover(hide: Bool) {
        self.nyTitleLabel.isHidden = hide
        self.nySV.isHidden = hide
        self.chooseCityLabel.isHidden = hide
        self.inputSV.isHidden = hide
        self.currentSV.isHidden = hide
        self.nextDayButton.isHidden = hide
        self.searchButtonLabel.isHidden = hide
    }
    
    
    /**
     Function that sends a request to get NY Weather when viewDidLoad
     */
    private func setNYWeather() {
        toggleActivityIndicator(shown: true)
        hideLabelAtLaunch(hide: true)
        let api = OpenweathermapAPI(city: "New York", country: "us")
        let method = api.httpMethod
        let body  = api.body
        let myWeatherCall = NetworkManager.shared
        let url = api.createFullUrl()
        var allDays: [Int] {
            var array = [Int]()
            for item in 0...7 {
                array.append(item)
            }
            return array
        }
        let targetDays = [0]
        myWeatherCall.getWeather(fullUrl: url!, method: method, body: body, dayArray: allDays) { (success, weatherObject) in
            self.toggleActivityIndicator(shown: false)
            if weatherObject != nil {
                for item in 0..<targetDays.count {
                    var tempMinDay: Double = weatherObject![targetDays[item]].tempMax
                    var tempMaxDay: Double = weatherObject![targetDays[item]].tempMin
                    for test in targetDays[item]...targetDays[item]+7 {
                        tempMaxDay = max(tempMaxDay,weatherObject![test].tempMax)
                        tempMinDay = min(tempMinDay, weatherObject![test].tempMin)
                    }
                    if targetDays[item] == 0 {
                        self.currentWeatherIconNY.image = UIImage(named: weatherObject![targetDays[item]].iconString)
                        // self.currentWeatherIcon.sizeToFit()
                        self.currentTempLabelNY.text = String(format: "%.1f", weatherObject![targetDays[item]].temp)+"°C"
                        self.currentDetailsLabelNY.text = "Humidity: \(String(format: "%.1f", weatherObject![targetDays[item]].humidity)) %\nPressure: \(String(format: "%.0f", weatherObject![targetDays[item]].pressure)) hpa\nWind: \(String(format: "%.1f", weatherObject![targetDays[item]].windSpeed*3.6)) km/h"
                        self.currentMinMaxLabelNY.text = "Temp Max: \(String(format: "%.1f",tempMaxDay))°C\nTemp Min: \(String(format: "%.1f",tempMinDay))°C"
                    }
                }
            } else {
                self.hideLabelAtLaunch(hide: true)
                Alert.shared.controller = self
                Alert.shared.alertDisplay = .weatherRequestFailed
            }
        }
    }}
// MARK: - Extension

extension String {
    /**
     Function that reformat date from JSON file and return a shorter date format as a string
     */
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
    func textFieldDidBeginEditing(_ textField: UITextField) {
    chooseCityLabel.text = weatherLabelChooseCityText
        popoverView.removeFromSuperview()
    }
}
