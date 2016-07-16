//
//  ViewController.swift
//  QuickPlayer_V
//
//  Created by HuuLuong on 7/16/16.
//  Copyright © 2016 CanhDang. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var btn_Play: UIButton!
    var audio = AVAudioPlayer()
    
    @IBOutlet weak var sld_Volume: UISlider!
    
    var audioIsPlaying: Bool!
    
    @IBOutlet weak var lbl_CurrentTime: UILabel!
    
    @IBOutlet weak var lbl_TimeTotal: UILabel!
    
    @IBOutlet weak var sld_Duration: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audio = try! AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("music", ofType: ".mp3")!))
        audio.prepareToPlay()
        addThumbImgForSlider()
        audioIsPlaying = false
        
        audio.delegate = self
        
        lbl_TimeTotal.text = String(format: "%2.2f", audio.duration/60)
        
        let timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(updateTimeLeft), userInfo: nil, repeats: true)
 
    }
    //setup
    func updateTimeLeft(){
        self.lbl_CurrentTime.text = String(format: "%2.2f", audio.currentTime/60)
        self.sld_Duration.value = Float(audio.currentTime/audio.duration)
    }
    
    func addThumbImgForSlider(){
        sld_Volume.setThumbImage(UIImage(named: "thumb.png"), forState: .Normal)
        sld_Volume.setThumbImage(UIImage(named: "thumbHightLight.png"), forState: .Highlighted)
    }
    //
    @IBAction func action_Play(sender: UIButton) {
        print("ok")
        
        if audioIsPlaying == false {
            btn_Play.setImage(UIImage(named: "play.png"), forState: .Normal)
            audio.play()
            audioIsPlaying = true
        } else {
            btn_Play.setImage(UIImage(named: "pause.png"), forState: .Normal)
            audio.pause()
            audioIsPlaying = false
        }
    }
  
    @IBAction func sld_volume(sender: UISlider) {
        print(sender.value)
        audio.volume = sender.value
    }
    
    @IBAction func action_switch(sender: UISwitch) {
        if sender.on {
            audio.numberOfLoops = -1
            print("on")
        } else {
            audio.numberOfLoops = 0
            print("off")
        }
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        if audio.numberOfLoops == 0 {
            btn_Play.setImage(UIImage(named: "pause.png"), forState: .Normal)
            audioIsPlaying = false
        }
    }
    
    
    @IBAction func sld_duration(sender: UISlider) {
        audio.currentTime = Double(sender.value) * audio.duration
    
    }
    
    
    
}

