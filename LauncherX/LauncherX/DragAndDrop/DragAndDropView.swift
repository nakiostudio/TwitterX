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

private extension NSDraggingInfo {
    
    func isDraggingTwitterApp() -> Bool {
        return self.twitterAppURL() != nil
    }
    
    func twitterAppURL() -> URL? {
        guard self.draggingPasteboard().canReadObject(forClasses: [NSURL.self]) else { return nil }
        let pasteboard = self.draggingPasteboard()
        let urls = pasteboard.readObjects(forClasses: [NSURL.self]) as? [URL]
        return urls?.first { $0.lastPathComponent == "Twitter.app" }
    }
    
}

final class DragAndDropView: NSView {
    
    private enum State {
        case idle, validDrag, invalidDrag
    }
    
    var didReceiveDragAndDropURL: ((URL) -> Void)? {
        didSet {
            if didReceiveDragAndDropURL != nil {
                self.registerForDraggedTypes([NSPasteboard.PasteboardType(rawValue: "NSFilenamesPboardType")])
                return
            }
            self.unregisterDraggedTypes()
        }
    }
    
    // MARK: - Overridden
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
    override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
        return sender.isDraggingTwitterApp()
    }
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        let allow = sender.isDraggingTwitterApp()
        self.updateAppearance(forState: allow ? .validDrag : .invalidDrag)
        return allow ? .copy : NSDragOperation()
    }
    
    override func draggingExited(_ sender: NSDraggingInfo?) {
        self.updateAppearance(forState: .idle)
    }
    
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        defer {
            self.updateAppearance(forState: .idle)
        }
        
        if let twitterURL = sender.twitterAppURL() {
            self.didReceiveDragAndDropURL?(twitterURL)
            return true
        }
        
        return false
    }
    
    // MARK: - Private
    
    private func setup() {
        self.alphaValue = 0.0
        self.wantsLayer = true
    }
    
    private func updateAppearance(forState state: State) {
        switch state {
        case .idle:
            self.alphaValue = 0.0
        case .validDrag:
            self.alphaValue = 0.2
            self.layer?.backgroundColor = NSColor(calibratedRed: 105.0/255.0, green: 110.0/255.0, blue: 135.0/255.0, alpha: 1.0).cgColor
        case .invalidDrag:
            self.alphaValue = 0.2
            self.layer?.backgroundColor = NSColor(calibratedRed: 214.0/255.0, green: 117.0/255.0, blue: 117.0/255.0, alpha: 1.0).cgColor
        }
    }
    
}
