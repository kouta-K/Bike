document.addEventListener("turbolinks:load", function() {
    $(".entire-post").find(".slide-images").on("click", function(){
      if($(this).find(".modal").hasClass("modal-style1")){
        $(this).find(".modal").removeClass("modal-style1");
        $(this).find("img").removeClass("modal-style2");
        $(this).find("img").addClass("post-image");
        $(this).next().removeClass("next-modal");
        $(this).next().addClass("next-modal1"); 
        $(this).prev().removeClass("prev-modal");
        $(this).prev().addClass("prev-modal1");
      }else{
        $(this).find(".modal").addClass("modal-style1");
        $(this).find("img").addClass("modal-style2");
        $(this).find("img").removeClass("post-image");
        $(this).next().addClass("next-modal");
        $(this).next().removeClass("next-modal1"); 
        $(this).prev().addClass("prev-modal");
        $(this).prev().removeClass("prev-modal1");
      }
    });
    
    
    $(".section").each(function(){
        var $tabsAnchor = $(this).find(".tabs-nav a");
        var $tabList = $(this).find(".tabs-nav");
        var $tabPanel = $(this).find(".tabs");
        $tabList.on("click", "a", function(event){
          event.preventDefault();
          var $this = $(this);
          if($this.hasClass("active")){
            return;
          }
          
          $tabsAnchor.removeClass("active");
          $this.addClass("active");
          
          $tabPanel.hide();
          $($this.attr("href")).show();
          });
        $tabsAnchor.eq(0).trigger("click");
    });
    
});
