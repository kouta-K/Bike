document.addEventListener("turbolinks:load", function() {
    $(".admin-background").on("click", function(){
        if($(window).width() <= 600){
           if (!($(".admin-menu").hasClass("close"))){
               $(".admin-menu").addClass("close");
               $(".admin-menu-button").text('OPEN');
                $(".admin-menu").animate({
                    left: "-200px"
                }, 1000);
                $(".admin-background").addClass("disable");
           }
        }else{
            if (!($(".admin-menu").hasClass("close"))){
               $(".admin-menu").addClass("close");
               $(".admin-menu-button").text('OPEN');
                $(".admin-menu").animate({
                    left: 0
                }, 1000);
                $(".admin-background").addClass("disable");
           }
        }
       });
       
       $(".admin-menu-button").on("click", function(){
           if($(window).width() <= 600){
                if($(".admin-menu").hasClass("close")){
                    $(".admin-menu-button").text('CLOSE');
                    $(".admin-background").removeClass("disable");
                    $(".admin-menu").removeClass("close");
                    $(".admin-menu").animate({
                         left: 0
                     }, 1000);
                     
                }else{
                     $(".admin-menu").addClass("close");
                     $(".admin-menu-button").text('OPEN');
                     $(".admin-menu").animate({
                         left: "-200px"
                     }, 1000);
                     $(".admin-background").addClass("disable");
                }
           }else{
               if($(".admin-menu").hasClass("close")){
                    $(".admin-menu-button").text('CLOSE');
                    $(".admin-background").removeClass("disable");
                    $(".admin-menu").removeClass("close");
                    $(".admin-menu").animate({
                         left: "30vw"
                     }, 1000);
                     
                }else{
                     $(".admin-menu").addClass("close");
                     $(".admin-menu-button").text('OPEN');
                     $(".admin-menu").animate({
                         left: 0
                     }, 1000);
                     $(".admin-background").addClass("disable");
                }
           }
       }); 
});