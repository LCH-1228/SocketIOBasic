//
//  MainView.swift
//  SocketIOBasic
//
//  Created by LCH on 11/8/25.
//

import UIKit

final class MainView: UIView {
  
  var onSendButton: (() -> Void)?
  
  private let statusLabel: UILabel = {
    let label = UILabel()
    label.text = "Status: Disconnected"
    label.font = .systemFont(ofSize: 16)
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let sendButton: UIButton = {
    let button = UIButton(configuration: .filled())
    button.setTitle("전송", for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  private let inpuitLabel: UILabel = {
    let label = UILabel()
    label.text = "입력창"
    label.font = .systemFont(ofSize: 16)
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let inputField: UITextView = {
    let textView = UITextView()
    textView.font = .systemFont(ofSize: 16)
    textView.textColor = .black
    textView.backgroundColor = .lightGray
    textView.translatesAutoresizingMaskIntoConstraints = false
    return textView
  }()
  
  private let outputLabel: UILabel = {
    let label = UILabel()
    label.text = "출력창"
    label.font = .systemFont(ofSize: 16)
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let outputField: UITextView = {
    let textView = UITextView()
    textView.font = .systemFont(ofSize: 16)
    textView.textColor = .black
    textView.backgroundColor = .lightGray
    textView.isUserInteractionEnabled = false
    textView.translatesAutoresizingMaskIntoConstraints = false
    return textView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
    
    backgroundColor = .white
    
    addSubview(statusLabel)
    addSubview(sendButton)
    addSubview(inpuitLabel)
    addSubview(inputField)
    addSubview(outputLabel)
    addSubview(outputField)
    
    NSLayoutConstraint.activate([
      statusLabel.centerYAnchor.constraint(equalTo: sendButton.centerYAnchor),
      statusLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
      
      sendButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
      sendButton.trailingAnchor.constraint(equalTo:  safeAreaLayoutGuide.trailingAnchor,constant: -20),
      
      inpuitLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 40),
      inpuitLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
      
      inputField.heightAnchor.constraint(equalToConstant: 160),
      inputField.centerXAnchor.constraint(equalTo: centerXAnchor),
      inputField.topAnchor.constraint(equalTo: inpuitLabel.bottomAnchor, constant: 4),
      inputField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
      inputField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
      
      outputLabel.topAnchor.constraint(equalTo: inputField.bottomAnchor, constant: 40),
      outputLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
      
      outputField.heightAnchor.constraint(equalToConstant: 160),
      outputField.centerXAnchor.constraint(equalTo: centerXAnchor),
      outputField.topAnchor.constraint(equalTo: outputLabel.bottomAnchor, constant: 4),
      outputField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
      outputField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)
    ])
  }
  
  @objc private func sendButtonTapped() {
    onSendButton?()
  }
  
  func setStatusLabel(title: String) {
    statusLabel.text = title
  }
  
  func getInputFieldText() -> String {
    return inputField.text
  }
  
  func resetInputField() {
    inputField.text = ""
  }
  
  func setOutputField(text: String) {
    outputField.text = text
  }
}
