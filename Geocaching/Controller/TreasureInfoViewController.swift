//
//  TreasureInfoViewController.swift
//  Geocaching
//
//  Created by Adrián Silva on 23/1/18.
//  Copyright © 2018 Adrián Silva. All rights reserved.
//

import UIKit

class TreasureInfoViewController: UIViewController {

    var initialTouchPoint: CGPoint = CGPoint(x: 0, y: 0)

    var treasure: Treasure?
    var distance: Double?

    var qr: QRViewController?
    
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var treasureTitleLabel: UILabel!
    @IBOutlet weak var infoTextView: UITextView!
    @IBOutlet weak var treasureAvailableLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        //NotificationCenter.default.addObserver(self, selector: #selector(changeAvailableLabelColor(_:)), name: NSNotification.Name(rawValue: "didRegisterTreasure"), object: nil)

        if let currentTreasure = treasure {
            treasureTitleLabel.text = currentTreasure.title
            infoTextView.text = currentTreasure.info
            if currentTreasure.isCatched == true {
                changeAvailableLabelColor(treasureAvailableLabel)
            }
        }

        if let distance = distance {
            distanceLabel.text = String(format: "%.1f", distance) + " metros"
        }
    }

//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }


    @IBAction func registerButtonPressed(_ sender: UIButton) {
        // TODO: Alert diciendo que no se puede registrar el tesoro
        if let distance = distance {
            if distance <= 70.0 {
                performSegue(withIdentifier: "goToQR", sender: self)
            }
        }
    }

    @IBAction func panGestureRecognizerHandler(_ sender: UIPanGestureRecognizer) {
        let touchPoint = sender.location(in: self.view?.window)

        if sender.state == UIGestureRecognizerState.began {
            initialTouchPoint = touchPoint
        } else if sender.state == UIGestureRecognizerState.changed {
            if touchPoint.y - initialTouchPoint.y > 0 {
                self.view.frame = CGRect(x: 0, y: touchPoint.y - initialTouchPoint.y, width: self.view.frame.size.width, height: self.view.frame.size.height)
            }
        } else if sender.state == UIGestureRecognizerState.ended || sender.state == UIGestureRecognizerState.cancelled {
            if touchPoint.y - initialTouchPoint.y > 300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
                })
            }
        }
    }

    @objc func changeAvailableLabelColor(_ label: UILabel) {
        label.backgroundColor = .red
        label.text = "No Disponible"
    }

}

extension TreasureInfoViewController: RegisterTreasureDelegate {

    func playerDidRegisterTreasure(bool: Bool) {
        changeAvailableLabelColor(treasureAvailableLabel)
        treasure?.isCatched = true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToQR" {
            let qRViewController = segue.destination as! QRViewController
            qRViewController.delegate = self
        }
    }


}
