document.addEventListener("turbolinks:load", function() {
    $image0 = $("#micropost_images_attributes_0_image");
    $image1 = $("#micropost_images_attributes_1_image");
    $image0.on("change", function(){
        $image1.show();
    });
     $image1.on("change", function(){
        $("#micropost_images_attributes_2_image").show();
    })
});