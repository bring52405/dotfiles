#!/usr/bin/python
import pygame
import curses
#import RPi.GPIO as GPIO


#GPIO.setmode ( GPIO.BCM )
#GPIO.setup ( 4 , GPIO.IN , pull_up_down=GPIO.PUD_UP )
#GPIO.setup ( 18 , GPIO.IN , pull_up_down=GPIO.PUD_UP )
#GPIO.setup ( 22 , GPIO.IN , pull_up_down=GPIO.PUD_UP )
#GPIO.setup ( 23 , GPIO.IN , pull_up_down=GPIO.PUD_UP )
#GPIO.setup ( 25 , GPIO.IN , pull_up_down=GPIO.PUD_UP )

def showWinner ( winner ):
   global screen
   global numbers

   winner -= 1
   screen.blit ( numbers [ winner ] [ 0 ] , ( numbers [ winner ] [ 1 ] , 0 ) )
   pygame.display.flip()

def reset():
   global screen

   screen.fill ( ( 0 , 0 , 0 ) )
   pygame.display.flip()

def getBuzzers():
   while 1:
      if GPIO.input ( 4 ) == GPIO.LOW:
         return 1
         break
      if GPIO.input ( 18 ) == GPIO.LOW:
         return 2
         break
      if GPIO.input ( 22 ) == GPIO.LOW:
         return 3
         break
      if GPIO.input ( 23 ) == GPIO.LOW:
         return 4
         break
      if GPIO.input ( 25 ) == GPIO.LOW:
         return 5
         break

pygame.display.init()
#screen = pygame.display.set_mode ( ( 1680 , 1050 ) )
screen = pygame.display.set_mode ( ( 1024 , 768 ) )
terminal = curses.initscr()
curses.cbreak()
terminal.nodelay ( 1 )
terminal.addstr ( 5 , 5 , "Trivia Buzzers and Scoring" )
terminal.addstr ( 7 , 5 , "          1 - 5 -- Show team as buzzed in" )
terminal.addstr ( 8 , 5 , "              r -- Reset buzzers" )
terminal.addstr ( 10 , 5 , "             b -- enable buzzers" )
terminal.addstr ( 11 , 5 , "             x -- Exit (Careful, no confirmation)" )
numbers = list()
left = 0
numbers.append ( ( pygame.image.load ( "numbers_01.jpg" ) , left ) )
#left += numbers [ 0 ] [ 0 ].get_width()
numbers.append ( ( pygame.image.load ( "numbers_02.jpg" ) , left ) )
#left += numbers [ 0 ] [ 0 ].get_width()
numbers.append ( ( pygame.image.load ( "numbers_03.jpg" ) , left ) )
#left += numbers [ 0 ] [ 0 ].get_width()
numbers.append ( ( pygame.image.load ( "numbers_04.jpg" ) , left ) )
#left += numbers [ 0 ] [ 0 ].get_width()
numbers.append ( ( pygame.image.load ( "numbers_05.jpg" ) , left ) )
running = True
while running == True:
   choice = terminal.getch ( 12 , 5 )
   if choice == -1: continue
   if choice == ord ( "1" ):
      showWinner ( 1 )
   elif choice == ord ( "2" ):
      showWinner ( 2 )
   elif choice == ord ( "3" ):
      showWinner ( 3 )
   elif choice == ord ( "4" ):
      showWinner ( 4 )
   elif choice == ord ( "5" ):
      reset()
      showWinner ( 5 )
   elif choice == ord ( "b" ):
      showWinner ( getBuzzers() )
   elif choice == ord ( "r" ):
      reset()
   elif choice == ord ( "x" ):
      running = False
curses.endwin()
