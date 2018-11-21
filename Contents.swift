//: | Explore Greece Swift Playground | Errikos Kontogiannis | Apple WWDC 2018 Application |

import PlaygroundSupport
import AVFoundation
import UIKit
import ARKit
import SceneKit

// Variables Used For The Checking Functions Below
var view1 = false
var view2 = false

// Creating The Intro View
class IntroViewController: UIViewController {
    
    // Setting Up The introPlayer's Variables
    var introPlayer: AVPlayer!
    var introPlayerLayer: AVPlayerLayer!
    var paused: Bool = false
    
    override func viewDidLoad() {
        
        // Hiding The Navigation Bar
        navigationController?.isNavigationBarHidden = true
        
        // Setting Up The logoImage Variable As A UIImageView
        let logoImage = UIImageView()
        
        // Setting Up The button Variable As A UIButton
        let exploreButton = UIButton(type: UIButton.ButtonType.custom) as UIButton
        
        // Configuring The logoImage Variable
        logoImage.frame = CGRect(origin: CGPoint(x: 100, y: 100), size: CGSize(width: 300, height: 300))
        logoImage.center = CGPoint(x: view.center.x / 2 - 40, y: view.center.y / 2 - 120)
        logoImage.image = UIImage(named: "logo")
        
        // Configuring The exploreButton Variable
        exploreButton.frame = CGRect(origin: CGPoint(x: 100, y: 100), size: CGSize(width: 300, height: 100))
        exploreButton.center = CGPoint(x: view.center.x / 2 - 40, y: view.center.y / 2 + 120)
        exploreButton.addTarget(self, action: #selector(explore), for: UIControl.Event.touchUpInside)
        exploreButton.setImage(UIImage(named: "explore"), for: UIControl.State.normal)
        
        // Adding The Subviews To The Intro View
        self.view.addSubview(logoImage)
        self.view.addSubview(exploreButton)
        
        // Declaring The introPlayer's Background Video URL
        let theURL = Bundle.main.url(forResource:"intro", withExtension: "mp4")
        
        // Configuring The introPlayer
        introPlayer = AVPlayer(url: theURL!)
        introPlayerLayer = AVPlayerLayer(player: introPlayer)
        introPlayerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        introPlayer.volume = 0
        introPlayer.actionAtItemEnd = .none
        introPlayerLayer.frame = view.layer.bounds
        view.backgroundColor = .clear
        view.layer.insertSublayer(introPlayerLayer, at: 0)
        
        // Function Called When introPlayer's Video Ends
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd(notification:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: introPlayer.currentItem)
        
    }
    
    @objc func playerItemDidReachEnd(notification: Notification) {
        
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seek(to: CMTime.zero, completionHandler: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        introPlayer.play()
        paused = false
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        introPlayer.pause()
        paused = true
        
    }
    
    @objc func explore() {
        
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.pushViewController(SelectionViewController(), animated: true)
        
    }
    
}

// Creating The Selection View
class SelectionViewController: UIViewController {
    
    // Setting Up The selectionPlayer's Variables
    var selectionPlayer: AVPlayer!
    var selectionPlayerLayer: AVPlayerLayer!
    var paused: Bool = false
    
    override func viewDidLoad() {
        
        // Hiding The Navigation Bar
        navigationController?.isNavigationBarHidden = true
        
        // Setting Up The chooseImage As A UIImageView
        let chooseImage = UIImageView()
        
        // Setting Up The archaeologicalSitesButton Variable As A UIButton
        let archaeologicalSitesButton = UIButton(type:UIButton.ButtonType.custom) as UIButton
        
        // Setting Up The islandsButton Variable As A UIButton
        let islandsButton = UIButton(type:UIButton.ButtonType.custom) as UIButton
        
        // Configuring The chooseImage Variable
        chooseImage.frame = CGRect(origin: CGPoint(x: 100, y: 100), size: CGSize(width: 300, height: 300))
        chooseImage.center = CGPoint(x: view.center.x / 2 - 40, y: view.center.y / 2 - 120)
        chooseImage.image = UIImage(named: "choose_category")
        
        // Configuring The archaeologicalSitesButton Variable
        archaeologicalSitesButton.frame = CGRect(origin: CGPoint(x: 100, y: 100), size: CGSize(width: 300, height: 100))
        archaeologicalSitesButton.center = CGPoint(x: view.center.x / 2 - 40, y: view.center.y / 2 + 60)
        archaeologicalSitesButton.addTarget(self, action: #selector(archaeologicalSites), for: UIControl.Event.touchUpInside)
        archaeologicalSitesButton.setImage(UIImage(named: "archaeological_sites"), for: UIControl.State.normal)
        
        // Configuring The islandsButton Variable
        islandsButton.frame = CGRect(origin: CGPoint(x: 100, y: 100), size: CGSize(width: 300, height: 100))
        islandsButton.center = CGPoint(x: view.center.x / 2 - 40, y: view.center.y / 2 + 120)
        islandsButton.addTarget(self, action: #selector(islands), for: UIControl.Event.touchUpInside)
        islandsButton.setImage(UIImage(named: "islands"), for: UIControl.State.normal)
        
        // Adding The Subviews To The Selection View
        self.view.addSubview(chooseImage)
        self.view.addSubview(archaeologicalSitesButton)
        self.view.addSubview(islandsButton)
        
        // Declaring The selectionPlayer's Background Video URL
        let theURL = Bundle.main.url(forResource:"selection", withExtension: "mp4")
        
        // Configuring The selectionPlayer
        selectionPlayer = AVPlayer(url: theURL!)
        selectionPlayerLayer = AVPlayerLayer(player: selectionPlayer)
        selectionPlayerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        selectionPlayer.volume = 0
        selectionPlayer.actionAtItemEnd = .none
        selectionPlayerLayer.frame = view.layer.bounds
        view.backgroundColor = .clear
        view.layer.insertSublayer(selectionPlayerLayer, at: 0)
        
        // Function Called When selectionPlayer's Video Ends
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd(notification:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: selectionPlayer.currentItem)
        
    }
    
    @objc func playerItemDidReachEnd(notification: Notification) {
        
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seek(to: CMTime.zero, completionHandler: nil)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        selectionPlayer.play()
        paused = false
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        selectionPlayer.pause()
        paused = true
        
    }
    
    // Checking To See If User Has Experienced Both Categories And Allowing Him To Do So Again If He Accidentally Didn't Experience One
    @objc func archaeologicalSites() {
        
        if view1 == false && view2 == false {
            
            self.navigationController?.isNavigationBarHidden = true
            self.navigationController?.pushViewController(ArchaeologicalSitesViewController(), animated: true)
            
            view1 = true
            
        } else if view1 == true && view2 == false {
            
            self.navigationController?.isNavigationBarHidden = true
            self.navigationController?.pushViewController(ArchaeologicalSitesViewController(), animated: true)
            
        } else if view1 == false && view2 == true {
            
            self.navigationController?.isNavigationBarHidden = true
            self.navigationController?.pushViewController(ArchaeologicalSitesViewController(), animated: true)
            
            view1 = true
            
        } else if view1 == true && view2 == true {
            
            self.navigationController?.isNavigationBarHidden = true
            self.navigationController?.pushViewController(OutroViewController(), animated: true)
            
        }
        
    }
    
    @objc func islands() {
        
        if view1 == false && view2 == false {
            
            self.navigationController?.isNavigationBarHidden = true
            self.navigationController?.pushViewController(IslandsViewController(), animated: true)
            
            view2 = true
            
        } else if view1 == false && view2 == true {
            
            self.navigationController?.isNavigationBarHidden = true
            self.navigationController?.pushViewController(IslandsViewController(), animated: true)
            
        } else if view1 == true && view2 == false {
            
            self.navigationController?.isNavigationBarHidden = true
            self.navigationController?.pushViewController(IslandsViewController(), animated: true)
            
            view2 = true
            
        } else if view1 == true && view2 == true {
            
            self.navigationController?.isNavigationBarHidden = true
            self.navigationController?.pushViewController(OutroViewController(), animated: true)
            
        }
        
    }
    
}

// Creating The Archaeological Sites ARView
class ArchaeologicalSitesViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {
    
    // Setting Up The session Variable As A ARSession
    let session = ARSession()
    
    // Setting Up The sceneView Variable As A ARSCNView
    var sceneView: ARSCNView!
    
    // Setting Up The infoImage As A UIImageView
    let infoImage = UIImageView()
    
    override func loadView() {
        
        // Configuring The sceneView Variable #1
        sceneView = ARSCNView(frame: CGRect(x: 0.0, y: 0.0, width: 500.0, height: 600.0))
        
        // Setting Up The scene Variable As A SCNScene
        let scene = SCNScene()
        
        // Configuring The sceneView Variable #2
        sceneView.scene = scene
        
        // Setting Up The configuration Variable
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        // Configuring The sceneView Variable #3
        sceneView.setup()
        sceneView.delegate = self
        sceneView.session = session
        sceneView.session.delegate = self
        
        // Setting Up The cameraNode Variable As A SCNNode
        let cameraNode = SCNNode()
        
        // Configuring The cameraNode
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 3)
        scene.rootNode.addChildNode(cameraNode)
        
        // Running The sceneView's Configuration
        self.view = sceneView
        self.sceneView.session.run(configuration)
        
        // Setting Up The tapGestureRecognizer Variable As A UITapGestureRecognizer
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        
        // Adding The tapGestureRecognizer Variable To The Archaeological Sites ARView
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
        
        // Setting Up The returnButton Variable As A UIButton
        let returnButton = UIButton(type: UIButton.ButtonType.custom) as UIButton
        
        // Configuring The infoImage Variable
        infoImage.frame = CGRect(origin: CGPoint(x: 100, y: 100), size: CGSize(width: 300, height: 300))
        infoImage.center = CGPoint(x: view.center.x / 2 + 170, y: view.center.y / 2 - 20)
        infoImage.image = UIImage(named: "scan_floor")
        
        // Configuring The returnButton Variable
        returnButton.frame = CGRect(origin: CGPoint(x: 100, y: 100), size: CGSize(width: 300, height: 100))
        returnButton.center = CGPoint(x: view.center.x / 2 + 170, y: view.center.y / 2 + 600)
        returnButton.addTarget(self, action: #selector(returnFunc), for: UIControl.Event.touchUpInside)
        returnButton.setImage(UIImage(named: "return"), for: UIControl.State.normal)
        
        // Adding The Subviews To The Archaeological Sites ARView
        self.view.addSubview(infoImage)
        self.view.addSubview(returnButton)
        
    }
    
    // Function Called When User Taps On The Screen
    @objc func handleTap(sender: UITapGestureRecognizer) {
        
        guard let sceneView = sender.view as? ARSCNView else { return }
        
        let touchLocation = sender.location(in: sceneView)
        
        let hitTestResult = sceneView.hitTest(touchLocation, types: .existingPlaneUsingExtent)
        
        if !hitTestResult.isEmpty {
            
            self.addPortals(hitTestResult: hitTestResult.first!)
            
        }
        
    }
    
    // Function Called To Add The Portals, Walls And Floor
    func addPortals(hitTestResult: ARHitTestResult) {
        
        // Setting Up The portalScene Variables As A SCNScene
        let portalScene1 = SCNScene(named: "Portal.scnassets/Portal1.scn")
        let portalScene2 = SCNScene(named: "Portal.scnassets/Portal2.scn")
        let portalScene3 = SCNScene(named: "Portal.scnassets/Portal3.scn")
        
        // Setting Up The portalNode Variables As A SCNNode
        let portalNode1 = portalScene1!.rootNode.childNode(withName: "Portal1", recursively: false)!
        let portalNode2 = portalScene2!.rootNode.childNode(withName: "Portal2", recursively: false)!
        let portalNode3 = portalScene3!.rootNode.childNode(withName: "Portal3", recursively: false)!
        
        // Getting The Transform Matrix
        let transform = hitTestResult.worldTransform
        
        // Getting The X, Y, Z Positions From The Transform Matrix
        let planeXposition = transform.columns.3.x
        let planeYposition = transform.columns.3.y
        let planeZposition = transform.columns.3.z
        
        // Configuring The portalNodeX Variables
        portalNode1.position = SCNVector3(planeXposition, planeYposition, planeZposition)
        portalNode2.position = SCNVector3(planeXposition, planeYposition, planeZposition)
        portalNode3.position = SCNVector3(planeXposition, planeYposition, planeZposition)
        
        // Configuring The rootNode
        self.sceneView.scene.rootNode.addChildNode(portalNode1)
        self.sceneView.scene.rootNode.addChildNode(portalNode2)
        self.sceneView.scene.rootNode.addChildNode(portalNode3)
        
        // Adding The Panoramic Images To The portalNodeX Portal Room's Walls
        self.addPlane(nodeName: "roof", portalNode: portalNode1, folderName: "Parthenon_Cubemap", imageName: "top")
        self.addPlane(nodeName: "roof", portalNode: portalNode2, folderName: "Philippeion_Cubemap", imageName: "top")
        self.addPlane(nodeName: "roof", portalNode: portalNode3, folderName: "Tholos_Cubemap", imageName: "top")
        
        self.addPlane(nodeName: "floor", portalNode: portalNode1, folderName: "Parthenon_Cubemap", imageName: "bottom")
        self.addPlane(nodeName: "floor", portalNode: portalNode2, folderName: "Philippeion_Cubemap", imageName: "bottom")
        self.addPlane(nodeName: "floor", portalNode: portalNode3, folderName: "Tholos_Cubemap", imageName: "bottom")
        
        self.addWalls(nodeName: "backWall", portalNode: portalNode1, folderName: "Parthenon_Cubemap", imageName: "back")
        self.addWalls(nodeName: "backWall", portalNode: portalNode2, folderName: "Philippeion_Cubemap", imageName: "back")
        self.addWalls(nodeName: "backWall", portalNode: portalNode3, folderName: "Tholos_Cubemap", imageName: "back")
        
        self.addWalls(nodeName: "sideWallA", portalNode: portalNode1, folderName: "Parthenon_Cubemap", imageName: "sideA")
        self.addWalls(nodeName: "sideWallA", portalNode: portalNode2, folderName: "Philippeion_Cubemap", imageName: "sideA")
        self.addWalls(nodeName: "sideWallA", portalNode: portalNode3, folderName: "Tholos_Cubemap", imageName: "sideA")
        
        self.addWalls(nodeName: "sideWallB", portalNode: portalNode1, folderName: "Parthenon_Cubemap", imageName: "sideB")
        self.addWalls(nodeName: "sideWallB", portalNode: portalNode2, folderName: "Philippeion_Cubemap", imageName: "sideB")
        self.addWalls(nodeName: "sideWallB", portalNode: portalNode3, folderName: "Tholos_Cubemap", imageName: "sideB")
        
        self.addWalls(nodeName: "sideDoorA", portalNode: portalNode1, folderName: "Parthenon_Cubemap", imageName: "sideDoorA")
        self.addWalls(nodeName: "sideDoorA", portalNode: portalNode2, folderName: "Philippeion_Cubemap", imageName: "sideDoorA")
        self.addWalls(nodeName: "sideDoorA", portalNode: portalNode3, folderName: "Tholos_Cubemap", imageName: "sideDoorA")
        
        self.addWalls(nodeName: "sideDoorB", portalNode: portalNode1, folderName: "Parthenon_Cubemap", imageName: "sideDoorB")
        self.addWalls(nodeName: "sideDoorB", portalNode: portalNode2, folderName: "Philippeion_Cubemap", imageName: "sideDoorB")
        self.addWalls(nodeName: "sideDoorB", portalNode: portalNode3, folderName: "Tholos_Cubemap", imageName: "sideDoorB")
        
    }
    
    // Function Called When A Plane Has Been Detected
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        guard anchor is ARPlaneAnchor else { return }
        
        DispatchQueue.main.async {
            
            self.infoImage.image = UIImage(named: "tap_floor")
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            
            self.infoImage.image = UIImage(named: "explore_doors")
            
        }
        
    }
    
    // Function Called When The addPortals() Function Has Been Called To Add The Floor
    func addPlane(nodeName: String, portalNode: SCNNode, folderName: String, imageName: String) {
        
        let child1 = portalNode.childNode(withName: nodeName, recursively: true)
        
        child1?.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "Portal.scnassets/\(folderName)/\(imageName).png")
        
        child1?.renderingOrder = 100
        
    }
    
    // Function Called When The addPortals() Function Has Been Called To Add The Walls
    func addWalls(nodeName: String, portalNode: SCNNode, folderName: String, imageName: String) {
        
        let child = portalNode.childNode(withName: nodeName, recursively: true)
        
        child?.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "Portal.scnassets/\(folderName)/\(imageName).png")
        
        child?.renderingOrder = 100
        
    }
    
    // Checking To See If User Has Experienced Both Categories And If Yes Sending Him To The Outro View
    @objc func returnFunc() {
        
        if view1 == true && view2 == false {
            
            self.navigationController?.isNavigationBarHidden = true
            self.navigationController?.pushViewController(SelectionViewController(), animated: true)
            
        } else if view1 == true && view2 == true {
            
            self.navigationController?.isNavigationBarHidden = true
            self.navigationController?.pushViewController(OutroViewController(), animated: true)
            
        }
        
    }
    
}

// Creating The Islands ARView
class IslandsViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {
    
