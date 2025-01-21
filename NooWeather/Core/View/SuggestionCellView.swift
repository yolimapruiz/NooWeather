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
                        .padding(.top, 16)
                        
                    HStack {
                        Text("20")
                            .font(.custom("Poppins-Medium", size: 60))
                        VStack {
                            Text("°")
                                .font(.custom("Poppins-Regular", size: 45))
                                .foregroundStyle(Color.customDarkGray)
                                .fontWeight(.bold)
                            
                            Spacer()
                        }
                    }
                    .padding(.bottom, 16)
                        
                }
                .padding(.leading, 32)
                Spacer()
                Image("Group 37")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 83, height: 67)
                    .foregroundColor(.blue)
                    .padding(.trailing, 31)
            }
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
