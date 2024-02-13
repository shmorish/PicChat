//
//  ChatView.swift
//  PicChat
//
//  Created by 森下翔登 on 2024/02/14.
//

import SwiftUI

struct Message: Identifiable {
    let id: Int
    let content: String
    let isCurrentUser: Bool
    let isLogMessage : Bool
}


class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    
    func sendMessage(_ messageContent: String, isCurrentUser: Bool = true, isLogMessage: Bool = false) {
        let newMessage = Message(id: messages.count + 1, content: messageContent, isCurrentUser: isCurrentUser, isLogMessage: isLogMessage)
        messages.append(newMessage)
    }

    // ユーザーが入室した際のメッセージを追加するメソッド
    func userDidEnter(username: String) {
        let enterMessage = "\(username)さんが入室しました"
        sendMessage(enterMessage, isLogMessage: true)
    }
}

struct ChatView: View {
    @State private var messageText = ""
    @ObservedObject var chatViewModel = ChatViewModel()
    var userName: String // ユーザー名を受け取るためのプロパティ

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
                        chatViewModel.sendMessage(messageText, isCurrentUser: true) // 現在のユーザーのメッセージとして送信
                        messageText = ""
                    }
                }
            }.padding()
        }
        .onAppear {
            chatViewModel.userDidEnter(username: userName) // ビューが表示された時にユーザー入室メッセージを追加
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: EmptyView())
    }
}

struct MessageView: View {
    let message: Message

    var body: some View {
        HStack {
            if message.isLogMessage
            {
                Spacer()
                Text(message.content)
                    .padding()
                    .foregroundColor(.green)
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.center)
                Spacer()
            } else if message.isCurrentUser {
                Spacer()
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
                Spacer()
            }
        }
        .padding(message.isCurrentUser ? .leading : .trailing, 60)
        .padding(.vertical, 4)
    }
}



#Preview {
    ChatView(userName: "test")
}
