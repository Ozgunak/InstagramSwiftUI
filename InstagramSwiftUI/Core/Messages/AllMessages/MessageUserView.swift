//
//  MessageUserView.swift
//  InstagramSwiftUI
//
//  Created by özgün aksoy on 2023-09-27.
//

import SwiftUI
import Firebase

@MainActor
class MessageUserViewModel: ObservableObject {
    @Published var message: Message
    @Published var messanger: User?
    
    init(message: Message) {
        self.message = message
    }
    
    func getMessageUser() async throws {
        messanger = try await UserManager.getUser(userID: message.messageWithId)
    }
}

struct MessageUserView: View {
    @StateObject var viewModel: MessageUserViewModel
    
    init(message: Message) {
        self._viewModel = StateObject(wrappedValue: MessageUserViewModel(message: message))
    }
    
    var body: some View {
        HStack{
            let _ = print("he")
            if let messanger = viewModel.messanger {
                let _ = print("name of user \(messanger.username)")
                IGCircularProfileImageView(user: messanger, size: .small)
                
                VStack(alignment: .leading) {
                    // name
                    Text(messanger.fullName ?? messanger.username)
                        .font(.subheadline)
                    HStack {
                        // last message
                        Text("Last message: \(viewModel.message.messageText)")
                            .font(.caption)
                        // last message time interval
                        Text(viewModel.message.timeStamp.dateValue().formatted(.relative(presentation: .named)))
                            .font(.caption)
                            .foregroundStyle(Color(.systemGray))
                        
                    }
                }
                Spacer()
                // isSeen dot
                
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
    MessageUserView(message: Message(messageId: "B7A1731B-51F9-4B55-A895-F91576E84D3D", ownerUid: "RyBNzroloScxW6JMfYsmtAtFxVm1", messageWithId: "Bt4sYd1cfwcOUzdvq3DnNVzycQJ2", messageText: "Hello", timeStamp: Timestamp()))
}
