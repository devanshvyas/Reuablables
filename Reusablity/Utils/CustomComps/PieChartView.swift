//
//  PieChartView.swift
//  Pie Chart View
//
//  Created by Hamish Knight on 04/03/2016.
//  Copyright © 2016 Redonkulous Apps. All rights reserved.
//

import UIKit
import Kingfisher

/// Defines a segment of the pie chart.
struct Segment {
    /// The image of the segment.
    var imageURL: String
    
    var isNowPlaying: Bool
}

extension Collection where Element : Numeric {
    func sum() -> Element {
        return reduce(0, +)
    }
}

extension NumberFormatter {
    static let toOneDecimalPlace: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 1
        return formatter
    }()
}

extension CGRect {
    init(centeredOn center: CGPoint, size: CGSize) {
        self.init(
            origin: CGPoint(
                x: center.x - size.width * 0.5, y: center.y - size.height * 0.5
            ),
            size: size
        )
    }
    
    var center: CGPoint {
        return CGPoint(
            x: origin.x + size.width * 0.5, y: origin.y + size.height * 0.5
        )
    }
}

extension CGPoint {
    func projected(by value: CGFloat, angle: CGFloat) -> CGPoint {
        return CGPoint(
            x: x + value * cos(angle), y: y + value * sin(angle)
        )
    }
}

extension UIColor {
    struct RGBAComponents {
        var red: CGFloat
        var green: CGFloat
        var blue: CGFloat
        var alpha: CGFloat
    }
    
    var rgbaComponents: RGBAComponents {
        var components = RGBAComponents(red: 0, green: 0, blue: 0, alpha: 0)
        getRed(&components.red, green: &components.green, blue: &components.blue,
               alpha: &components.alpha)
        return components
    }
    
    var brightness: CGFloat {
        return rgbaComponents.brightness
    }
}

extension UIColor.RGBAComponents {
    var brightness: CGFloat {
        return (red + green + blue) / 3
    }
}

class PieChartView : UIView {
    
    /// An array of structs representing the segments of the pie chart.
    var segments = [Segment]() {
        // Re-draw view when the values get set.
        didSet { setNeedsDisplay() }
    }
    
    /// Defines whether the segment labels should be shown when drawing the pie
    /// chart.
    var showSegmentLabels: Bool = true {
        didSet { setNeedsDisplay() }
    }
    
    /// The font to be used on the segment labels
    var segmentLabelFont: UIFont = UIFont.systemFont(ofSize: 14) {
        didSet {
            textAttributes[.font] = segmentLabelFont
            setNeedsDisplay()
        }
    }
    
    // The ratio of how far away from the center of the pie chart the text
    // will appear.
    var textPositionOffset: CGFloat = 0.67 {
        didSet { setNeedsDisplay() }
    }
    
    let grayShades: [UIColor] = [UIColor(red: 42/255, green: 42/255, blue: 42/255, alpha: 1), UIColor.darkGray, UIColor.gray, UIColor.lightGray, UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1)]
    
    private let paragraphStyle: NSParagraphStyle = {
        var p = NSMutableParagraphStyle()
        p.alignment = .center
        return p.copy() as! NSParagraphStyle
    }()
    
    private lazy var textAttributes: [NSAttributedString.Key: Any] = [
        .paragraphStyle: self.paragraphStyle, .font: self.segmentLabelFont
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        // When overriding drawRect, you must specify this to maintain transparency.
        isOpaque = false
    }
    
    private func forEachSegment(
        _ body: (Segment, _ startAngle: CGFloat,
        _ endAngle: CGFloat, _ index: Int) -> Void
        ) {
        // Enumerate the total value of the segments by using reduce to sum them.
        let valueCount = segments.lazy.map { _ in 1.0/CGFloat(self.segments.count) }.sum()
        
        // The starting angle is -90 degrees (top of the circle, as the context is
        // flipped). By default, 0 is the right hand side of the circle, with the
        // positive angle being in an anti-clockwise direction (same as a unit
        // circle in maths).
        var startAngle: CGFloat = -.pi * 0.5
        
        // Loop through the values array.
        for (index, segment) in segments.enumerated() {
            // Get the end angle of this segment.
            let endAngle = startAngle + .pi * 2 * ((1.0/CGFloat(segments.count)) / valueCount)
            defer {
                // Update starting angle of the next segment to the ending angle of this
                // segment.
                startAngle = endAngle
            }
            
            body(segment, startAngle, endAngle, index)
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        // Get current context.
        guard let ctx = UIGraphicsGetCurrentContext() else { return }
        
        // Radius is the half the frame's width or height (whichever is smallest).
        let radius = min(frame.width, frame.height) * 0.5
        
        // Center of the view.
        let viewCenter = bounds.center
        
        // Loop through the values array.
        forEachSegment { segment, startAngle, endAngle, index in
            
            // Set fill color to the segment color.
            if grayShades.count - 1 >= index {
                let segmentColor = (segments.count == 2) ? .black : grayShades[index]
                ctx.setFillColor(segmentColor.cgColor)
            } else {
                ctx.setFillColor(UIColor.black.cgColor)
            }
            
            // Move to the center of the pie chart.
            ctx.move(to: viewCenter)
            
            // Add arc from the center for each segment (anticlockwise is specified
            // for the arc, but as the view flips the context, it will produce a
            // clockwise arc)
            ctx.addArc(center: viewCenter, radius: radius, startAngle: startAngle,
                       endAngle: endAngle, clockwise: false)
            
            // Fill segment.
            ctx.fillPath()
        }
        if showSegmentLabels { // Do text rendering.
            let imageWidthHeight: CGFloat = (segments.count == 2) ? 100 : 50
            let updatedRadius: CGFloat = (segments.count == 2) ? (radius - 30) : radius
            forEachSegment { segment, startAngle, endAngle, index  in
                // Get the angle midpoint.
                let halfAngle = startAngle + (endAngle - startAngle) * 0.5;
                
                // Get the 'center' of the segment.
                var segmentCenter = viewCenter
                if segments.count > 1 {
                    segmentCenter = segmentCenter
                        .projected(by: updatedRadius, angle: halfAngle)
                    
                    if let url = URL(string: segment.imageURL) {
                        
                        let image = RoundedProfilePic(frame: CGRect(x: 0, y: 0, width: imageWidthHeight, height: imageWidthHeight))
                        image.borderColor = segment.isNowPlaying ? UIColor(red: 208/255, green: 2/255, blue: 27/255, alpha: 1) : UIColor(red: 126/255, green: 211/255, blue: 33/255, alpha: 1)
                        image.backgroundColor = UIColor.white
                        image.kf.indicatorType = .activity
                        image.kf.setImage(with: url)
                        image.tag = 99
                        image.center = segmentCenter
                        addSubview(image)
                        image.layer.zPosition = 10
                    }
                }
            }
        }
    }
}
