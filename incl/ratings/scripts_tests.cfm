    <style> /* Add a hue-rotate filter to all the smileys before the hovered one */
    .techno-smiley:hover ~ .techno-smiley[data-id="1"] {
        filter: hue-rotate(0deg);
    }
    .techno-smiley:hover ~ .techno-smiley[data-id="2"] {
        filter: hue-rotate(60deg);
    }
    .techno-smiley:hover ~ .techno-smiley[data-id="3"] {
        filter: hue-rotate(120deg);
    }
    ...
    /* Add a class to the clicked smiley and all the ones before it */
    .techno-smiley[data-id="1"].clicked {
        filter: hue-rotate(0deg);
    }
    .techno-smiley[data-id="2"].clicked {
        filter: hue-rotate(60deg);
    }
    .techno-smiley[data-id="3"].clicked {
        filter: hue-rotate(120deg);
    }
   
    .smiley_img:hover:nth-child(1), .smiley_img.active:nth-child(1) {
        filter: hue-rotate(0deg);
    }
    .smiley_img:hover:nth-child(2), .smiley_img.active:nth-child(2), .smiley_img.active:nth-child(1) {
        filter: hue-rotate(60deg);
    }
    .smiley_img:hover:nth-child(3), .smiley_img.active:nth-child(3), .smiley_img.active:nth-child(2), .smiley_img.active:nth-child(1) {
        filter: hue-rotate(120deg);
    }
    .smiley_img:hover:nth-child(4), .smiley_img.active:nth-child(4), .smiley_img.active:nth-child(3), .smiley_img.active:nth-child(2), .smiley_img.active:nth-child(1) {
        filter: hue-rotate(180deg);
    }
    .smiley_img:hover:nth-child(5), .smiley_img.active:nth-child(5), .smiley_img.active:nth-child(4), .smiley_img.active:nth-child(3), .smiley_img.active:nth-child(2), .smiley_img.active:nth-child(1) {
        filter: hue-rotate(240deg);
    }
    </style>

    <script>
        $(".smiley_img").hover(function(){
            var index = $(this).index() + 1;
            $(".smiley_img:lt("+index+")").addClass("hovered");
        }, function(){
            $(".smiley_img").removeClass("hovered");
        });
        $(".smiley_img").click(function(){
            $(".smiley_img").removeClass("active");
            $(this).addClass("active");
        });
        var smileys = document.querySelectorAll('.techno-smiley');
        smileys.forEach(function(smiley) {
            smiley.addEventListener('click', function() {
                var id = this.dataset.id;
                var clickedSmileys = document.querySelectorAll('.techno-smiley[data-id="' + id + '"]');
                clickedSmileys.forEach(function(smiley) {
                    smiley.style.filter = 'hue-rotate(' + hue + 'deg)';
                    });
                    
                    // Add event listener for click on each smiley
                    var smileys = document.querySelectorAll('.techno-smiley');
                    smileys.forEach(function(smiley) {
                    smiley.addEventListener('click', function() {
                    // Remove selected class from all smileys
                    smileys.forEach(function(smiley) {
                    smiley.classList.remove('selected');
                    });
                    // Add selected class to clicked smiley
                    this.classList.add('selected');
                    // Get the id of the clicked smiley
                    var id = this.getAttribute('data-id');
                    // Set the value of the input with the same id as the clicked smiley
                    var input = document.querySelector('.form_techno[data-id="' + id + '"]');
                    input.checked = true;
                    });
                    });
                    }
                    
                    // call the function on load
                    document.addEventListener('DOMContentLoaded', function(){
                    smileyHover();
                    });
                    )
                });
    //in html add data-id="n" to images
    </script>