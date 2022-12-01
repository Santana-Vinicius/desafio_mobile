//
//  ContentView.swift
//  desafio_mobile_ios
//
//  Created by Vinicius Araujo on 28/11/22.
//

import SwiftUI
import MapKit
import Combine

struct ContentView: View {
    @StateObject private var locationManager = LocationManager()
    @State var showAlert = false
    
    var body: some View {
        Map(
            coordinateRegion: $locationManager.region,
            showsUserLocation: true
        )
        .ignoresSafeArea()
        .onChange(of: locationManager.showAlert) { newValue in
            self.showAlert = newValue
        }
        .alert("Localização inativa!", isPresented: $showAlert, actions: {
            Button("Ok", role: .destructive) {}
        }, message: {
            Text("Você não habilitou as configurações de localização. Vá até configuração e permita.")
        })

    }

}

extension MKCoordinateRegion {
    static var brasiliaRegion: MKCoordinateRegion {
        MKCoordinateRegion(
            center: .init(latitude: -15.7975, longitude: -47.8919),
            span: .init(latitudeDelta: 0.5, longitudeDelta: 0.5)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
