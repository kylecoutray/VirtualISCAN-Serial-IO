import pygame
import sys

#initialize pygame
pygame.init()

#set up the window
WIDTH, HEIGHT = 800, 800
screen = pygame.display.set_mode((WIDTH, HEIGHT))
pygame.display.set_caption("Cursor Tracker / Unity Integration Example For Dr. Con")

#opens our file for writing cursor data
output_file = open("D:\suchaklutch\Dr.Constantinidis-PythonDS-Unity-Integration-Demo\DrConstantinidisExample\cursor_data.txt", "w")

#main loop
running = True
while running:
    #event handling
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

    #get position of cursor
    x, y = pygame.mouse.get_pos()

    #write position to file
    output_file.seek(0)  #reset file pos to overwrite
    output_file.write(f"{x-(WIDTH/2)},{y-(HEIGHT/2)}\n") #the -WIDTH/2 is to normalize the X/Y coordinates for Unity Formatting
    output_file.flush()  #write data immediately 

    #fill the screen with a color
    screen.fill((30, 30, 30))

    #puts a circle around the cursor to see easier
    pygame.draw.circle(screen, (255, 0, 0), (x, y), 15)

    #updates the display
    pygame.display.flip()

#clean up stuff
output_file.close()
pygame.quit()
sys.exit()
