//
//  ViewController.swift
//  SocketIOBasic
//
//  Created by LCH on 11/8/25.
//

import UIKit
import Combine

final class MainViewController: UIViewController {
  
  private let mainView: MainView
  private let viewModel: MainViewModel
  private var cancellables = Set<AnyCancellable>()
  
  init(mainView: MainView, viewModel: MainViewModel) {
    self.mainView = mainView
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupBindings()
  }
  
  private func setupView() {
    view.addSubview(mainView)
    
    mainView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      mainView.topAnchor.constraint(equalTo: view.topAnchor),
      mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
    
    mainView.onSendButton = { [weak self] in
      guard let self else { return }
      self.viewModel.sendMessage(self.mainView.getInputFieldText())
      self.mainView.resetInputField()
      self.view.endEditing(true)
    }
  }
  
  private func setupBindings() {
    viewModel.$statusMessage
      .receive(on: DispatchQueue.main)
      .sink { [weak self] status in
        self?.mainView.setStatusLabel(title: "Status: \(status)")
      }
      .store(in: &cancellables)
    
    viewModel.$outputMessage
      .receive(on: DispatchQueue.main)
      .sink { [weak self] message in
        self?.mainView.setOutputField(text: message)
      }
      .store(in: &cancellables)
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
}
