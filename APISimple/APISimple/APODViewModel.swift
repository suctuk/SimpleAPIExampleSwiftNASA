//
//  APODViewModel.swift
//  APISimple
//
//  Created by Sena Uctuk on 12/18/24.
//

import Foundation

@MainActor
class APODViewModel: ObservableObject {
    @Published var apodData: APODResponse?
    @Published var isLoading = false
    @Published var error: Error?
    
    func fetchAPOD() async {
        isLoading = true
        error = nil
        
        do {
            // Replace with your API key from api.nasa.gov
            let apiKey = "Your_Key_Here"
            let urlString = "https://api.nasa.gov/planetary/apod?api_key=\(apiKey)"
            
            guard let url = URL(string: urlString) else {
                throw URLError(.badURL)
            }
            
            let (data, _) = try await URLSession.shared.data(from: url)
           print("Raw JSON Data:", String(data: data, encoding: .utf8) ?? "Could not convert data to string")

            let decoder = JSONDecoder()
            apodData = try decoder.decode(APODResponse.self, from: data)
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
}
