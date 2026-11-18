// Run with osascript -l JavaScript after AeroSpace floats a 1Password window.
ObjC.import('AppKit');

function run() {
    var processes = Application('System Events').processes.whose({
        bundleIdentifier: 'com.1password.1password'
    });
    var win;
    // The accessibility window may appear shortly after AeroSpace detects it.
    for (var attempt = 0; attempt < 10 && !win; attempt++) {
        if (processes.length) {
            var windows = processes[0].windows();
            for (var j = 0; j < windows.length; j++) {
                if (windows[j].subrole() === 'AXStandardWindow') {
                    win = windows[j];
                    break;
                }
            }
        }
        if (!win) delay(0.1);
    }
    if (!win) return;
    // Let 1Password finish its initial layout before applying our dimensions.
    delay(0.2);

    var position = win.position();
    var size = win.size();
    var screens = $.NSScreen.screens;
    var desktopTop = screens.objectAtIndex(0).frame.size.height;
    var selected;
    var largestOverlap = -1;
    for (var i = 0; i < Number(screens.count); i++) {
        var screen = screens.objectAtIndex(i);
        var frame = screen.frame;
        // AppKit uses bottom-left coordinates; accessibility uses top-left.
        var x = frame.origin.x;
        var y = desktopTop - frame.origin.y - frame.size.height;
        var overlap = Math.max(0, Math.min(position[0] + size[0],
            x + frame.size.width) - Math.max(position[0], x)) *
            Math.max(0, Math.min(position[1] + size[1],
            y + frame.size.height) - Math.max(position[1], y));
        if (overlap > largestOverlap) {
            largestOverlap = overlap;
            selected = screen;
        }
    }

    var area = selected.visibleFrame;
    win.size = [Math.round(area.size.width * 0.8),
        Math.round(area.size.height * 0.8)];
    // Read back the size in case 1Password enforces a minimum window size.
    size = win.size();
    win.position = [
        Math.round(area.origin.x + (area.size.width - size[0]) / 2),
        Math.round(desktopTop - area.origin.y - area.size.height +
            (area.size.height - size[1]) / 2)
    ];
}
