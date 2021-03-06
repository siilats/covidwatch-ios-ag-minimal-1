//
//  Created by Madhava Jay on 1/5/20.
//

import Foundation

enum AppScheme: CustomStringConvertible {
    case production
    case development
    
    var description: String {
        switch self {
            case .production:
                return "Production"
            case .development:
                return "Development"
        }
    }
}

func getLocalIP() -> String {
    // sometimes the xcode ip sniff fails, in that case you can just
    // hard code it during development
    //return "192.168.176.132"
    if let localIP = Bundle.main.infoDictionary?["LocalIP"] as? String {
        return localIP
    }
    return "localhost"
}

func getLocalFirebaseHost() -> String {
    let firebasePort = 8080
    return "\(getLocalIP()):\(firebasePort)"
}

func getAPIUrl(_ scheme: AppScheme) -> String {
    let firebaseProjectId = "covidwatch-354ce"
    func getLocalURL() -> String {
        let localProtocol = "http://"
        let localPort = 5001
        let projectSlug = "\(firebaseProjectId)/us-central1"
        return "\(localProtocol)\(getLocalIP()):\(localPort)/\(projectSlug)"
    }
    
    switch scheme {
        case .production:
            return "https://us-central1-\(firebaseProjectId).cloudfunctions.net"
        default:
            return getLocalURL()
    }
}

func getAppScheme() -> AppScheme {
    if let schemeName = Bundle.main.infoDictionary?["SchemeName"] as? String {
        switch schemeName {
            case "CovidWatch-prod":
                return .production
            default:
                return .development
        }
    }
    return .development
}
