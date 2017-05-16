$(document).keydown(function (e) {
    switch (e.which) {
        case 37: // left
            $(".slideshow-prev").click();
            break;

        case 38: // up
            break;

        case 39: // right
            $(".slideshow-next").click();
            break;

        case 40: // down
            break;

        default:
            return; // exit this handler for other keys
    }
    e.preventDefault();
});