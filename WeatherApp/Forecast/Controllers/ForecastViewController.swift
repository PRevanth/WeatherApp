//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Admin on 8/11/24.
//

import CoreLocation
import SwiftUI

class ForecastViewController: UIViewController {
    var viewModel = ForecastViewModel(respository: ForecastRepository())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let childView = UIHostingController(rootView: ForecastView(viewModel: viewModel))
        addChild(childView)
        childView.view.frame = self.view.bounds
        self.view.addSubview(childView.view)
        childView.didMove(toParent: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationPermissionIfNotAuthorized()
    }
    
    private func locationPermissionIfNotAuthorized() {
        viewModel.isLoading = true
        if viewModel.hasUserDeniedLocationAcess {
            let alertController = UIAlertController(title: "Location Permission Required", message: "Please enable location permissions in settings.", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
                //Redirect to Settings app
                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alertController.addAction(cancelAction)
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