    // Setting Up The session Variable As A ARSession
    let session = ARSession()
    
    // Setting Up The sceneView Variable As A ARSCNView
    var sceneView: ARSCNView!
    
    // Setting Up The infoImage As A UIImageView
    let infoImage = UIImageView()
    
    override func loadView() {
        
        // Configuring The sceneView Variable #1
        sceneView = ARSCNView(frame: CGRect(x: 0.0, y: 0.0, width: 500.0, height: 600.0))
        
        // Setting Up The scene Variable As A SCNScene
        let scene = SCNScene()
        
        // Configuring The sceneView Variable #2
        sceneView.scene = scene
        
        // Setting Up The configuration Variable
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        // Configuring The sceneView Variable #3
        sceneView.setup()
        sceneView.delegate = self
        sceneView.session = session
        sceneView.session.delegate = self
        
        // Setting Up The cameraNode Variable As A SCNNode
        let cameraNode = SCNNode()
        
        // Configuring The cameraNode
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 3)
        scene.rootNode.addChildNode(cameraNode)
        
        // Running The sceneView's Configuration
        self.view = sceneView
        self.sceneView.session.run(configuration)
        
        // Setting Up The tapGestureRecognizer Variable As A UITapGestureRecognizer
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        
        // Adding The tapGestureRecognizer Variable To The Islands ARView
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
        
