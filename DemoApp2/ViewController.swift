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
    
    let provider = MoyaProvider<TestAPI>()
    
    @IBOutlet var testText: UILabel!
    @IBOutlet var testButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testText.isHidden = true
        testButton.isHidden = true
        
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

    @IBAction func testButtonClicked(_ sender: Any) {
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
    
    func updateBackgroundColor(color: UIColor) {
        DispatchQueue.main.async {
            self.view.backgroundColor = color;
        }
    }
    
    func updateAPIColor(color: APIColor) {
        DispatchQueue.main.async {
            self.view.backgroundColor = UIColor(red: color.red, green: color.green, blue: color.blue, alpha: color.alpha);
            self.testButton.isHidden = false
        }
    }
    
    func updateAPIText(text: APIText) {
        DispatchQueue.main.async {
            self.testText.isHidden = false
            self.testText.text = text.text;
        }
    }
}

