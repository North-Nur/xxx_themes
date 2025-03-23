document.addEventListener("DOMContentLoaded", function () {
    
  
    let url = 'nui://nc_inventory/html/img/items/'
    let MYDATA = []
    let AllData = []
    let LoadStatus = false 
    let currentUse = ''
    let CurrentSelect 
    window.addEventListener('message', function(event) {
        if(event.data.action == 'display'){
            if(event.data.bool){
                $('.display_custom_chat').fadeIn()

            }
            else{
                $('.display_custom_chat').fadeOut()
            }
        }
        if(event.data.action == 'updateThemes'){
            if(event.data.typeAdd == 'ADD'){
                $('[data-themes = "'+event.data.themes+'"]').addClass('owned')
                if(CurrentSelect == event.data.themes){
                    $('.button_theme')
                    .removeClass() // ลบคลาสทั้งหมด
                    .addClass('button_theme')
                }
            }
            else{
                $('[data-themes = "'+event.data.themes+'"]').removeClass('owned')
                currentUse = 'normal_v1'
                SelectThemes(currentUse)
                
            }
            MYDATA = event.data.newdata
        }
        if(event.data.action == 'use'){
            currentUse = event.data.themes
            if(currentUse == CurrentSelect){
                $('.button_theme')
                .removeClass() // ลบคลาสทั้งหมด
                .addClass('equiped button_theme')
            }
            $('.selection_theme').removeClass('use')
            $('[data-themes = "'+currentUse+'"]').addClass('use')

        }
        if(event.data.action == 'syncData'){
            $('.chat_area_overflow_y').empty()
            AllData = event.data.all
            for (key in event.data.all){
                $('.chat_area_overflow_y').append(`
                      <div class="selection_theme " data-themes = "${event.data.all[key].themes}">
                           
                            <div class="twitter_box_1 ${event.data.all[key].themes}">
                            <div class="tw_box_image">
                                <div class="box_image_in">
                                <div class="border_theme"></div>
                                <img onerror="this.style.display='none';" src="img/logo_1.png" alt="">
                              
                                </div>
                            </div>
                            <div class="tw_box_detail ">
                                <div class="tw_name_area">
                                <p class="tw_name">${event.data.all[key].name || 'Themes'}</p>
                                <p class="tw_time">10:24</p>
                                </div>
                                <div class="tw_comment_area">
                                <p>ยินดีต้อนรับเข้าสู่ ATHENA TOWN</p>
                                </div>
                               
                            </div>
                            <div class="tw_tag"><p>CELEB</p></div>
                            </div>
                
                            <div class="selection_status">
                            <iconify-icon icon="ep:arrow-left-bold"></iconify-icon>
                            </div>
                     </div>
                    
                `)
            }
            for (key in event.data.mydata.data){
                $('[data-themes = "'+event.data.mydata.data[key]+'"]').addClass('owned')
            }
            MYDATA = event.data.mydata.data
            $('[data-themes = "'+event.data.mydata.use+'"]').addClass('active')
            currentUse = event.data.mydata.use
            $('[data-themes = "'+currentUse+'"]').addClass('use')

            SelectThemes(event.data.mydata.use)
            // $('.for_show_1')
            // .removeClass() // ลบคลาสทั้งหมด
            // .addClass('twitter_box_1 for_show_1 '+event.data.mydata.use+'');
            // $('.for_show_2')
            // .removeClass() // ลบคลาสทั้งหมด
            // .addClass('twitter_box_1 for_show_2 img_add '+event.data.mydata.use+'');
        } 
    })
    function SelectThemes(themes) {
        $('.for_show_1')
        .removeClass() // ลบคลาสทั้งหมด
        .addClass('twitter_box_1 for_show_1 '+themes+'');
        $('.for_show_2')
        .removeClass() // ลบคลาสทั้งหมด
        .addClass('twitter_box_1 for_show_2 img_add '+themes+'');
        let ClassAdd = 'button_theme'
        let check = false 
        for (key in MYDATA){
            if(MYDATA[key] == themes){
                check = true 
            }
        }
        for (key in AllData){
            if(AllData[key].themes == themes){
                $('.name_preview').html(AllData[key].name)
            }
        }
        if(check){
            if (currentUse == themes){
                ClassAdd += ' equiped'
            }
        }
        else{
            ClassAdd += ' locked'
        }
        $('.button_theme')
        .removeClass() // ลบคลาสทั้งหมด
        .addClass(ClassAdd)
    
        CurrentSelect = themes
    }
    $('body').on('click','.selection_theme',function(){
        if($(this).hasClass('active') || LoadStatus ){return}
        $('.selection_theme').removeClass('active')
        $(this).addClass('active')
        var sound = new Audio(`./sound/click_menu.wav`);
        sound.volume = 0.15        
    
        sound.play()
        SelectThemes($(this).attr('data-themes'))
    })
    $('body').on('click','.button_theme',function(){
       if($(this).hasClass('locked')){return}
       $(this).addClass('loading')
       LoadStatus = true 
       var sound = new Audio(`./sound/finish.mp3`);
       sound.volume = 0.15        
   
       sound.play()
        setTimeout(() => {
          
            $.post(`https://${GetParentResourceName()}/select`, JSON.stringify({
                key : CurrentSelect
            }))
            $(this).removeClass('loading')
            LoadStatus = false  
        }, 1200);
       
    })


    document.onkeyup = function (data) {
       
        if (data.which == 27 ) {
            if(LoadStatus){return}
            $.post(`https://${GetParentResourceName()}/exit`, JSON.stringify({
                
            }))
        }
    }
  
})