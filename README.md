# HyASynth
HyASynth. A distributed digital signal processor, designed to be as similar to a High Availability(HA, hence the capital letters in HyASynth) cluster as possible.
This project uses SuperCollider, preempt_rt and ptp4l(optionally) to achieve an optimised, distributed DSP environment, where the failure of a single computer means the loss
of a singular sound, not the loss of sound entirely. This framework provides you with much more headroom for DSP, you wil no longer have to limit yourself based off of your 
CPU load, you simply distribute the SynthDefs and/or functions to another node. For instance, if you had some heavy modal synthesis from [mi-Ugens](https://github.com/v7b1/mi-UGens/tree/main)
and you wanted a thick FFT magnitude smear and a thick NHHall reverb to follow, on a single PC you would have to be incredibly careful with your memory allocation, with HyASynth,
you simply plug output from the node running the mi-Ugen to the input of the node running the FX using aux (Yes! Real patching! Like a real Eurorack!), you would only have to worry about your amplitude.


# Deployment:
0. Accept there is no Quick-Start.
1. Gather nodes, any computers able to run Debian with a GUI will work.
2. Find/buy a switch, if you are able to afford it, buy a switch which supports PTP, if you cannot, just buy any normal switch.
3. Prepare nodes by fixing any issues with them, then replace the CMOS.
4. Enter the BIOS, disable C-States, disable Cool 'n' Quiet/SpeedStep and disable everything which sounds like it interferes with the CPU clock speed, if you're able to lock the BCLK speed, do it.
5. Disable virtualization, keep fans at 100%. (Don't worry, when you hear your own kick drum shake the walls you won't even hear the fans)
6. Make a Debian boot stick.
7. Install Debian, choose a light GUI.
8. Boot into Debian.
9. Run ```$ sudo apt install supercollider sc3-plugins jackd linux-headers-rt-amd64 linux-image-rt-amd64 alsa-utils qjackctl```
10. Create an RDP server on the node, there are many different ways to do it, so, figure it out ;).
11. Edit your IP configuration and set it to static, assign an IP that is easy to remember and NOT reserved.
12. Rinse and repeat for each node.
13. Buy a mixer with enough channels to support however many nodes you have, else NetJack will have to do.
14. Invest in some high quality, shielded male aux to aux cables, unless you like the wacky, "organic" sounds that come with EMI.

# Nav:
This repository will also host some of my live jams (scd files) and my frequently used SynthDefs.
