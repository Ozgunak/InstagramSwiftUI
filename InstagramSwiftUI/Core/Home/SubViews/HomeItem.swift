//
//  HomeItem.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-18.
//

import SwiftUI

struct HomeItem: View {
    var body: some View {
        VStack {
            HStack {
                Image("pimage1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(.circle)
                
                Text("Ozgun Aksoy")
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        
            
            Image("city1")
                .resizable()
                .scaledToFill()
                .frame(height: 400)
                .clipShape(.rect)
            
            HStack{
                Image(systemName: "heart")
                Image(systemName: "bubble.right")
                Image(systemName: "paperplane")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.top, 2)
            
            Group {
                Text("Ozgun Aksoy ").fontWeight(.semibold) +
                Text("City Image 1")

            }
            .font(.footnote)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.top, 2)
            
            Text("6h")
                .font(.footnote)
                .fontWeight(.thin)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 2)
        }
    }
}

#Preview {
    HomeItem()
}
