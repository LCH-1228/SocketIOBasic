//
//  ViewController.swift
//  SocketIOBasic
//
//  Created by LCH on 11/8/25.
//

import UIKit

final class MainViewController: UIViewController {
  
  private let mainView: MainView
  
  init(mainView: MainView) {
    self.mainView = mainView
    super.init(nibName: nil, bundle: nil)
  }
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
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
      print(self.mainView.getInputFieldText())
      self.mainView.resetInputField()
      self.view.endEditing(true)
    }
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    view.endEditing(true)
  }
}
