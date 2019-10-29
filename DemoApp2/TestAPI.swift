//
//  TestAPI.swift
//  DemoApp2
//
//  Created by Svetoslav Savchev on 2019-10-29.
//  Copyright © 2019 SensorMedia. All rights reserved.
//

import Foundation
import Moya

public enum TestAPI {
    case color
    case text
}

struct APIColor: Decodable {
    let red: CGFloat
    let green: CGFloat
    let blue: CGFloat
    let alpha: CGFloat
}

struct APIText: Decodable {
    let text: String
}

extension TestAPI: TargetType {
    // Define base URL
    public var baseURL: URL {
        return URL(string: "http://51.79.20.91/0ss")!
    }

    // Define paths for API endpoints
    public var path: String {
        switch self {
            case .color: return "/color.php"
            case .text: return "/text.php"
        }
    }

    // Both APIs are consumed via GET requests
    public var method: Moya.Method {
        switch self {
            case .color: return .get
            case .text: return .get
        }
    }

    // No unit testing supported. Return empty Data object.
    public var sampleData: Data {
        return Data()
    }

    // Task is set to plain request
    public var task: Task {
        return .requestPlain
    }

    // Set content-type header to application/json
    public var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

    // Currently we look only at successful response code
    public var validationType: ValidationType {
        return .successCodes
    }
}
