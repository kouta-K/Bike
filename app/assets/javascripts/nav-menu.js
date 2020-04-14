document.addEventListener("turbolinks:load", function(){
    $(".navbar").on("click", function(){
        if($(".navbar").hasClass("close")){
            $(".navbar").removeClass("close");
            $(".nav-menu").animate({
               top: "50px" 
            }, 500);
        }else{
            $(".navbar").addClass("close");
            $(".nav-menu").animate({
               top: "-360px" 
            }, 500);
        }
    });
    
    $(".top-link").on("click", function(){
        $("html, body").stop(true).animate({
          scrollTop: 0
        }, "slow");
    });
});