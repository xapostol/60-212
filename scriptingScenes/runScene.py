# Xavier Apostol
# 60-212 (Last Project)
# SCRIPTING SCENES
    # NOTE: runs in python 2.7

import os
import re
import time
import msvcrt
import random
import pyttsx
import pygame
from textwrap import fill
from cleverbot import Cleverbot

###########################
### INITIALIZING THINGS ###
###########################
# initializing chat bots
bot1Name = "ROBOTIC VOICE 1"
cb1 = Cleverbot()
bot2Name = "ROBOTIC VOICE 2"
cb2 = Cleverbot()

# getting started with voice recognition
engBots = pyttsx.init()
voices = engBots.getProperty('voices')

# misc
sleepTime = 1

# conversation lists
bot1Conversation = []
bot2Conversation = []

# max length for text
maxTextLen = 60


#####################
### TRUNCATE TEXT ###
#####################
# formats txt appropriately (text wrapping)
def formatTxt(text):
    lstSpace = []

    text = fill(text, maxTextLen)
    for char in range(0, len(text)):
        if text[char] == "\n":
            lstSpace.append(char)
    return lstSpace


###############################
### GET CAPTIONS AND IMAGES ###
###############################
# change to location of "photo_database" folder
picsFldr = "C:/Users/Xavier/Desktop/60-212/Class Work/FINAL PROJECT/scriptingScenes/photo_database" 
filenameLst = []

# collect photo names
for f in os.listdir(picsFldr):
    fileName, fileExt = os.path.splitext(f)
    filenameLst.append(fileName)

# collect captions
fo = open("SBU_captions_F2K.txt", 'r')
captionsList = fo.read().split('\n')
fo.close()

# all image titles are numbers
def grabCaption(imgTitle):
    indx = int(imgTitle)
    return (captionsList[indx])


####################
### PYGAME STUFF ###
####################
# initiating pygame
pygame.init()

# start window/set values
running = True
windSz = winW, winH = 1280, 720
#windSz = winW, winH = 1920, 1080
window = pygame.display.set_mode(windSz, pygame.RESIZABLE)
pygame.display.set_caption("Robotic Voices Script")

imgSz = imgW, imgH = 450, 400
#imgSz = imgW, imgH = 600, 550

backGClr = (0, 0, 0)
window.fill(backGClr)

# optimize frame rate
clock = pygame.time.Clock()
framesPSec = 30
clock.tick(framesPSec)  # change FPS

# font implementation
fontSz = imgW / 10
font  = pygame.font.SysFont("Arial", fontSz)
fontClr = (255, 255, 255)

# bot X and Y
displayTextX = winW/2
displayTextY = winH/2 + fontSz*3 + 10


####################################
### BASIS CODE FOR CONVERSATIONS ###
####################################
# loads and displays picture of interest
def displayPicture(pictureName):
    imgLoad = pygame.image.load(picsFldr + "/" + pictureName + ".jpg").convert()
    imgLoad = pygame.transform.scale(imgLoad, (imgW,imgH))
    window.blit(imgLoad,(displayTextX-imgW/2, displayTextY-(imgH + fontSz/1.5)))

