//
//  MessageUserView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-27.
//

import SwiftUI

struct MessageUserView: View {
    @StateObject var viewModel: MessageUserViewModel
    
    init(message: Message) {
        self._viewModel = StateObject(wrappedValue: MessageUserViewModel(message: message))
    }
    
    var body: some View {
        HStack{
            if let messanger = viewModel.messanger {
                IGCircularProfileImageView(user: messanger, size: .small)
                
                VStack(alignment: .leading) {
                    Text(messanger.fullName ?? messanger.username)
                        .font(.subheadline)
                    HStack {
                        Text("Last message: \(viewModel.message.messageText)")
                            .font(.caption)
                            .lineLimit(1)
                        Text(viewModel.message.timeStamp.dateValue().formatted(.relative(presentation: .named)))
                            .font(.caption)
                            .foregroundStyle(Color(.systemGray))
                        
                    }
                }
                Spacer()                
                Image(systemName: "camera")
            }
        }
        .padding(.horizontal)
        .task {
            do {
                try await viewModel.getMessageUser()
            } catch {
                print("Error: getting message user \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    MessageUserView(message: Message.MOCK_MESSAGE)
}