        // Setting Up The Button As A UIButton
        let returnButton = UIButton(type: UIButton.ButtonType.custom) as UIButton
        
        // Configuring The infoImage Variable
        infoImage.frame = CGRect(origin: CGPoint(x: 100, y: 100), size: CGSize(width: 300, height: 300))
        infoImage.center = CGPoint(x: view.center.x / 2 + 170, y: view.center.y / 2 - 20)
        infoImage.image = UIImage(named: "scan_floor")
        
        // Configuring The returnButton Variable
        returnButton.frame = CGRect(origin: CGPoint(x: 100, y: 100), size: CGSize(width: 300, height: 100))
        returnButton.center = CGPoint(x: view.center.x / 2 + 170, y: view.center.y / 2 + 600)
        returnButton.addTarget(self, action: #selector(returnFunc), for: UIControl.Event.touchUpInside)
        returnButton.setImage(UIImage(named: "return"), for: UIControl.State.normal)
        
        // Adding The Subviews To The Islands ARView
        self.view.addSubview(infoImage)
        self.view.addSubview(returnButton)
        
    }
    
    // Function Called When User Taps On The Screen
    @objc func handleTap(sender: UITapGestureRecognizer) {
        
        guard let sceneView = sender.view as? ARSCNView else { return }
        
        let touchLocation = sender.location(in: sceneView)
        
        let hitTestResult = sceneView.hitTest(touchLocation, types: .existingPlaneUsingExtent)
        
        if !hitTestResult.isEmpty {
            
            self.addPortals(hitTestResult: hitTestResult.first!)
            
        }
        
    }
    
