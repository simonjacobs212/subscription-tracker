module FunStuff

  def display_logo
    @logo = frame2
    no_money = frame
    scroll_in(no_money, "light_green")
    sleep(0.2)
    play_multi_coin
    same_color("light_blue")
    sleep(1.0)
  end

  def logout
    sleep(0.5)
    scroll_out("light_green")
    play_mario_goodbye
    system 'clear'
  end

  def play_single_coin
    system 'afplay','-r','0.9','-v','0.6', 'app/lib/music/super-mario-world-coin.mp3'
  end

  def play_multi_coin
    system 'afplay','-r','0.9','-v','0.4', 'app/lib/music/super-mario-world-multiple-coins.mp3'
  end

  def play_mario_goodbye
    system 'afplay','-r','1.5','-v','0.3', 'app/lib/music/mk64_nexttime.wav'  
  end

  def play_warning_sound
    system 'afplay','-r','0.9','-v','0.6', 'app/lib/music/mk64_item_drop.wav'
  end

  def play_explosion
    system 'afplay','-r','1.4','-v','0.3', 'app/lib/music/explosion.wav'
  end

  def scroll_in(array, color)
    (array.length+1).times do |t|
      system 'clear'
      array.each_with_index do |line, index|
        if index >= t 
          puts line.send(:hide) 
        else 
          puts line.send("#{color}")
        end
      end
      sleep (0.02)
    end
  end

    def scroll_out(color)
      (@logo.length+1).times do |t|
        system 'clear'
        @logo.each_with_index do |line, index|
          if index >= t 
            puts line.send("#{color}") 
          else 
            puts line.send(:hide)
          end
        end
        sleep (0.02)
      end
    end

    def same_color(color)
        system 'clear'
        @logo.each { |line| puts line.send("#{color}") }
    end

  # def set_array
  # end
  def frame
    [
    " .d8888b.           888                                d8b          888    d8b",                   
    "d88P  Y88b          888                                Y8P          888    Y8P",                   
    "Y88b.               888                                             888",                          
    " ^Y888b.   888  888 88888b.  .d8888b   .d8888b 888d888 888 88888b.  888888 888  .d88b.  88888b.",  
    "    ^Y88b. 888  888 888 ^88b 88K      d88P`    888P`   888 888 `88b 888    888 d88``88b 888 `88b", 
    "      `888 888  888 888  888 `Y8888b. 888      888     888 888  888 888    888 888  888 888  888", 
    "Y88b  d88P Y88b 888 888 d88P      X88 Y88b.    888     888 888 d88P Y88b.  888 Y88..88P 888  888", 
    " `Y8888P`   `Y88888 88888P`   88888P'  `Y8888P 888     888 88888P`   `Y888 888  `Y88P`  888  888", 
    "                                                           888",                                   
    "                                                           888",                                   
    "                                                           888",                                   
    "                                     88888888888                       888",                       
    "                                         888                           888",                       
    "                                         888                           888",                       
    "                                         888  888d888 8888b.   .d8888b 888  888  .d88b.  888d888", 
    "                                         888  888P`      `88b d88P`    888 .88P d8P  Y8b 888P`",   
    "                                         888  888    .d888888 888      888888K  88888888 888",     
    "                                         888  888    888  888 Y88b.    888 `88b Y8b.     888",     
    "                                         888  888    `Y888888  `Y8888P 888  888  `Y8888  888"
  ]
  end    

  def multicolor_money_bag(color1, color2)
    "                
                   sdmmmmmmy+          
                    ydddmdo\n".send("#{color1}") +            
    "                     +++++\n".send("#{color2}") +      
    "                  +shdmmmdhyo              
              ohdmmmmm+smmmmmds      
            +ydmmmdyo+:++sdmmmdy+    
            ohdddddy sd:yh +dddddhs   
          ohddddddy oh:ydhhdddddddy+ 
          +hddddddddho. +shdddddddddy 
          ohddddddddddh:oo odddddddho
          ohddddddd1 dh:yd ddddddddh+
          shddddddy, o:+ ssdddddddho 
            oyhddddddhs:shddddddhhs+  
              +osyyhhhhhhhhhyyso+        ".send("#{color1}")
  end

  def plain_money_bag 
    "             
                  sdmmmmmmy+          
                   ydddmdo           
                    +++++      
                 +shdmmmdhyo              
              ohdmmmmm+smmmmmds      
            +ydmmmdyo+:++sdmmmdy+    
            ohdddddy sd:yh +dddddhs   
          ohddddddy oh:ydhhdddddddy+ 
          +hddddddddho. +shdddddddddy 
          ohddddddddddh:oo odddddddho
          ohddddddd1 dh:yd ddddddddh+
          shddddddy, o:+ ssdddddddho 
            oyhddddddhs:shddddddhhs+  
              +osyyhhhhhhhhhyyso+        "
  end

  def custom_clear
    system 'clear'
    @logo = frame2
    same_color("light_blue")
  end

  def frame2
    [
    " .d8888b.           888                                d8b          888    d8b                  ",                   
    "d88P  Y88b          888                                Y8P          888    Y8P                  ",                   
    "Y88b.               888                                             888                         ",                          
    " ^Y888b.   888  888 88888b.  .d8888b   .d8888b 888d888 888 88888b.  888888 888  .d88b.  88888b. ",  
    "    ^Y88b. 888  888 888 ^88b 88K      d88P`    888P`   888 888 `88b 888    888 d88``88b 888 `88b", 
    "      `888 888  888 888  888 `Y8888b. 888      888     888 888  888 888    888 888  888 888  888", 
    "Y88b  d88P Y88b 888 888 d88P      X88 Y88b.    888     888 888 d88P Y88b.  888 Y88..88P 888  888", 
    " `Y8888P`   `Y88888 88888P`   88888P'  `Y8888P 888     888 88888P`   `Y888 888  `Y88P`  888  888", 
    "                                                           888                                  ",                                   
    "              sdmmmmmmy+                                   888                                  ",                                   
    "               ydddmdo                                     888                                  ",                                   
    "                +++++                                                                           ",  
    "             +shdmmmdhyo             88888888888                       888                      ",                       
    "          ohdmmmmm+smmmmmds              888                           888                      ",                       
    "        +ydmmmdyo+:++sdmmmdy+            888                           888                      ",                       
    "        ohdddddy sd:yh +dddddhs          888  888d888 8888b.   .d8888b 888  888  .d88b.  888d888", 
    "      ohddddddy oh:ydhhdddddddy+         888  888P`      `88b d88P`    888 .88P d8P  Y8b 888P`  ",   
    "      +hddddddddho. +shdddddddddy        888  888    .d888888 888      888888K  88888888 888    ",     
    "      ohddddddddddh:oo odddddddho        888  888    888  888 Y88b.    888 `88b Y8b.     888    ",     
    "      ohddddddd1 dh:yd ddddddddh+        888  888    `Y888888  `Y8888P 888  888  `Y8888  888    ",
    "      shddddddy, o:+ ssdddddddho                                                                ",
    "       oyhddddddhs:shddddddhhs+                                                                 ",
    "         +osyyhhhhhhhhhhyyso+                                                                   ", 
    "                                                                                                ",
    "                                                                                                ",
  ]
  end    

end

class String
  
  def center_align
    string_length = self.length
    string_center = string_length/2
    screen_width = TTY::Screen.width
    screen_center = screen_width / 2
    offset = screen_center - string_center
    "#{sprintf("%#{offset}s" % self)}"
  end
end



