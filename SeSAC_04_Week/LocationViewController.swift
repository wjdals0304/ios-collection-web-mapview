//
//  LocationViewController.swift
//  SeSAC_04_Week
//
//  Created by 김정민 on 2021/10/20.
//

import UIKit
import MapKit
import CoreLocation
import CoreLocationUI // ios 15 LocationButton
import WebKit


class LocationViewController: UIViewController {

    @IBOutlet weak var userCurrentLocationLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    //1.CLLocationManager()
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //37.556224338786436, 126.9723641115476
        let location = CLLocationCoordinate2D(latitude: 37.556224338786436, longitude: 126.9723641115476)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    
        let annotation = MKPointAnnotation()
        
        annotation.title = "Here!!!"
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
        
        //맵뷰에 어노테이션을 삭제하고자 할 때
//        let annotations = mapView.annotations
//        mapView.removeAnnotation(annotations as! MKAnnotation)
        
        mapView.delegate = self
        
        // 2.
        locationManager.delegate = self
        
    }
    

}


// 3.
extension LocationViewController : CLLocationManagerDelegate {
    
    //9.iOs 버전에 따른 분기 처리와 iOS 위치 서비스 여부 확인
    func checkUserLocationServicesAuthorization() {
        
        let authorizationStatus : CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus // iOS14 이상
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus() // iOS 14 미만

        }
        
        // ios 위치 서비스 확인
        if CLLocationManager.locationServicesEnabled() {
            //권한 상태 확인 및 권한 요청 가능(8번 메서드 실행)
            checkCurrentLocationAuthorization(authorizationStatus)
        } else {
            print("iOS 위치 서비스를 켜주세요")
        }
        
    }
    
    //8. 사용자의 권한 상태 확인(UDF 사용자 정의 함수로 프로토콜 내 메서드가 아님!!!)
    // 사용자가 위치를 허용했는지 안 했는지 거부한건지 이런 권한을 확인! ( 단, ios 위치 서비스가 가능한 지 확인)
    func checkCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        
        switch authorizationStatus {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization() //앱을 사용하는 동안에 대한 권한 요청
            locationManager.startUpdatingHeading() // 위치 접근 시작! => didUpdateLocations 실행
        case .restricted, .denied:
            print("denied, 설정으로 유도")
        case .authorizedWhenInUse:
            locationManager.startUpdatingHeading() // 위치 접근 시작! => didUpdateLocations 실행
        case .authorizedAlways:
            print("Always")
        @unknown default :
            print("default")
        }
        
        if #available(iOS 14.0, *) {
            // 정확도 체크 : 정확도 감소가 되어 있을 경우,1시간 4번만  , 미리 알림 안갈수도 ,배터리 오래 쓸수, 워치8
            
            let accurancyStatus = locationManager.accuracyAuthorization
            
            switch accurancyStatus {
            case .fullAccuracy:
                print("FULL")
            case .reducedAccuracy:
                print("REDUCE")
            @unknown default :
                print("default")
            }
        }
        
        
    }
    
    

    // 4. 사용자가 위치 허용을 한 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        print(locations)
        
        if let coordinate = locations.last?.coordinate {
            
            let annotation = MKPointAnnotation()
            annotation.title = "CURRENT LOCATION"
            annotation.coordinate  = coordinate
            mapView.addAnnotation(annotation)
            
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.setRegion(region, animated: true)
            
            //10. (중요)
            locationManager.stopUpdatingLocation()
            
            
        } else {
            print("location cannot find")
        }
    }
    
    // 5. 위치 접근이 실패했을 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
    
    // 6. ios14 미만: 앱이 위치 관리자를 생성하고 , 승인 상태가 변경이 될 때 대리자에게 승인 상태를 알려줌,
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager,didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
        checkUserLocationServicesAuthorization()
    }
    
    
    // 7. ios14 이상: 앱이 위치 관리자를 생성하고 , 승인 상태가 변경이 될때 대리자에게 승인 상태를 알려줌
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkUserLocationServicesAuthorization()

    }
    
}


extension LocationViewController : MKMapViewDelegate {
    
    // 맵 어노테이션 클릭 시 이벤트 핸들링
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("나 여기 있다.")
    }
    
}
