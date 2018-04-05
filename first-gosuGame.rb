require 'gosu' 
require 'ruby2d'

Square.new(x: 320, y: 240, size: 50, color: 'red') #create prototype
square1 = Square.new(x: 320, y: 240, size: 50, color: 'red') #create prototype



class Player
    def initialize
        @image = Gosu::Image.new("assets/starfighter.bmp")
        @x = @y = @vel_x = @vel_y = @angle = 0.0
        @score = 0
    end

    def warp(x, y)
        @x, @y = x, y
    end

    def turn_left
        @angle -= 4.5
    end

    def turn_right
        @angle += 4.5
    end

    def accelerate
        @vel_x += Gosu.offset_x(@angle, 0.5)
        @vel_y += Gosu.offset_y(@angle, 0.5)
    end
    
    def move
        @x += @vel_x
        @y += @vel_y
        @x %= 640
        @y %= 480

        @vel_x *= 0.95
        @vel_y *- 0.95  
    end
    
    def draw
        @image.draw_rot(@x, @y, 1, @angle)
    end
end

class Tutorial < Gosu::Window #update() and draw() are overrides of methods defined by gosu::window
    def initialize
        super 640, 480
        self.caption = "Gosu Tutorial: Ruby Sample Game"
        @player = Player.new
        @player.warp(320, 240)
        @background_image = Gosu::Image.new("assets/space.png", :tileable => true)
    end

    def update #update() is called 60times/sec by default.
        if Gosu.button_down? Gosu::KB_LEFT or Gosu::button_down? Gosu::GP_LEFT
            @player.turn_left 
        end
        if Gosu.button_down? Gosu::KB_RIGHT or Gosu::button_down? Gosu::GP_RIGHT
            @player.turn_right
        end
        if Gosu.button_down? Gosu::KB_UP or Gosu::button_down? Gosu::GP_BUTTON_0
            @player.accelerate
        end
        @player.move
    end

    def draw #draw() is also called 60 times per second, but may be skipped
             #should contain code that redraw the whole scene, no game logic
        square1 = Square.new(x: 320, y: 240, size: 50, color: 'red')
        @player.draw 
       
     end

    def button_down(id)
        if id == Gosu::KB_ESCAPE
            close
        end
            super   
        end
     end

#main program: we create a window and call its show() method.
#which does not return until the window has been closed by the user
Tutorial.new.show
show
