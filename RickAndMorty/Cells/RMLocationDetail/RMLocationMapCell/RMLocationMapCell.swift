//
//  RMLocationMapCell.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 8.05.2023.
//

import UIKit
import MapKit

final class RMLocationMapCell: UICollectionViewCell {
    static let cellIdentifier = "RMLocationMapCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(named: "DarkGrey")
        setUpLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUpLayer() {
        layer.cornerRadius = 8
        layer.masksToBounds = true
        layer.borderWidth = 0.5
        layer.borderColor = UIColor(named: "BlackColor")?.cgColor
    }

    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with viewModel: RMLocationMapCellVM) {
        let mapView = MKMapView(frame: contentView.frame)
        contentView.addSubview(mapView)

        let location = ["Los Angeles, CA", "New York, NY", "Chicago, IL", "Austin, TX", "Atlanta, GA", "Baltimore, MD", "Boston, MA", "Dallas, TX", "Miami, FL", "New Orleans, LA", "Philadelphia, PA", "Portland, OR", "San Francisco, CA", "Seattle, WA", "Washington, DC", "Nashville, TN", "Charleston, SC", "Savannah, GA", "Albuquerque, NM", "Santa Fe, NM"]
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location.randomElement() ?? "İstanbul") { (placemarks, error) in
            guard let location = placemarks?.first?.location else { return }
            let region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
            mapView.setRegion(region, animated: true)
        }
    }
}
