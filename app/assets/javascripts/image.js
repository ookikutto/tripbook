$(document).ready(function () {
    var slideIndex = 1;
    showSlides(slideIndex);

    function plusSlides(n) {
        showSlides(slideIndex += n);
    }

    function currentSlide(n) {
        showSlides(slideIndex = n);
    }

    function showSlides(n) {
        var slides = $(".mySlides");
        var dots = $(".dot");

        if (n > slides.length) {
            slideIndex = 1
        }
        if (n < 1) {
            slideIndex = slides.length
        }
        $.each(slides, function () {
            $(this).hide();
        });
        $.each(dots, function () {
            $(this).removeClass("active");
        });
        $(slides.get(slideIndex - 1)).show().fadeIn();
        $(dots.get(slideIndex - 1)).addClass("active");
    }

    $(".slideshow-prev").click(function () {
        plusSlides(-1);
    });

    $(".slideshow-next").click(function () {
        plusSlides(1);
    });

    $(".slideshow-current").click(function () {
        var navToSlide = $(this).data("index");
        currentSlide(navToSlide);
    });

    $("#files").change(function () {
        var reader = new FileReader();
        reader.onload = function (e) {
            document.getElementById("image").src = e.target.result;
        };
        reader.readAsDataURL(this.files[0]);
        $(".no-image").hide();
    })

    $(".toggle-info").click(function(){
        var commentContainer = $(".comment-container");
        var slideshowContainer = $(".slideshow-container");

        if(commentContainer.hasClass("col-md-4")){
            // hide comment, expand slideshow
            commentContainer.removeClass("col-md-4").fadeOut().addClass("hidden-md");
            slideshowContainer.removeClass("col-md-8").fadeIn().addClass("col-md-12");
        } else if(commentContainer.hasClass("hidden-md")){
            commentContainer.removeClass("hidden-md").addClass("col-md-4").fadeIn();
            slideshowContainer.removeClass("col-md-12").addClass("col-md-8");
        }
    });
});
