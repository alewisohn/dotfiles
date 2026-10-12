// Run with osascript -l JavaScript; the argument is AeroSpace's window ID.
ObjC.import('AppKit');

function run(argv) {
    var id = Number(argv[0]);
    if (!id) throw new Error('A Finder window ID is required');

    var finder = Application('Finder');
    var win = finder.windows.byId(id);
    // Finder's scripting interface may lag its window-detected event briefly.
    for (var attempt = 0; attempt < 10 && !win.exists(); attempt++) delay(0.1);
    if (!win.exists()) return;

    var bounds = win.bounds();
    var screens = $.NSScreen.screens;
    var desktopTop = screens.objectAtIndex(0).frame.size.height;
    var selected;
    var largestOverlap = -1;
    for (var i = 0; i < Number(screens.count); i++) {
        var screen = screens.objectAtIndex(i);
        var frame = screen.frame;
        // AppKit uses bottom-left coordinates; Finder uses top-left coordinates.
        var x = frame.origin.x;
        var y = desktopTop - frame.origin.y - frame.size.height;
        var overlap = Math.max(0, Math.min(bounds.x + bounds.width,
            x + frame.size.width) - Math.max(bounds.x, x)) *
            Math.max(0, Math.min(bounds.y + bounds.height,
            y + frame.size.height) - Math.max(bounds.y, y));
        if (overlap > largestOverlap) {
            largestOverlap = overlap;
            selected = screen;
        }
    }

    var area = selected.visibleFrame;
    var width = Math.round(Math.min(1000, area.size.width * 0.8));
    var height = Math.round(Math.min(700, area.size.height * 0.8));
    win.bounds = {
        x: Math.round(area.origin.x + (area.size.width - width) / 2),
        y: Math.round(desktopTop - area.origin.y - area.size.height +
            (area.size.height - height) / 2),
        width: width,
        height: height
    };
}
