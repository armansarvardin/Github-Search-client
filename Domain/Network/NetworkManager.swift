import Foundation
import Combine

public enum APIError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    // Add more error cases as needed
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    // Add more HTTP methods as needed
}

protocol TargetType {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
    var queryParameters: [String: String]? { get }
    var decoder: JSONDecoder { get }
}

extension TargetType {
    var defaultHeaders: [String: String] {
        [
            "Accept": "application/vnd.github+json",
            "Authorization": "Bearer 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",
            "X-GitHub-Api-Version": "2022-11-28"
        ]
    }
}

struct NetworkManager {
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: TargetType, R: Decodable>(_ target: T, responseType: R.Type) -> AnyPublisher<R, APIError> {
        guard var components = URLComponents(url: target.baseURL.appendingPathComponent(target.path), resolvingAgainstBaseURL: true) else {
            return Fail(error: APIError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        // Add query parameters to URL
        if let queryParameters = target.queryParameters {
            components.queryItems = queryParameters.map { key, value in
                URLQueryItem(name: key, value: value)
            }
        }
        
        guard let url = components.url else {
            return Fail(error: APIError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = target.method.rawValue
        request.allHTTPHeaderFields = target.headers
        request.httpBody = target.body
        
        return session.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      200...299 ~= httpResponse.statusCode else {
                    throw APIError.invalidResponse
                }
                return data
            }
            .mapError { error -> APIError in
                if let apiError = error as? APIError {
                    return apiError
                } else {
                    return APIError.requestFailed(error)
                }
            }
            .flatMap { data -> AnyPublisher<R, APIError> in
                do {
                    let decodedResponse = try target.decoder.decode(R.self, from: data)
                    return Result.success(decodedResponse)
                        .publisher
                        .append(Empty<R, APIError>(completeImmediately: true))
                        .eraseToAnyPublisher()
                } catch {
                    return Result.failure(APIError.requestFailed(error))
                        .publisher
                        .eraseToAnyPublisher()
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
