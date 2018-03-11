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

final class DragAndDropViewController: NSViewController {
    
    @IBOutlet private var backgroundImageView: NSImageView!
    @IBOutlet private var highlightView: DragAndDropView!
    
    var didReceiveDragAndDropURL: ((URL) -> Void)? {
        didSet {
            self.highlightView.didReceiveDragAndDropURL = self.didReceiveDragAndDropURL
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    // MARK: - Private
    
    private func setup() {
        // View
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor(calibratedRed: 41.0/255.0, green: 43.0/255.0, blue: 54.0/255.0, alpha: 1.0).cgColor
        
        // ImageView
        self.backgroundImageView.alphaValue = 0.5
        
        // HighlightView
        self.highlightView.didReceiveDragAndDropURL = didReceiveDragAndDropURL
    }
    
}