    // Function Called To Add The Portals, Walls And Floor
    func addPortals(hitTestResult: ARHitTestResult) {
        
        // Setting Up The portalScene Variables As A SCNScene
        let portalScene1 = SCNScene(named: "Portal.scnassets/Portal1.scn")
        let portalScene2 = SCNScene(named: "Portal.scnassets/Portal2.scn")
        let portalScene3 = SCNScene(named: "Portal.scnassets/Portal3.scn")
        
        // Setting Up The portalNode Variables As A SCNNode
        let portalNode1 = portalScene1!.rootNode.childNode(withName: "Portal1", recursively: false)!
        let portalNode2 = portalScene2!.rootNode.childNode(withName: "Portal2", recursively: false)!
        let portalNode3 = portalScene3!.rootNode.childNode(withName: "Portal3", recursively: false)!
        
        // Getting The Transform Matrix
        let transform = hitTestResult.worldTransform
        
        // Getting The X, Y, Z Positions From The Transform Matrix
        let planeXposition = transform.columns.3.x
        let planeYposition = transform.columns.3.y
        let planeZposition = transform.columns.3.z
        
        // Configuring The portalNodeX Variables
        portalNode1.position = SCNVector3(planeXposition, planeYposition, planeZposition)
        portalNode2.position = SCNVector3(planeXposition, planeYposition, planeZposition)
        portalNode3.position = SCNVector3(planeXposition, planeYposition, planeZposition)
        
        // Configuring The rootNode
        self.sceneView.scene.rootNode.addChildNode(portalNode1)
        self.sceneView.scene.rootNode.addChildNode(portalNode2)
        self.sceneView.scene.rootNode.addChildNode(portalNode3)
        
        // Adding The Panoramic Images To The portalNodeX Portal Room's Walls
        self.addPlane(nodeName: "roof", portalNode: portalNode1, folderName: "Oia_Cubemap", imageName: "top")
        self.addPlane(nodeName: "roof", portalNode: portalNode2, folderName: "Windmills_Cubemap", imageName: "top")
        self.addPlane(nodeName: "roof", portalNode: portalNode3, folderName: "Balos_Cubemap", imageName: "top")
        
        self.addPlane(nodeName: "floor", portalNode: portalNode1, folderName: "Oia_Cubemap", imageName: "bottom")
        self.addPlane(nodeName: "floor", portalNode: portalNode2, folderName: "Windmills_Cubemap", imageName: "bottom")
        self.addPlane(nodeName: "floor", portalNode: portalNode3, folderName: "Balos_Cubemap", imageName: "bottom")
        
        self.addWalls(nodeName: "backWall", portalNode: portalNode1, folderName: "Oia_Cubemap", imageName: "back")
        self.addWalls(nodeName: "backWall", portalNode: portalNode2, folderName: "Windmills_Cubemap", imageName: "back")
        self.addWalls(nodeName: "backWall", portalNode: portalNode3, folderName: "Balos_Cubemap", imageName: "back")
        
        self.addWalls(nodeName: "sideWallA", portalNode: portalNode1, folderName: "Oia_Cubemap", imageName: "sideA")
        self.addWalls(nodeName: "sideWallA", portalNode: portalNode2, folderName: "Windmills_Cubemap", imageName: "sideA")
        self.addWalls(nodeName: "sideWallA", portalNode: portalNode3, folderName: "Balos_Cubemap", imageName: "sideA")
        
        self.addWalls(nodeName: "sideWallB", portalNode: portalNode1, folderName: "Oia_Cubemap", imageName: "sideB")
        self.addWalls(nodeName: "sideWallB", portalNode: portalNode2, folderName: "Windmills_Cubemap", imageName: "sideB")
        self.addWalls(nodeName: "sideWallB", portalNode: portalNode3, folderName: "Balos_Cubemap", imageName: "sideB")
        
        self.addWalls(nodeName: "sideDoorA", portalNode: portalNode1, folderName: "Oia_Cubemap", imageName: "sideDoorA")
        self.addWalls(nodeName: "sideDoorA", portalNode: portalNode2, folderName: "Windmills_Cubemap", imageName: "sideDoorA")
        self.addWalls(nodeName: "sideDoorA", portalNode: portalNode3, folderName: "Balos_Cubemap", imageName: "sideDoorA")
        
        self.addWalls(nodeName: "sideDoorB", portalNode: portalNode1, folderName: "Oia_Cubemap", imageName: "sideDoorB")
        self.addWalls(nodeName: "sideDoorB", portalNode: portalNode2, folderName: "Windmills_Cubemap", imageName: "sideDoorB")
        self.addWalls(nodeName: "sideDoorB", portalNode: portalNode3, folderName: "Balos_Cubemap", imageName: "sideDoorB")
        
    }
    
