//
//  PlaysoundsViewController.swift
//  Pitch Perfect
//
//  Created by Michael Yepes on 3/22/15.
//  Copyright (c) 2015 Michael Yepes. All rights reserved.
//

import UIKit
import AVFoundation//added to call the Foundation

class PlaysoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
 
      
        if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3"){
            var filePathUrl = NSURL.fileURLWithPath(filePath)//converts string to nurl
             audioPlayer = AVAudioPlayer(contentsOfURL: filePathUrl, error: nil)
            
        }else {
            println("the filepath is empty")
        }
      
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
//   
//    @IBAction func playSlowAudio(sender: UIButton) {
//        
//       // audioPlayer.play()
//        
//    }
 /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
