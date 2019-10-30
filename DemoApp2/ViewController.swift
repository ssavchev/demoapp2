//
//  ViewController.swift
//  DemoApp2
//
//  Created by Svetoslav Savchev on 2019-10-29.
//  Copyright © 2019 SensorMedia. All rights reserved.
//

import UIKit
import Moya

class ViewController: UIViewController {
    
    // Moya provider class instance
    let provider = MoyaProvider<TestAPI>()
    
    // button control class instance
    @IBOutlet var testButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initially hide the button
        testButton.isHidden = true
        
        // call first API through the Moya provider
        provider.request(.color) { [weak self] result in
            guard let self = self else { return }

            switch result {
                case .success(let response):
                    do {
                        let color = try response.map(APIColor.self)
                        self.updateAPIColor(color: color)
                    } catch {
                        self.updateBackgroundColor(color: UIColor.systemPink)
                    }
                case .failure:
                    self.updateBackgroundColor(color: UIColor.systemRed)
            }
        }
    }

    // button on click handler
    @IBAction func testButtonClicked(_ sender: Any) {
        // call second API through the Moya provider
        provider.request(.text) { [weak self] result in
            guard let self = self else { return }

            switch result {
                case .success(let response):
                    do {
                        let text = try response.map(APIText.self)
                        self.updateAPIText(text: text)
                    } catch {
                        self.updateBackgroundColor(color: UIColor.systemPink)
                    }
                case .failure:
                    self.updateBackgroundColor(color: UIColor.systemRed)
            }
        }
    }
    
    // update background color in case of error
    // the call is routed through the main thread
    func updateBackgroundColor(color: UIColor) {
        DispatchQueue.main.async {
            self.view.backgroundColor = color;
        }
    }
    
    // set background color to the color returned from first API
    // the call is routed through the main thread
    func updateAPIColor(color: APIColor) {
        DispatchQueue.main.async {
            self.view.backgroundColor = UIColor(red: color.red, green: color.green, blue: color.blue, alpha: color.alpha);
            self.testButton.isHidden = false
        }
    }
    
    // show alert with the text returned from second API
    // the call is routed through the main thread
    func updateAPIText(text: APIText) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Response text", message: text.text, preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

            self.present(alert, animated: true)
        }
    }

}

