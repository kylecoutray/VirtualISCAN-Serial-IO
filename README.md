The ISCAN RK-716 has three main methods of communication. TCP/IP, Serial IO, and Analog communication (According to the manual linked below). 
This project aims to simulate the Serial IO datastream from the Eye tracker sent over a COM port. 
Artifical data is generated, sent to a matlab script, then sent to unity to manipulate the position of a square game object. 
Once connection is terminated (Ctrl + C while each script is running) a .txt file is created with a mock report of the session. 
All header numbers are taken from make 60 of the manual and are in place only to simulate the expected output. 

This implementation should only need small tweaks such as changing the COM port and all respective file locations to work.

If the COM port is needed for a different purpose, a virtual COM port handling software can duplicate the datastream to be 
received by two separate ports simultaneously. 

**YT Explanation: https://youtu.be/8jHsFIrTHR0  **

<img width="500" alt="image" src="https://github.com/user-attachments/assets/6bbb57a6-d8c3-4488-9634-f44092fad651" />


**Slides: https://docs.google.com/presentation/d/1MSXIxmGMw3v5SWtk7prmrzXdsOhj-B-iG-vgr07ejzY/edit?usp=sharing **

<img width="500" alt="image" src="https://github.com/user-attachments/assets/bc8eb3a2-8995-4b5e-9c1e-d9441efe65e7" />


**
Manual: https://drive.google.com/file/d/1vXJKCOsH1SZiumEnMO0KRfHyZK_oCQal/view?usp=sharing ** 
<img width="500" alt="image" src="https://github.com/user-attachments/assets/2ab788a7-5ef3-48dd-96c1-60df3b9a8c4f" />
