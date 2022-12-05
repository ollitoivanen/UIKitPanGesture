//
//  ViewController.swift
//  UIKitPanGesture
//
//  Created by Olli Toivanen on 23.11.2022.
//

import UIKit

class ViewController: UIViewController {

    private var initialCenter: CGPoint = .zero

    //General pannable view
    let pannableView: UIView = {
        let pannableView = UIView(frame: CGRect(origin: .zero,
                             size: CGSize(width: 200.0, height: 200.0)))

        pannableView.backgroundColor = .red
        pannableView.translatesAutoresizingMaskIntoConstraints = false
        return pannableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        //Adds the rectangle to the view that this controller manages.
        view.addSubview(pannableView)

        // Center Pannable View
        pannableView.center = view.center

        // Initialize Swipe Gesture Recognizer
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))

        // Add Swipe Gesture Recognizer
        pannableView.addGestureRecognizer(panGestureRecognizer)
    }

    //Objective-C call
    @objc private func didPan(_ sender: UIPanGestureRecognizer) {

        //Makes the moving of the rectangle smooth as the transaltion
        //of the users finger is added to the center value. This prevents
        //the rectangle from jumping when the user doesn't grab the rectangle
        //from the middle.
        switch sender.state {
            case .began:
                initialCenter = pannableView.center
            case .changed:
                let translation = sender.translation(in: view)

                pannableView.center = CGPoint(x: initialCenter.x + translation.x,
                                              y: initialCenter.y + translation.y)
            default:
                break
        }
    }
}

