import Foundation
import RealHTTP

public typealias JSONDict = [String: AnyObject]

public struct WiktionaryAPI {
    
    public enum SearchType: CustomStringConvertible {
        case title
        case page
        
        public var description: String {
            switch self {
            case .title: return "title"
            case .page: return "page"
            }
        }
    }
    
    public enum WiktionaryError: Error {
        case DataError(String)
        case JSONSerializationError(String)
    }

    private var endpoint: String = "https://wikimedia.org/api.php"
    private var lang: String
    
    private let defaultSearchLimit: String = "50"

    public init(lang: String) {
        self.lang = lang
    }
    
    private func GetApiUrl() -> String {
        return "https://\(self.endpoint)/core/v1/wiktionary/\(self.lang)"
    }
    
    public func Search(type: SearchType, search: String, limit: String? = nil) async -> String {
        
        let url: URL = URL(string: "\(GetApiUrl())/\(type)/")!
        
        do {
            let req: HTTPRequest = HTTPRequest {
                $0.url = url
                $0.method = .get
                $0.timeout = 60
                $0.addQueryParameter(name: type.description, value: search)
                $0.addQueryParameter(name: "limit", value: limit ?? self.defaultSearchLimit)
            }
            
            let resp = try await req.fetch()
            return try resp.decode(String.self)
        } catch {
            return String.Empty
        }
        
    }
}