# displays text for each bot on screen
def displayConvo(botName, botVoice, botText, pictureName):
    # initializing variables
    botTextLH1 = ""  # last half of botText (if too big)
    botTextLH2 = ""  # last half of botText (if bigger than twice the maxLen)
    indxChng1 = 0
    indxChng2 = 0

    # for testing
    #print(pictureName)
    #print(botName + " - " + botText)

    # set voice and what to say
    engBots.setProperty('voice', voices[botVoice].id)  # feminine voice
    engBots.say(botText)

    # start writing text
    if len(botText) > maxTextLen*2:
        # formats to three lines
        indxChng1 = formatTxt(botText)[0]
        indxChng2 = formatTxt(botText)[1]
        botTextLH2 = botText[indxChng2+1:]
        botTextLH1 = botText[indxChng1+1:indxChng2]
        botText = botText[:indxChng1]

    elif len(botText) > maxTextLen:
        # formats to two lines
        indxChng1 = formatTxt(botText)[0]
        botTextLH1 = botText[indxChng1+1:]
        botText = botText[:indxChng1]

    # sets up vocalization of text
    vocTxt = font.render(botText, False, fontClr)
    vocTxtLH1 = font.render(botTextLH1, False, fontClr)
    vocTxtLH2 = font.render(botTextLH2, False, fontClr)

    # displays text
    window.blit(vocTxt,    (displayTextX - vocTxt.get_rect().width/2,
                            displayTextY))
    window.blit(vocTxtLH1, (displayTextX - vocTxtLH1.get_rect().width/2,
                            displayTextY + fontSz))
    window.blit(vocTxtLH2, (displayTextX - vocTxtLH2.get_rect().width/2,
                            displayTextY + fontSz*2))

    displayPicture(pictureName)  # display subject
    pygame.display.update()      # update display
    engBots.runAndWait()         # vocalize text
    time.sleep(sleepTime)        # wait time
    window.fill(backGClr)        # reset canvas (set to black to erase prev msg)


#####################
### RUNNING SCENE ###
#####################
# runs entire scene (program)
def runScene():
    # setting counter and magic numbers
    count = 1
    maxRuns = 200  # free to change

    ####################
    ### CONVERSATION ###
    ####################
    # bot 1 starts conversation
    time.sleep(10)
    ranPicName = random.choice(filenameLst)

    bot1Response = grabCaption(ranPicName)
    displayConvo(bot1Name, 0, bot1Response, ranPicName)
    bot1Conversation.append(bot1Response)

    while (count <= maxRuns):
        # chances of implementing item
        ranInt = random.randint(5, 10)
        result = count % 4

        """
        # testing purposes
        print("Random Int: " + str(ranInt))
        print("Result: " + str(result))
        print("\n")
        """

        # check if randomly apply item from "Table of Responses"
        if (result == 0):
            # collects random picture and caption
            ranPicName = random.choice(filenameLst)
            bot2Response = grabCaption(ranPicName)
        # check if it's time to say goodbye.
        elif (count == maxRuns):
            bot2Response = "Bye."
        # else keep responding
        else:
            bot2Response = cb2.ask(bot1Response)


        # bot 2 responds
        displayConvo(bot2Name, 1, bot2Response, ranPicName)
        bot2Conversation.append(bot2Response)

        # bot 1 responds
        bot1Response = cb1.ask(bot2Response)
        displayConvo(bot1Name, 0, bot1Response, ranPicName)
        bot1Conversation.append(bot1Response)

        count += 1

        # press anything to stop program (break out of loop)
        if msvcrt.kbhit():
            break

    pygame.quit()


#########################
### WRITING TEXT FILE ###
#########################
# writes conversation to a .txt file (script)
def saveConversationToScript():
    file = open("robotic_voices_script.txt", "w")

    file.write("SCENE 1")
    file.write("\n")
    file.write("INT. DARKNESS")
    file.write("\n")
    file.write("\n")

    file.write("There is nothing but darkness.")
    file.write("\n")
    file.write("Suddenly, two robot voices emit into conversation.")
    file.write("\n")
    file.write("The first, ROBOTIC VOICE 1, speaks.")
    file.write("\n")
    file.write("=============================================")
    file.write("\n")
    file.write("\n")

    for i in range(0, len(bot1Conversation)):
        file.write(bot1Name)
        file.write("\n")
        file.write(bot1Conversation[i])
        file.write("\n")
        file.write("\n")

        file.write(bot2Name)
        file.write("\n")
        if i == len(bot1Conversation) - 1:
            file.write("*SILENCE*")
        else:
            file.write(bot2Conversation[i])
        file.write("\n")
        file.write("\n")

    file.write("=============================================")
    file.write("\n")
    file.write("The voices stop.")
    file.write("\n")
    file.write("There is nothing but darkness.")
    file.write("\n")
    file.write("\n")
    file.write("END SCENE")

    file.close()


#########################
### RUNNING FUNCTIONS ###
#########################
runScene()
saveConversationToScript()
