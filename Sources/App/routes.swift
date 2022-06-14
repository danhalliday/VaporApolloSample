import Vapor
import Apollo

struct Network {
    static var shared = Network()

    private(set) lazy var apollo: ApolloClient = {
        let url = URL(string: "https://api.spacex.land/graphql/")!
        let configuration = URLSessionConfiguration.ephemeral
        let store = ApolloStore(cache: InMemoryNormalizedCache())
        let client = URLSessionClient(sessionConfiguration: configuration, callbackQueue: .main)
        let provider = DefaultInterceptorProvider(client: client, store: store)
        let transport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: url)

        return ApolloClient(networkTransport: transport, store: store)
    }()
}

extension DispatchQueue {
    static let apollo = DispatchQueue(label: "apollo")
}

func routes(_ app: Application) throws {
    app.get { req async throws -> String in
        return await withCheckedContinuation { continuation in
            print("Servicing request")

            Network.shared.apollo.fetch(query: LaunchesQuery(), queue: .apollo) { response in
                print("Returning response")
                continuation.resume(returning: "Hello World!")
            }
        }
    }
}
