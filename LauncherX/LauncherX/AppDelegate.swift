// The MIT License (MIT) - Copyright (c) 2018 Carlos Vidal
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import AppKit

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
            if isThereUpdate {
                self?.displayUpdateModal()
            }
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
    
    @IBAction private func didTapQuitMenuItem(_ sender: Any?) {
        exit(0)
    }

}
