import serial
import time
import random

# static header data based off of ETL-200 user manual
# page 60

HEADER = """
Note: None of this information is accurate, it's all 
mimicked from the example file in the documentation
for the ISCAN ETL-200. It's in the ASCII format as
one would expect when using something like the 
ISCAN model RK-716 as used here: 
https://doi.org/10.1152/jn.00290.2023

RUN INFORMATION TABLE

Run # Date Start Time Samples Samps/Sec Run Secs Image
File Description
1 2011/06/30 14:09:24   1022      120     8.52
default.igr New Data Run

DATA SUMMARY TABLE

                   Raw     Raw
Run #   Param      Mean    StdDev
    1 
        Pupil H1  302.49   62.1576
        Pupil V1  146.49   9.6055
        Pupil D1  87.63    1.5796
        P-CR H1  -26.11    26.2626
        P-CR V1  -25.11    4.3004

DATA INFO (randomly generated within a threshold)

Run 1:      Pupil H1 Pupil V1 Pupil D1 P-CR H1 P-CR V1
Sample       (Raw)     (Raw)    (Raw)   (Raw)    (Raw)
"""

def generate_sample(sample_number):
    """
    this generates a single sample row with realistic random values.
    """
    pupil_h1 = round(random.uniform(240, 245), 2)  # pupil h1 around 242
    pupil_v1 = round(random.uniform(135, 140), 2)  # pupil v1 around 136
    pupil_d1 = round(random.uniform(87, 90), 2)    # pupil d1 around 88
    p_cr_h1 = round(random.uniform(-3.0, -1.5), 2) # P-CR h1 around -2
    p_cr_v1 = round(random.uniform(-28.5, -28.0), 2) # P-CR v1 around -28.5

    #these are using values off the data sheet. taking what "should" be the center...
    #242-(-2.8) ~ 245 = X pos
    #136-(-28.5) ~ 163 = Y pos
    #So... adjusted positions will be edited by this much in order to have it around the "center"


    return f"  {sample_number}         {pupil_h1}    {pupil_v1}    {pupil_d1}    {p_cr_h1}    {p_cr_v1}\n"

def send_data():
    # open a serial port for communication
    # for our purposes we are using a virtual connection
    # sending through COM2 and receiving through COM3
    # Software: Virtual Serial Port Driver Pro
    # baudrate of 115200 because that's the reported rate
    # in the manaul for the ISCAN system.
    with serial.Serial("COM2", baudrate=115200, timeout=1) as sender:
       
        # send the header once
        sender.write(HEADER.encode('utf-8'))

        print("header:")
        print(HEADER)
        time.sleep(1.5)

        # continuously send random sample rows
        sample_number = 1
        try:
            while True:
                sample_row = generate_sample(sample_number)
                sender.write(sample_row.encode('utf-8'))
                print(f"    {sample_row.strip()}")
                sample_number += 1
                time.sleep(1.5)  # wait 1.5 second between samples
                
        except KeyboardInterrupt:
            print("\nTransmission stopped by user.")

if __name__ == "__main__":
    send_data()
