//
//  PostGridView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-24.
//

import SwiftUI
import Kingfisher

struct PostGridView: View {
    let posts: [Post]
    var isLoading: Bool
    
    private let gridColumns: [GridItem] = [
        GridItem(.flexible(), spacing: 1),
        GridItem(.flexible(), spacing: 1),
        GridItem(.flexible(), spacing: 1)
    ]
    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 3) - 1
    
    
    var body: some View {
        VStack {
            if isLoading {
                LottieView(name: .loading, loopMode: .loop)
                    .frame(width: 250, height: 250)
            } else {
                LazyVGrid(columns: gridColumns, spacing: 1 ) {
                    ForEach(posts) { post in
                        NavigationLink {
                            PostsView(user: post.user, post: post)
                                .navigationBarBackButtonHidden()
                        } label: {
                            KFImage(URL(string: post.imageURL))
                                .resizable()
                                .scaledToFill()
                                .frame(width: imageDimension, height: imageDimension)
                                .clipped()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    PostGridView(posts: [], isLoading: false)
}
