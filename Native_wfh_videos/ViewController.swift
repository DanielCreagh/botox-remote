  
  import UIKit
  import AVKit
  import AVFoundation
  
  class ViewController: UIViewController {
    
    @IBOutlet var videoView: UIView!
    
    private var firstAppear = true
    let screenSize : CGRect = UIScreen.mainScreen().bounds
    
    override func viewDidAppear(animated: Bool) {
      super.viewDidAppear(animated)
      if firstAppear {
        do {
          try playVideo()
          firstAppear = false
        } catch AppError.InvalidResource(let name, let type) {
          debugPrint("Could not find resource \(name).\(type)")
        } catch {
          debugPrint("Generic error")
        }
        
      }
    }
    
    private func playVideo() throws {
      guard let path = NSBundle.mainBundle().pathForResource("BrowsingPrototype", ofType:"mov") else {
        throw AppError.InvalidResource("video", "m4v")
      }
      let player = AVPlayer(URL: NSURL(fileURLWithPath: path))
        

      
      let playerController = AVPlayerViewController()
      playerController.player = player
      playerController.videoGravity = AVLayerVideoGravityResize // . AVLayerVideoGravityResizeAspect is default.
      // Layer for display… Video plays at the full size of the iPad
      let playerLayer = AVPlayerLayer(player: player)
      
      //playerLayer.frame = CGRectMake(0, 0, 400, 400)
      playerController.view.frame = CGRectMake(0, 0, 400, 400)
      
      
//      var view = UIView(frame: CGRectMake(0, 0, screenSize.width, screenSize.height))
//      videoView.layer.addSublayer(playerLayer)
      videoView.addSubview(playerController.view!)
      playerLayer.frame = view.bounds
      player.play()

      //      self.presentViewController(playerController, animated: true) {
//        player.play()
//      }
    }
  }
  
  enum AppError : ErrorType {
    case InvalidResource(String, String)
  }