    // Function Called When A Plane Has Been Detected
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
        guard anchor is ARPlaneAnchor else { return }
        
        DispatchQueue.main.async {
            
            self.infoImage.image = UIImage(named: "tap_floor")
            
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            
            self.infoImage.image = UIImage(named: "explore_doors")
            
        }
        
    }
    
    // Function Called When The addPortals() Function Has Been Called To Add The Floor
    func addPlane(nodeName: String, portalNode: SCNNode, folderName: String, imageName: String) {
        
        let child1 = portalNode.childNode(withName: nodeName, recursively: true)
        
        child1?.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "Portal.scnassets/\(folderName)/\(imageName).png")
        
        child1?.renderingOrder = 100
        
    }
    
    // Function Called When The addPortals() Function Has Been Called To Add The Walls
    func addWalls(nodeName: String, portalNode: SCNNode, folderName: String, imageName: String) {
        
        let child = portalNode.childNode(withName: nodeName, recursively: true)
        
        child?.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "Portal.scnassets/\(folderName)/\(imageName).png")
        
        child?.renderingOrder = 100
        
    }
    
    // Checking To See If User Has Experienced Both Categories And If Yes Sending Him To The Outro View
    @objc func returnFunc() {
        
        if view1 == false && view2 == true {
            
            self.navigationController?.isNavigationBarHidden = true
            self.navigationController?.pushViewController(SelectionViewController(), animated: true)
            
        } else if view1 == true && view2 == true {
            
            self.navigationController?.isNavigationBarHidden = true
            self.navigationController?.pushViewController(OutroViewController(), animated: true)
            
        }
        
    }
    
}

