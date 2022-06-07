//
//  MapView.swift
//  Weather_App
//
//  Created by Bartek Wanot on 21/04/2022.
//

import SwiftUI
import MapKit




struct myMapView: UIViewRepresentable {
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject var navigationManager: NavigationManager
        func updateUIView(_ mapView: MKMapView, context: Context) {

            let span = MKCoordinateSpan(
                latitudeDelta: 0.30,
                longitudeDelta: 0.30)
            
            let startCoordinate = locationManager.location
            let region = MKCoordinateRegion(center: startCoordinate!, span: span)
            mapView.setRegion(region, animated: true)

        }
        

        func makeUIView(context: Context) -> MKMapView {

            let myMap = MKMapView(frame: .zero)
            let longPress = UILongPressGestureRecognizer(target: context.coordinator, action: #selector(MapViewCoordinator.addAnnotation(gesture:)))
            longPress.minimumPressDuration = 1
            myMap.addGestureRecognizer(longPress)
            myMap.delegate = context.coordinator
            return myMap

        }

    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator(self, self.navigationManager)
    }

    class MapViewCoordinator: NSObject, MKMapViewDelegate {
        var mapViewController: myMapView
        var navigationManager: NavigationManager
        
        init(_ control: myMapView,_ navi:NavigationManager) {
            self.mapViewController = control
            self.navigationManager = navi
        }


        @objc func addAnnotation(gesture: UIGestureRecognizer) {
            if gesture.state == .began {

                if let mapView = gesture.view as? MKMapView {
                    let point = gesture.location(in: mapView)
                    let coordinate = mapView.convert(point, toCoordinateFrom: mapView)
                    //navigationManager.mainScreen()
                    print(coordinate)
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate
                    mapView.addAnnotation(annotation)
                    navigationManager.setByMap(coords: coordinate)
                }
            }
        }
    }
}


struct MapView: View {
    
    @EnvironmentObject var navigationManager: NavigationManager
    @EnvironmentObject var locationManager: LocationManager
    
        var body: some View {
            ZStack{
                myMapView()
                    .edgesIgnoringSafeArea(.all)
                    .environmentObject(locationManager)
                    .environmentObject(navigationManager)
            VStack
                {
                    Spacer()
                    HStack{
                        Button {
                            navigationManager.mainScreen()
                        } label :{
                            Label("Back", systemImage:"arrow.left")
                        }
                        .buttonStyle(.bordered)
                        .padding(.horizontal, 4.0)
                        .cornerRadius(50)
                        .symbolVariant(.fill)
                        .foregroundColor(.white)
                        
                        /*Button {
                            
                            print("")
                        } label :{
                            Label("Search city", systemImage:     "magnifyingglass")
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(.horizontal, 4.0)
                        .cornerRadius(50)
                        .symbolVariant(.fill)
                        .foregroundColor(.white) */
                    }
                }
                
            }
        }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

