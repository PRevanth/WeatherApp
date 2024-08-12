//
//  WeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Admin on 8/11/24.
//

import UIKit
import SwiftUI

class WeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var hostingControllerView: UIView!
    
    func configure(with title: String, subtitle: String) {
        let swiftUIView = WeatherCellView(title: title, subtitle: subtitle)
        let hostingController = UIHostingController(rootView: swiftUIView)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear // To match the cell's background
        
        hostingControllerView.addSubview(hostingController.view)
        
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: hostingControllerView.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: hostingControllerView.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: hostingControllerView.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: hostingControllerView.bottomAnchor)
        ])
    }
}

