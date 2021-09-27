//
//  ViewController.swift
//  Crowded
//
//  Created by Blain Ellis on 19/11/2020.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
       
    private var businesses: [Business] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        //Fetch the bussinesses
        NetworkController.shared.fetchBusinessess(completionBlock: updateBusinesses(businesses:))
    }

    func updateBusinesses(businesses: [Business]?) {
        if let businesses = businesses {
            self.businesses = businesses
        }
        reloadData()
    }
    
    func reloadData() {
        collectionView.reloadData()
        collectionView.layoutSubviews()
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.size.width
        return indexPath.item == 0 ? CGSize(width: width - 24, height: width/2 + 100) : CGSize(width: width/2 - 18, height: width/2 + 50)
    }
}

extension MainViewController: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                               withReuseIdentifier: LocationHeader.identifier, for: indexPath as IndexPath) as! LocationHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.businesses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let business = businesses[indexPath.item]
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedCollectionViewCell.identifier, for: indexPath) as! FeaturedCollectionViewCell
            
            cell.imageViewBorder.backgroundColor = business.settings.getBackgroundColour()
            cell.imageView.backgroundColor = business.settings.getBackgroundColour()
            cell.titleLabel.text = business.businessName
            cell.tagLabel.text = business.tagString
            cell.logo = business.images.logo
            
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BusinessCollectionViewCell.identifier, for: indexPath) as! BusinessCollectionViewCell
        
        cell.imageViewBorder.backgroundColor = business.settings.getBackgroundColour()
        cell.imageView.backgroundColor = business.settings.getBackgroundColour()
        cell.logo = business.images.logo
        cell.titleLabel.text = business.businessName.capitalized
        cell.tagLabel.text = business.tagString.lowercased()
        
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: String(describing: BusinessDetailViewController.self), sender: nil)
    }
}

extension MainViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == String(describing: BusinessDetailViewController.self) {
            if let destination = segue.destination as? BusinessDetailViewController {
                if let indexPath = collectionView.indexPathsForSelectedItems?.first {
                    destination.business = businesses[indexPath.item]
                    collectionView.deselectItem(at: indexPath, animated: true)
                }
            }
        }
    }
}

