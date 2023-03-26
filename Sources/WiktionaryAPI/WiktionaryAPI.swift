import Foundation

public typealias JSONDict = [String: AnyObject]

public struct WiktionaryAPI {
    
    public enum SearchType {
        case title
        case page
    }
    
    public enum WiktionaryError: Error {
        case DataError(String)
        case JSONSerializationError(String)
    }

    private var endpoint: String = "https://wikimedia.org/api.php"
    private var lang: String
    
    private let defaultSearchLimit: Int = 50
    
    private let session = URLSession(configuration: URLSessionConfiguration.default)

    public init(lang: String) {
        self.lang = lang
    }
    
    private func GetApiUrl() -> String {
        return "https://\(self.endpoint)/core/v1/wiktionary/\(self.lang)"
    }
    
    private func DispatchRequest(url: String, completion: @escaping (JSONDict?, Error?) -> Void) {
        let request: URLRequest = URLRequest(url: URL(string: url)!)
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error)
            } else {
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data) as? JSONDict
                        completion(json, nil)
                    } catch {
                        completion(nil, WiktionaryError.JSONSerializationError("Error converting response to JSONDict"))
                    }
                }
                completion(nil, WiktionaryError.DataError("Data was nil"))
            }
        }
        
        task.resume()
    }
    
    public func Search(type: SearchType, search: String, limit: Int? = nil, completion: @escaping (JSONDict?, Error?) -> Void) {
        
        let url: String
        if let limit = limit {
            url = "\(GetApiUrl())/\(type)/title?q=\(search)&limit=\(limit)"
        } else {
            url = "\(GetApiUrl())/\(type)/title?q=\(search)&limit=\(self.defaultSearchLimit)"
        }
        
        DispatchRequest(url: url, completion: completion)
    }
}
