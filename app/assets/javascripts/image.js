$(document).ready(function(){
    $("#files").change(function(){
        var reader = new FileReader();

        reader.onload = function (e) {
            document.getElementById("image").src = e.target.result;
        };

        reader.readAsDataURL(this.files[0]);
        $(".no-image").hide();
    })
});