import Foundation
import UIKit
import CYPlayer
import Masonry
import SwiftUI

class ViewController: UIViewController {
    var contentView : UIView?
    var player : CYFFmpegPlayer?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //创建cententview
        self.contentView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        self.view.addSubview(self.contentView!)
        self.contentView?.mas_makeConstraints({ (make) in
            make?.leading.trailing().offset()(0)
            make?.center.offset()(0)
            make?.height.equalTo()(contentView?.mas_width)?.multipliedBy()(9.0 / 16.0)
        })
        
        //初始化播放器
        player  = CYFFmpegPlayer.movieView(withContentPath: "https://vodplay.com/liveRecord/46eca58c0ccf5b857fa76cb3c9fea487/dentalink-vod/515197938314592256/2020-08-17-12-18-39_2020-08-17-12-48-39.m3u8", parameters: nil) as? CYFFmpegPlayer
        
        
//        let definition =  CYFFmpegPlayerDefinitionType.LHD.rawValue | CYFFmpegPlayerDefinitionType.LLD.rawValue | CYFFmpegPlayerDefinitionType.LSD.rawValue | CYFFmpegPlayerDefinitionType.LUD.rawValue
        player?.settingPlayer({ (settings) in
//            settings?.definitionTypes = CYFFmpegPlayerDefinitionType.init(rawValue: definition)!
            settings?.enableSelections = true
            settings?.setCurrentSelectionsIndex =  { () -> Int in
                return 3
            }
//            settings
            settings?.nextAutoPlaySelectionsPath = { () -> String in
                return "https://vodplay.com/liveRecord/46eca58c0ccf5b857fa76cb3c9fea487/dentalink-vod/515197938314592256/2020-08-17-12-18-39_2020-08-17-12-48-39.m3u8"
            }
        })
        self.openLandscape()
//        player.
        player?.isAutoplay = true
        player?.generatPreviewImages = true
        self.contentView?.addSubview((player?.view)!)
        //播放器视图添加到父视图之后,一定要设置播放器视图的frame,不然会导致opengl无法渲染以致播放失败
        player?.view.mas_makeConstraints({ (make) in
            make?.center.offset()(0)
            make?.top.bottom().offset()(0)
            make?.width.equalTo()(player?.view.mas_height)?.multipliedBy()(16.0 / 9.0)
        })
    }


    deinit {
        player?.stop()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if size.width > size.height {
            
            contentView?.mas_remakeConstraints({ (make) in
                make?.top.bottom().equalTo()(0)
//                make?.left.right().equalTo()(0)
//                make?.leading.trailing().offset()(0)
                make?.center.offset()(0)
                make?.height.equalTo()(contentView?.mas_width)?.multipliedBy()(9.0 / 16.0)
            })
        } else {
            contentView?.mas_remakeConstraints({ (make) in
                make?.leading.trailing().offset()(0)
                make?.center.offset()(0)
                make?.height.equalTo()(contentView?.mas_width)?.multipliedBy()(9.0 / 16.0)
            })
        }
    }
}

// MARK: - SwiftUI bridge
struct VCView : UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let vc = ViewController()
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
