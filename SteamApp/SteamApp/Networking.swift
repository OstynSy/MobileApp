import Foundation

struct Networking {
    
    let baseURLString = "https://store.steampowered.com/api/featuredcategories"
    
    func fetchGames() async throws -> Welcome {
        let url = URL(string: "\(baseURLString)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode(Welcome.self, from: data)
    }
}
