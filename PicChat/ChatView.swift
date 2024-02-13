//
//  ChatView.swift
//  PicChat
//
//  Created by 森下翔登 on 2024/02/14.
//

//import SwiftUI
//
//struct Message: Identifiable {
//    let id: Int
//    let content: String
//}
//
//class ChatViewModel: ObservableObject {
//    @Published var messages: [Message] = []
//    
//    func sendMessage(_ messageContent: String) {
//        let newMessage = Message(id: messages.count + 1, content: messageContent)
//        messages.append(newMessage)
//    }
//}
//
//struct ChatView: View {
//    @State private var messageText = ""
//    @ObservedObject var chatViewModel = ChatViewModel()
//
// var body: some View {
//        VStack {
//            ScrollView {
//                ForEach(chatViewModel.messages) { message in
//                    Text(message.content)
//                }
//            }
//
//            HStack {
//                TextField("メッセージを入力", text: $messageText)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//
//                Button("送信") {
//                    if !messageText.isEmpty {
//                        chatViewModel.sendMessage(messageText)
//                        print($messageText)
//                        messageText = ""
//                    }
//                }
//            }.padding()
//        }
//    }
//}

import SwiftUI

struct Message: Identifiable {
    let id: Int
    let content: String
    let isCurrentUser: Bool // これでメッセージが現在のユーザーのものかどうかを判定します
}

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    
    func sendMessage(_ messageContent: String) {
        // isCurrentUserをtrueにして、これが現在のユーザーのメッセージであることを示します。
        let newMessage = Message(id: messages.count + 1, content: messageContent, isCurrentUser: true)
        messages.append(newMessage)
    }
}

struct ChatView: View {
    @State private var messageText = ""
    @ObservedObject var chatViewModel = ChatViewModel()

    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    ForEach(chatViewModel.messages) { message in
                        MessageView(message: message)
                    }
                }
            }

            HStack {
                TextField("メッセージを入力", text: $messageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("送信") {
                    if !messageText.isEmpty {
                        chatViewModel.sendMessage(messageText)
                        messageText = ""
                    }
                }
            }.padding()
        }
    }
}

struct MessageView: View {
    let message: Message

    var body: some View {
        HStack {
            if message.isCurrentUser {
                Spacer() // 現在のユーザーのメッセージは右側に表示
                Text(message.content)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(15)
                    .foregroundColor(.white)
            } else {
                Text(message.content)
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(15)
                    .foregroundColor(.white)
                Spacer() // 他のユーザーのメッセージは左側に表示
            }
        }
        .padding(message.isCurrentUser ? .leading : .trailing, 60)
        .padding(.vertical, 4)
    }
}



#Preview {
    ChatView()
}