// Creating The Outro View
class OutroViewController: UIViewController {
    
    // Setting Up The outroPlayer's Variables
    var outroPlayer: AVPlayer!
    var outroPlayerLayer: AVPlayerLayer!
    var paused: Bool = false
    
    override func viewDidLoad() {
        
        // Hiding The Navigation Bar
        navigationController?.isNavigationBarHidden = true
        
        // Setting Up The thanksImage Variable As A UIImageView
        let thanksImage = UIImageView()
        
        // Setting Up The appImage Variable As A UIImageView
        let appImage = UIImageView()
        
        // Configuring The thanksImage Variable
        thanksImage.frame = CGRect(origin: CGPoint(x: 100, y: 100), size: CGSize(width: 300, height: 300))
        thanksImage.center = CGPoint(x: view.center.x / 2 - 40, y: view.center.y / 2 - 120)
        thanksImage.image = UIImage(named: "thanks_time")
        
        // Configuring The appImage Variable
        appImage.frame = CGRect(origin: CGPoint(x: 100, y: 100), size: CGSize(width: 300, height: 300))
        appImage.center = CGPoint(x: view.center.x / 2 - 40, y: view.center.y / 2 + 240)
        appImage.image = UIImage(named: "coming_soon")
        
        // Adding The Subviews To The Outro View
        self.view.addSubview(thanksImage)
        self.view.addSubview(appImage)
        
        // Declaring The outroPlayer's Background Video URL
        let theURL = Bundle.main.url(forResource:"outro", withExtension: "mp4")
        
        // Configuring The outroPlayer
        outroPlayer = AVPlayer(url: theURL!)
        outroPlayerLayer = AVPlayerLayer(player: outroPlayer)
        outroPlayerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        outroPlayer.volume = 0
        outroPlayer.actionAtItemEnd = .none
        outroPlayerLayer.frame = view.layer.bounds
        view.backgroundColor = .clear
        view.layer.insertSublayer(outroPlayerLayer, at: 0)
        
        // Function Called When outroPlayer's Video Ends
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd(notification:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: outroPlayer.currentItem)
        
    }
    
    @objc func playerItemDidReachEnd(notification: Notification) {
        
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seek(to: CMTime.zero, completionHandler: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        outroPlayer.play()
        paused = false
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        outroPlayer.pause()
        paused = true
        
    }
    
}

// Adding The ARSCNView Extension For AR Purposes And Camera Configuration
extension ARSCNView {
    
    func setup() {
        
        antialiasingMode = .multisampling4X
        automaticallyUpdatesLighting = true
        
        preferredFramesPerSecond = 60
        contentScaleFactor = 1.3
        
        if let camera = pointOfView?.camera {
            
            camera.wantsHDR = false
            camera.wantsExposureAdaptation = false
            camera.exposureOffset = 1
            camera.minimumExposure = 1
            camera.maximumExposure = 5
            
        }
        
    }
    
}

// Displaying The Different Views Using A Navigation Controller
var master = IntroViewController()
master.preferredContentSize = CGSize(width: 500.0, height: 600.0)
let nav = UINavigationController(rootViewController: master)
PlaygroundPage.current.liveView = nav

