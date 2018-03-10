import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    private let twitterX: TwitterX = TwitterX()
    
    @IBOutlet private var mainWindow: NSWindow!
    @IBOutlet private var dragAndDropViewController: DragAndDropViewController!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.dragAndDropViewController.didReceiveDragAndDropURL = { [weak self] url in
            self?.twitterX.twitterAppURL = url
            self?.launchTwitterApp()
        }
        
        self.twitterX.checkUpdates { [weak self] (isThereUpdate) in
            guard isThereUpdate else {
                self?.launchTwitterApp()
                return
            }
            self?.displayUpdateModal()
            self?.launchTwitterApp()
        }
    }
    
    // MARK: - Private
    
    private func launchTwitterApp() {
        self.twitterX.launchTwitterApp { [weak self] (success, error) in
            if success {
                exit(0)
            }
            if let error = error {
                self?.displayError(error)
            }
        }
    }
    
    private func displayError(_ error: Error) {
        let alert: NSAlert = NSAlert(error: error)
        alert.runModal()
    }
    
    private func displayUpdateModal() {
        let alert: NSAlert = NSAlert()
        alert.messageText = "There is a new version of TwitterX available"
        alert.informativeText = "New tweaks and fixes are available. Click on \"Get update\" to visit the changelog and download the latest version."
        alert.addButton(withTitle: "Get update")
        alert.addButton(withTitle: "Not now")
        if alert.runModal().rawValue == 1000 {
            NSWorkspace.shared.open(URL(string: "https://github.com/nakiostudio/TwitterX/releases")!)
        }
    }

}
