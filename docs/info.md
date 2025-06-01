<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

## How it works

This project implements a simple 8-bit adder using the ui_in and uio_in input buses. The adder computes the sum of the two 8-bit inputs and outputs the lower 8 bits of the result to uo_out. If there is an overflow (i.e., a carry out from the 8th bit), it is indicated on uio_out[0].

## How to test

Connect 8-bit input A to the ui_in pins.

Connect 8-bit input B to the uio_in pins.

Read the result of the addition on the uo_out pins.

Check uio_out[0] for the carry-out (overflow) bit — it will be 1 if the result exceeds 8 bits.

## External hardware

No external hardware is required.
