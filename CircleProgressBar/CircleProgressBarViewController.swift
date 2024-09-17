import UIKit

final class CircleProgressBarViewController: UIViewController {
    
    private let orangeLoader = CAShapeLayer()
    private let grayCircle = CAShapeLayer()
    
    private var circleCenter: CGPoint {
        return CGPoint(x: view.bounds.midX, y: view.bounds.midY)
    }
    
    private var circleRadius: CGFloat {
        return view.bounds.width * 0.6 / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        createGrayCircle()
        createRoundedProgressBar()
        animateRoundedProgressBar()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(restartAnimation))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func createRoundedProgressBar() {
        let circularPath = UIBezierPath(arcCenter: circleCenter,
                                        radius: circleRadius,
                                        startAngle: 3 * CGFloat.pi / 2,
                                        endAngle: -CGFloat.pi / 2,
                                        clockwise: false)
        orangeLoader.path = circularPath.cgPath
        orangeLoader.fillColor = UIColor.clear.cgColor
        orangeLoader.strokeColor = UIColor.orange.cgColor
        orangeLoader.lineWidth = 20
        orangeLoader.lineCap = .round
        orangeLoader.strokeEnd = 0
        view.layer.addSublayer(orangeLoader)
    }
    
    private func createGrayCircle() {
        let circularPath = UIBezierPath(arcCenter: circleCenter,
                                        radius: circleRadius,
                                        startAngle: -CGFloat.pi / 2,
                                        endAngle: 3 * CGFloat.pi / 2,
                                        clockwise: true)
        grayCircle.path = circularPath.cgPath
        grayCircle.fillColor = UIColor.clear.cgColor
        grayCircle.strokeColor = UIColor.lightGray.cgColor
        grayCircle.zPosition = -1
        grayCircle.lineWidth = 20
        view.layer.insertSublayer(grayCircle, below: orangeLoader)
    }
    
    private func animateRoundedProgressBar(duration: TimeInterval = 2, toValue: CGFloat = 1) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = toValue
        animation.duration = duration
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        orangeLoader.add(animation, forKey: "circleProgressAnimation")
    }
    
    @objc
    private func restartAnimation() {
        orangeLoader.removeAnimation(forKey: "circleProgressAnimation")
        orangeLoader.strokeEnd = 0
        animateRoundedProgressBar()
    }
}
