//
//  CategoryCollectionViewCell.swift
//  money-mapp
//
//  Created by Alice Wu on 8/2/18.
//  Copyright © 2018 Alice Wu. All rights reserved.
//

import UIKit

// Controls the collection view cells that represent purchase categories
class CategoryCollectionViewCell: UICollectionViewCell, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var category_image_view: UIImageView!
    @IBOutlet weak var category_label: UILabel!
    
    // TODO: set the budget_button tag to the category ID
    @IBOutlet weak var budget_button: UIButton!
    @IBOutlet weak var delete_button: UIButton!
    
    var parent : CategoriesVC!
    var index_path : IndexPath!
    var category : Category!
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        return layoutAttributes
    }
    
    // adds a tap gesture recognizer to this instance to forwards touch to CategoriesVC
    func addTap() {
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(sendParent))
        self.addGestureRecognizer(tap)
    }
    
    // adds long press gesture to delete cells
    func addLongPress() {
        let long_press = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        self.addGestureRecognizer(long_press)
    }
    
    @objc func longPressed() {
        for i in 0...parent.categories.count {
            guard let cell = parent.collection_view.cellForItem(at: IndexPath(row: i, section: 0)) as? CategoryCollectionViewCell else { return }
            cell.delete_button.isHidden = false
            cell.wiggle(cell)
        }
    }
    
    @IBAction func deletePressed(_ sender: Any) {
        parent.confirmCategoryDeletion(category)
    }
    
    @objc func sendParent() {
        parent.collectionView(parent.collection_view, didSelectItemAt: index_path)
    }
    
    
    // MARK: Collection view cell animation functions
    func wiggle(_ cell: UICollectionViewCell) {
        CATransaction.begin()
        CATransaction.setDisableActions(false)
        cell.layer.add(rotationAnimation(), forKey: "rotation")
        cell.layer.add(bounceAnimation(), forKey: "bounce")
        CATransaction.commit()
    }
    
    private func rotationAnimation() -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        let angle = CGFloat(0.01)
        let duration = TimeInterval(0.4)
        let variance = Double(0.025)
        animation.values = [angle, -angle]
        animation.autoreverses = true
        animation.duration = self.randomizeInterval(interval: duration, withVariance: variance)
        animation.repeatCount = Float.infinity
        return animation
    }
    
    private func bounceAnimation() -> CAKeyframeAnimation {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        let bounce = CGFloat(2.0)
        let duration = TimeInterval(0.2)
        let variance = Double(0.015)
        animation.values = [bounce, -bounce]
        animation.autoreverses = true
        animation.duration = self.randomizeInterval(interval: duration, withVariance: variance)
        animation.repeatCount = Float.infinity
        return animation
    }
    
    private func randomizeInterval(interval: TimeInterval, withVariance variance:Double) -> TimeInterval {
        let random = (Double(arc4random_uniform(1000)) - 500.0) / 500.0
        return interval + variance * random;
    }
}