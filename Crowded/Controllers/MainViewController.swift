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
        
        if indexPath.item == 0 {
            return CGSize(width: view.frame.size.width - 24, height: view.frame.size.width/2 + 100)
        }
        return CGSize(width: view.frame.size.width/2 - 18, height: view.frame.size.width/2 + 50)
    }
}

extension MainViewController: UICollectionViewDataSource {
    

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                                 withReuseIdentifier: "LocationHeader", for: indexPath as IndexPath) as! LocationHeader
                return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.businesses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedCollectionViewCell.identifier, for: indexPath) as! FeaturedCollectionViewCell
             cell.business = businesses[indexPath.item]
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BusinessCollectionViewCell.identifier, for: indexPath) as! BusinessCollectionViewCell
         cell.business = businesses[indexPath.item]
        return cell
    }
}
extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "openBusinessSegue", sender: nil)
    }
}

extension MainViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openBusinessSegue" {
            if let destination = segue.destination as? BusinessDetailViewController {
                if let indexPath = collectionView.indexPathsForSelectedItems?.first {
                    destination.business = businesses[indexPath.item]
                    self.collectionView.deselectItem(at: indexPath, animated: true)
                }
            }
        }
    }
}

