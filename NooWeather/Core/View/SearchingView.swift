//
//  SearchingView.swift
//  NooWeather
//
//  Created by Yolima Pereira Ruiz on 17/01/25.
//

import SwiftUI

struct SearchingView: View {
    @ObservedObject var viewModel: WeatherViewModel
    private var suggestions: [CityModel] {
        viewModel.suggestions
    }
    
    let onCitySelected: (CityModel) -> Void

    var body: some View {
        VStack {
       
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(suggestions, id: \.id) { suggestion in
                        SuggestionCellView(city: suggestion) {
                            viewModel.getWeather(for: $0.name)
                            onCitySelected($0)
                            
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 10)
            }
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))

    }

}


#Preview {
    SearchingView(viewModel: weatherViewModelMock) { city in
                print("City selected: \(city.name)")
            }
}
