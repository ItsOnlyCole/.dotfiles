import pyautogui
import random
import time

loop = 1

while loop == 1:
    waitTime = random.randint(0, 300)
    time.sleep(waitTime)
    pyautogui.press('space')
