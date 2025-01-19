//
//  SuggestionCellView.swift
//  NooWeather
//
//  Created by Yolima Pereira Ruiz on 18/01/25.
//

import SwiftUI

struct SuggestionCellView: View {
    let city: CityModel
    let onCitySelected: (CityModel) -> Void

    var body: some View {
        Button(action: {
            onCitySelected(city)
        }) {
            HStack {
                VStack(alignment: .leading) {
                    Text(city.name)
                        .font(.custom("Poppins-SemiBold", size: 20))
                        
                    Text("20")
                        .font(.custom("Poppins-Medium", size: 60))
                        
                }
                .padding(.leading, 32)
                Spacer()
                Image(systemName: "cloud.sun.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 83, height: 67)
                    .foregroundColor(.blue)
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
        }
        .buttonStyle(PlainButtonStyle())
        .frame(width: 336, height: 117)
    }
    
}

#Preview {
    SuggestionCellView(city: CityModel(id: 123,
                                       name: "Boston"),
                       onCitySelected: {_ in })
}
