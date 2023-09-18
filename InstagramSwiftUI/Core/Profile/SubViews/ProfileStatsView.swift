//
//  ProfileStatsView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-18.
//

import SwiftUI

struct ProfileStatsView: View {
    let count: Int
    let title: String
    
    var body: some View {
        VStack {
            Text("\(count)")
                .font(.footnote)
                .fontWeight(.semibold)
            Text(title)
                .font(.footnote)

        }
        
    }
}

#Preview {
    ProfileStatsView(count: 13, title: "Posts")
}
