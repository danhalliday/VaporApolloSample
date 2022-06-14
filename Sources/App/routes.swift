import Vapor
import Apollo

func routes(_ app: Application) throws {
    app.get { req async throws -> String in
        await withCheckedContinuation { continuation in
            print("Servicing request")
            let client = ApolloClient(url: URL(string: "https://api.spacex.land/graphql/")!)

            client.fetch(query: LaunchesQuery()) { response in
                print("Returning response (never called)")
                continuation.resume(returning: "Hello World!")
            }
        }
    }
}
