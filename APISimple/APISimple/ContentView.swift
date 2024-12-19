//
//  ContentView.swift
//  APISimple
//
//  Created by Sena Uctuk on 12/18/24.
//

import SwiftUI

//Very bad UI Example. Please don't let your app look like this.
struct APODContentView: View {
    @StateObject private var viewModel = APODViewModel()
    
    var body: some View {
        NavigationView {
            content
                .navigationTitle("NASA Picture of the Day")
        }
        .task {
            await viewModel.fetchAPOD()
        }
    }
    
    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading {
            ProgressView("Loading...")
        } else if let error = viewModel.error {
            VStack(spacing: 16) {
                Text("Error loading data")
                    .font(.headline)
                Text(error.localizedDescription)
                    .foregroundColor(.red)
                Button("Try Again") {
                    Task {
                        await viewModel.fetchAPOD()
                    }
                }
            }
        } else if let apod = viewModel.apodData {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Title
                    Text(apod.title)
                        .font(.title)
                        .bold()
                    // Date
                    Text(apod.date)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    // Image
                    if apod.mediaType == "image",
                       let imageUrl = URL(string: apod.url) {
                        AsyncImage(url: imageUrl) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            case .failure(_):
                                Image(systemName: "photo")
                                    .font(.largeTitle)
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }
                    
                    // Explanation
                    Text(apod.explanation)
                        .font(.body)
                    
                    Spacer()
                }
                .padding()
            }
        } else {
            Text("No data available")
        }
    }
}

#Preview {
    APODContentView()
}
