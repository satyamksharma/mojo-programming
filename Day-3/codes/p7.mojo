# 7.	WAP to generate random numbers from 1-128 using necessary python library.

from random.random import random_si64

def main():
  for i in range(10):
    print(random_si64(1, 128))
