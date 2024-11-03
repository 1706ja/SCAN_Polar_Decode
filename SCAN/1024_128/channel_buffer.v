`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/10/26 11:35:37
// Design Name: 
// Module Name: channel_buffer
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module channel_buffer #(parameter Q = 6,parameter P = 128)
(
input [Q-1:0] channel_LLR,
input channel,
input clk,
input rst,
                    
output [P*Q-1:0] channel_set_LLR,
output buffer_ready,
output [4:0] O_channel_count
);
    
    reg [P*Q-1:0] buffer;
    reg [7:0] counter;
    reg [4:0] channel_count;
    reg flag;
    
    assign O_channel_count = channel_count;
    
    always @(posedge clk) begin
        if(rst) begin
            buffer <= 0; counter<=0; flag <= 0; channel_count <= 0;
        end else begin
            if(buffer_ready) begin
                channel_count <= channel_count + 1;
            end
            if(channel==0) begin
                buffer[P*Q-1:(P-1)*Q] <= channel_LLR;
                buffer[ 5 : 0 ] <= buffer[ 11 : 6 ];
                buffer[ 11 : 6 ] <= buffer[ 17 : 12 ];
                buffer[ 17 : 12 ] <= buffer[ 23 : 18 ];
                buffer[ 23 : 18 ] <= buffer[ 29 : 24 ];
                buffer[ 29 : 24 ] <= buffer[ 35 : 30 ];
                buffer[ 35 : 30 ] <= buffer[ 41 : 36 ];
                buffer[ 41 : 36 ] <= buffer[ 47 : 42 ];
                buffer[ 47 : 42 ] <= buffer[ 53 : 48 ];
                buffer[ 53 : 48 ] <= buffer[ 59 : 54 ];
                buffer[ 59 : 54 ] <= buffer[ 65 : 60 ];
                buffer[ 65 : 60 ] <= buffer[ 71 : 66 ];
                buffer[ 71 : 66 ] <= buffer[ 77 : 72 ];
                buffer[ 77 : 72 ] <= buffer[ 83 : 78 ];
                buffer[ 83 : 78 ] <= buffer[ 89 : 84 ];
                buffer[ 89 : 84 ] <= buffer[ 95 : 90 ];
                buffer[ 95 : 90 ] <= buffer[ 101 : 96 ];
                buffer[ 101 : 96 ] <= buffer[ 107 : 102 ];
                buffer[ 107 : 102 ] <= buffer[ 113 : 108 ];
                buffer[ 113 : 108 ] <= buffer[ 119 : 114 ];
                buffer[ 119 : 114 ] <= buffer[ 125 : 120 ];
                buffer[ 125 : 120 ] <= buffer[ 131 : 126 ];
                buffer[ 131 : 126 ] <= buffer[ 137 : 132 ];
                buffer[ 137 : 132 ] <= buffer[ 143 : 138 ];
                buffer[ 143 : 138 ] <= buffer[ 149 : 144 ];
                buffer[ 149 : 144 ] <= buffer[ 155 : 150 ];
                buffer[ 155 : 150 ] <= buffer[ 161 : 156 ];
                buffer[ 161 : 156 ] <= buffer[ 167 : 162 ];
                buffer[ 167 : 162 ] <= buffer[ 173 : 168 ];
                buffer[ 173 : 168 ] <= buffer[ 179 : 174 ];
                buffer[ 179 : 174 ] <= buffer[ 185 : 180 ];
                buffer[ 185 : 180 ] <= buffer[ 191 : 186 ];
                buffer[ 191 : 186 ] <= buffer[ 197 : 192 ];
                buffer[ 197 : 192 ] <= buffer[ 203 : 198 ];
                buffer[ 203 : 198 ] <= buffer[ 209 : 204 ];
                buffer[ 209 : 204 ] <= buffer[ 215 : 210 ];
                buffer[ 215 : 210 ] <= buffer[ 221 : 216 ];
                buffer[ 221 : 216 ] <= buffer[ 227 : 222 ];
                buffer[ 227 : 222 ] <= buffer[ 233 : 228 ];
                buffer[ 233 : 228 ] <= buffer[ 239 : 234 ];
                buffer[ 239 : 234 ] <= buffer[ 245 : 240 ];
                buffer[ 245 : 240 ] <= buffer[ 251 : 246 ];
                buffer[ 251 : 246 ] <= buffer[ 257 : 252 ];
                buffer[ 257 : 252 ] <= buffer[ 263 : 258 ];
                buffer[ 263 : 258 ] <= buffer[ 269 : 264 ];
                buffer[ 269 : 264 ] <= buffer[ 275 : 270 ];
                buffer[ 275 : 270 ] <= buffer[ 281 : 276 ];
                buffer[ 281 : 276 ] <= buffer[ 287 : 282 ];
                buffer[ 287 : 282 ] <= buffer[ 293 : 288 ];
                buffer[ 293 : 288 ] <= buffer[ 299 : 294 ];
                buffer[ 299 : 294 ] <= buffer[ 305 : 300 ];
                buffer[ 305 : 300 ] <= buffer[ 311 : 306 ];
                buffer[ 311 : 306 ] <= buffer[ 317 : 312 ];
                buffer[ 317 : 312 ] <= buffer[ 323 : 318 ];
                buffer[ 323 : 318 ] <= buffer[ 329 : 324 ];
                buffer[ 329 : 324 ] <= buffer[ 335 : 330 ];
                buffer[ 335 : 330 ] <= buffer[ 341 : 336 ];
                buffer[ 341 : 336 ] <= buffer[ 347 : 342 ];
                buffer[ 347 : 342 ] <= buffer[ 353 : 348 ];
                buffer[ 353 : 348 ] <= buffer[ 359 : 354 ];
                buffer[ 359 : 354 ] <= buffer[ 365 : 360 ];
                buffer[ 365 : 360 ] <= buffer[ 371 : 366 ];
                buffer[ 371 : 366 ] <= buffer[ 377 : 372 ];
                buffer[ 377 : 372 ] <= buffer[ 383 : 378 ];
                buffer[ 383 : 378 ] <= buffer[ 389 : 384 ];
                buffer[ 389 : 384 ] <= buffer[ 395 : 390 ];
                buffer[ 395 : 390 ] <= buffer[ 401 : 396 ];
                buffer[ 401 : 396 ] <= buffer[ 407 : 402 ];
                buffer[ 407 : 402 ] <= buffer[ 413 : 408 ];
                buffer[ 413 : 408 ] <= buffer[ 419 : 414 ];
                buffer[ 419 : 414 ] <= buffer[ 425 : 420 ];
                buffer[ 425 : 420 ] <= buffer[ 431 : 426 ];
                buffer[ 431 : 426 ] <= buffer[ 437 : 432 ];
                buffer[ 437 : 432 ] <= buffer[ 443 : 438 ];
                buffer[ 443 : 438 ] <= buffer[ 449 : 444 ];
                buffer[ 449 : 444 ] <= buffer[ 455 : 450 ];
                buffer[ 455 : 450 ] <= buffer[ 461 : 456 ];
                buffer[ 461 : 456 ] <= buffer[ 467 : 462 ];
                buffer[ 467 : 462 ] <= buffer[ 473 : 468 ];
                buffer[ 473 : 468 ] <= buffer[ 479 : 474 ];
                buffer[ 479 : 474 ] <= buffer[ 485 : 480 ];
                buffer[ 485 : 480 ] <= buffer[ 491 : 486 ];
                buffer[ 491 : 486 ] <= buffer[ 497 : 492 ];
                buffer[ 497 : 492 ] <= buffer[ 503 : 498 ];
                buffer[ 503 : 498 ] <= buffer[ 509 : 504 ];
                buffer[ 509 : 504 ] <= buffer[ 515 : 510 ];
                buffer[ 515 : 510 ] <= buffer[ 521 : 516 ];
                buffer[ 521 : 516 ] <= buffer[ 527 : 522 ];
                buffer[ 527 : 522 ] <= buffer[ 533 : 528 ];
                buffer[ 533 : 528 ] <= buffer[ 539 : 534 ];
                buffer[ 539 : 534 ] <= buffer[ 545 : 540 ];
                buffer[ 545 : 540 ] <= buffer[ 551 : 546 ];
                buffer[ 551 : 546 ] <= buffer[ 557 : 552 ];
                buffer[ 557 : 552 ] <= buffer[ 563 : 558 ];
                buffer[ 563 : 558 ] <= buffer[ 569 : 564 ];
                buffer[ 569 : 564 ] <= buffer[ 575 : 570 ];
                buffer[ 575 : 570 ] <= buffer[ 581 : 576 ];
                buffer[ 581 : 576 ] <= buffer[ 587 : 582 ];
                buffer[ 587 : 582 ] <= buffer[ 593 : 588 ];
                buffer[ 593 : 588 ] <= buffer[ 599 : 594 ];
                buffer[ 599 : 594 ] <= buffer[ 605 : 600 ];
                buffer[ 605 : 600 ] <= buffer[ 611 : 606 ];
                buffer[ 611 : 606 ] <= buffer[ 617 : 612 ];
                buffer[ 617 : 612 ] <= buffer[ 623 : 618 ];
                buffer[ 623 : 618 ] <= buffer[ 629 : 624 ];
                buffer[ 629 : 624 ] <= buffer[ 635 : 630 ];
                buffer[ 635 : 630 ] <= buffer[ 641 : 636 ];
                buffer[ 641 : 636 ] <= buffer[ 647 : 642 ];
                buffer[ 647 : 642 ] <= buffer[ 653 : 648 ];
                buffer[ 653 : 648 ] <= buffer[ 659 : 654 ];
                buffer[ 659 : 654 ] <= buffer[ 665 : 660 ];
                buffer[ 665 : 660 ] <= buffer[ 671 : 666 ];
                buffer[ 671 : 666 ] <= buffer[ 677 : 672 ];
                buffer[ 677 : 672 ] <= buffer[ 683 : 678 ];
                buffer[ 683 : 678 ] <= buffer[ 689 : 684 ];
                buffer[ 689 : 684 ] <= buffer[ 695 : 690 ];
                buffer[ 695 : 690 ] <= buffer[ 701 : 696 ];
                buffer[ 701 : 696 ] <= buffer[ 707 : 702 ];
                buffer[ 707 : 702 ] <= buffer[ 713 : 708 ];
                buffer[ 713 : 708 ] <= buffer[ 719 : 714 ];
                buffer[ 719 : 714 ] <= buffer[ 725 : 720 ];
                buffer[ 725 : 720 ] <= buffer[ 731 : 726 ];
                buffer[ 731 : 726 ] <= buffer[ 737 : 732 ];
                buffer[ 737 : 732 ] <= buffer[ 743 : 738 ];
                buffer[ 743 : 738 ] <= buffer[ 749 : 744 ];
                buffer[ 749 : 744 ] <= buffer[ 755 : 750 ];
                buffer[ 755 : 750 ] <= buffer[ 761 : 756 ];
                buffer[ 761 : 756 ] <= buffer[ 767 : 762 ];

                if(counter<P-1) begin
                    counter <= counter + 1;
                    flag <= 0;
                end else begin
                    counter <= 0;
                    flag <= 1;
                end
            end
        end
    end
    assign channel_set_LLR = buffer;
    assign buffer_ready = flag;
endmodule
