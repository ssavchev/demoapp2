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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        provider.request(.color) { [weak self] result in
            guard let self = self else { return }

            switch result {
                case .success(let response):
                    do {
                        //let json = try response.mapJSON();
                        //print(json)
                        let color = try response.map(APIColor.self)
                        self.updateAPIColor(color: color)
                    } catch {
                        //print("exception")
                        self.updateBackgroundColor(color: UIColor.systemPink)
                    }
                case .failure:
                    //print("failure");
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
        }
    }
}

