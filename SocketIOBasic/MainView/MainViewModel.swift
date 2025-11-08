//
//  MainViewModel.swift
//  SocketIOBasic
//
//  Created by LCH on 11/8/25.
//

import Foundation
import Combine
import SocketIO

final class MainViewModel {
  
  @Published private(set) var statusMessage: String = "Disconnected"
  @Published private(set) var outputMessage: String = ""
  
  private var socketClient: SocketIOClient?
  private var socketManager: SocketManager?
  private let urlString = "http://<Mac IP>:8080"
  
  init() {
    setupSocket()
  }
  
  func sendMessage(_ message: String) {
    guard !message.isEmpty else { return }
    socketClient?.emit("message", message)
  }
  
  private func setupSocket() {
    guard let serverUrl = URL(string: urlString) else {
      statusMessage = "Invalid URL"
      return
    }
    socketManager = SocketManager(socketURL: serverUrl, config: [.log(true), .compress])
    socketClient = socketManager?.defaultSocket
    
    socketClient?.on(clientEvent: .connect) { [weak self] _, _ in
      self?.statusMessage = "Socket Connected"
    }
    
    socketClient?.on(clientEvent: .disconnect) { [weak self] _, _ in
      self?.statusMessage = "Socket Disconnected"
    }
    
    socketClient?.on(clientEvent: .error) { [weak self] _, _ in
      self?.statusMessage = "Socket Error"
    }
    
    socketClient?.on("message") { [weak self] data, _ in
      guard let self = self, let msg = data.first as? String else { return }
      
      let currentOutput = self.outputMessage
      self.outputMessage = currentOutput.isEmpty ? msg : "\(currentOutput)\n\(msg)"
    }
    
    socketClient?.connect()
  }
}
