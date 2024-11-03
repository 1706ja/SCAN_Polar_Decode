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
output [3:0] O_channel_count
);
    
    reg [P*Q-1:0] buffer;
    reg [7:0] counter;
    reg [3:0] channel_count;
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
               buffer[ 4 : 0 ] <= buffer[ 9 : 5 ];
                buffer[ 9 : 5 ] <= buffer[ 14 : 10 ];
                buffer[ 14 : 10 ] <= buffer[ 19 : 15 ];
                buffer[ 19 : 15 ] <= buffer[ 24 : 20 ];
                buffer[ 24 : 20 ] <= buffer[ 29 : 25 ];
                buffer[ 29 : 25 ] <= buffer[ 34 : 30 ];
                buffer[ 34 : 30 ] <= buffer[ 39 : 35 ];
                buffer[ 39 : 35 ] <= buffer[ 44 : 40 ];
                buffer[ 44 : 40 ] <= buffer[ 49 : 45 ];
                buffer[ 49 : 45 ] <= buffer[ 54 : 50 ];
                buffer[ 54 : 50 ] <= buffer[ 59 : 55 ];
                buffer[ 59 : 55 ] <= buffer[ 64 : 60 ];
                buffer[ 64 : 60 ] <= buffer[ 69 : 65 ];
                buffer[ 69 : 65 ] <= buffer[ 74 : 70 ];
                buffer[ 74 : 70 ] <= buffer[ 79 : 75 ];
                buffer[ 79 : 75 ] <= buffer[ 84 : 80 ];
                buffer[ 84 : 80 ] <= buffer[ 89 : 85 ];
                buffer[ 89 : 85 ] <= buffer[ 94 : 90 ];
                buffer[ 94 : 90 ] <= buffer[ 99 : 95 ];
                buffer[ 99 : 95 ] <= buffer[ 104 : 100 ];
                buffer[ 104 : 100 ] <= buffer[ 109 : 105 ];
                buffer[ 109 : 105 ] <= buffer[ 114 : 110 ];
                buffer[ 114 : 110 ] <= buffer[ 119 : 115 ];
                buffer[ 119 : 115 ] <= buffer[ 124 : 120 ];
                buffer[ 124 : 120 ] <= buffer[ 129 : 125 ];
                buffer[ 129 : 125 ] <= buffer[ 134 : 130 ];
                buffer[ 134 : 130 ] <= buffer[ 139 : 135 ];
                buffer[ 139 : 135 ] <= buffer[ 144 : 140 ];
                buffer[ 144 : 140 ] <= buffer[ 149 : 145 ];
                buffer[ 149 : 145 ] <= buffer[ 154 : 150 ];
                buffer[ 154 : 150 ] <= buffer[ 159 : 155 ];
                buffer[ 159 : 155 ] <= buffer[ 164 : 160 ];
                buffer[ 164 : 160 ] <= buffer[ 169 : 165 ];
                buffer[ 169 : 165 ] <= buffer[ 174 : 170 ];
                buffer[ 174 : 170 ] <= buffer[ 179 : 175 ];
                buffer[ 179 : 175 ] <= buffer[ 184 : 180 ];
                buffer[ 184 : 180 ] <= buffer[ 189 : 185 ];
                buffer[ 189 : 185 ] <= buffer[ 194 : 190 ];
                buffer[ 194 : 190 ] <= buffer[ 199 : 195 ];
                buffer[ 199 : 195 ] <= buffer[ 204 : 200 ];
                buffer[ 204 : 200 ] <= buffer[ 209 : 205 ];
                buffer[ 209 : 205 ] <= buffer[ 214 : 210 ];
                buffer[ 214 : 210 ] <= buffer[ 219 : 215 ];
                buffer[ 219 : 215 ] <= buffer[ 224 : 220 ];
                buffer[ 224 : 220 ] <= buffer[ 229 : 225 ];
                buffer[ 229 : 225 ] <= buffer[ 234 : 230 ];
                buffer[ 234 : 230 ] <= buffer[ 239 : 235 ];
                buffer[ 239 : 235 ] <= buffer[ 244 : 240 ];
                buffer[ 244 : 240 ] <= buffer[ 249 : 245 ];
                buffer[ 249 : 245 ] <= buffer[ 254 : 250 ];
                buffer[ 254 : 250 ] <= buffer[ 259 : 255 ];
                buffer[ 259 : 255 ] <= buffer[ 264 : 260 ];
                buffer[ 264 : 260 ] <= buffer[ 269 : 265 ];
                buffer[ 269 : 265 ] <= buffer[ 274 : 270 ];
                buffer[ 274 : 270 ] <= buffer[ 279 : 275 ];
                buffer[ 279 : 275 ] <= buffer[ 284 : 280 ];
                buffer[ 284 : 280 ] <= buffer[ 289 : 285 ];
                buffer[ 289 : 285 ] <= buffer[ 294 : 290 ];
                buffer[ 294 : 290 ] <= buffer[ 299 : 295 ];
                buffer[ 299 : 295 ] <= buffer[ 304 : 300 ];
                buffer[ 304 : 300 ] <= buffer[ 309 : 305 ];
                buffer[ 309 : 305 ] <= buffer[ 314 : 310 ];
                buffer[ 314 : 310 ] <= buffer[ 319 : 315 ];
                buffer[ 319 : 315 ] <= buffer[ 324 : 320 ];
                buffer[ 324 : 320 ] <= buffer[ 329 : 325 ];
                buffer[ 329 : 325 ] <= buffer[ 334 : 330 ];
                buffer[ 334 : 330 ] <= buffer[ 339 : 335 ];
                buffer[ 339 : 335 ] <= buffer[ 344 : 340 ];
                buffer[ 344 : 340 ] <= buffer[ 349 : 345 ];
                buffer[ 349 : 345 ] <= buffer[ 354 : 350 ];
                buffer[ 354 : 350 ] <= buffer[ 359 : 355 ];
                buffer[ 359 : 355 ] <= buffer[ 364 : 360 ];
                buffer[ 364 : 360 ] <= buffer[ 369 : 365 ];
                buffer[ 369 : 365 ] <= buffer[ 374 : 370 ];
                buffer[ 374 : 370 ] <= buffer[ 379 : 375 ];
                buffer[ 379 : 375 ] <= buffer[ 384 : 380 ];
                buffer[ 384 : 380 ] <= buffer[ 389 : 385 ];
                buffer[ 389 : 385 ] <= buffer[ 394 : 390 ];
                buffer[ 394 : 390 ] <= buffer[ 399 : 395 ];
                buffer[ 399 : 395 ] <= buffer[ 404 : 400 ];
                buffer[ 404 : 400 ] <= buffer[ 409 : 405 ];
                buffer[ 409 : 405 ] <= buffer[ 414 : 410 ];
                buffer[ 414 : 410 ] <= buffer[ 419 : 415 ];
                buffer[ 419 : 415 ] <= buffer[ 424 : 420 ];
                buffer[ 424 : 420 ] <= buffer[ 429 : 425 ];
                buffer[ 429 : 425 ] <= buffer[ 434 : 430 ];
                buffer[ 434 : 430 ] <= buffer[ 439 : 435 ];
                buffer[ 439 : 435 ] <= buffer[ 444 : 440 ];
                buffer[ 444 : 440 ] <= buffer[ 449 : 445 ];
                buffer[ 449 : 445 ] <= buffer[ 454 : 450 ];
                buffer[ 454 : 450 ] <= buffer[ 459 : 455 ];
                buffer[ 459 : 455 ] <= buffer[ 464 : 460 ];
                buffer[ 464 : 460 ] <= buffer[ 469 : 465 ];
                buffer[ 469 : 465 ] <= buffer[ 474 : 470 ];
                buffer[ 474 : 470 ] <= buffer[ 479 : 475 ];
                buffer[ 479 : 475 ] <= buffer[ 484 : 480 ];
                buffer[ 484 : 480 ] <= buffer[ 489 : 485 ];
                buffer[ 489 : 485 ] <= buffer[ 494 : 490 ];
                buffer[ 494 : 490 ] <= buffer[ 499 : 495 ];
                buffer[ 499 : 495 ] <= buffer[ 504 : 500 ];
                buffer[ 504 : 500 ] <= buffer[ 509 : 505 ];
                buffer[ 509 : 505 ] <= buffer[ 514 : 510 ];
                buffer[ 514 : 510 ] <= buffer[ 519 : 515 ];
                buffer[ 519 : 515 ] <= buffer[ 524 : 520 ];
                buffer[ 524 : 520 ] <= buffer[ 529 : 525 ];
                buffer[ 529 : 525 ] <= buffer[ 534 : 530 ];
                buffer[ 534 : 530 ] <= buffer[ 539 : 535 ];
                buffer[ 539 : 535 ] <= buffer[ 544 : 540 ];
                buffer[ 544 : 540 ] <= buffer[ 549 : 545 ];
                buffer[ 549 : 545 ] <= buffer[ 554 : 550 ];
                buffer[ 554 : 550 ] <= buffer[ 559 : 555 ];
                buffer[ 559 : 555 ] <= buffer[ 564 : 560 ];
                buffer[ 564 : 560 ] <= buffer[ 569 : 565 ];
                buffer[ 569 : 565 ] <= buffer[ 574 : 570 ];
                buffer[ 574 : 570 ] <= buffer[ 579 : 575 ];
                buffer[ 579 : 575 ] <= buffer[ 584 : 580 ];
                buffer[ 584 : 580 ] <= buffer[ 589 : 585 ];
                buffer[ 589 : 585 ] <= buffer[ 594 : 590 ];
                buffer[ 594 : 590 ] <= buffer[ 599 : 595 ];
                buffer[ 599 : 595 ] <= buffer[ 604 : 600 ];
                buffer[ 604 : 600 ] <= buffer[ 609 : 605 ];
                buffer[ 609 : 605 ] <= buffer[ 614 : 610 ];
                buffer[ 614 : 610 ] <= buffer[ 619 : 615 ];
                buffer[ 619 : 615 ] <= buffer[ 624 : 620 ];
                buffer[ 624 : 620 ] <= buffer[ 629 : 625 ];
                buffer[ 629 : 625 ] <= buffer[ 634 : 630 ];
                buffer[ 634 : 630 ] <= buffer[ 639 : 635 ];
                buffer[ 639 : 635 ] <= buffer[ 644 : 640 ];
                buffer[ 644 : 640 ] <= buffer[ 649 : 645 ];
                buffer[ 649 : 645 ] <= buffer[ 654 : 650 ];
                buffer[ 654 : 650 ] <= buffer[ 659 : 655 ];
                buffer[ 659 : 655 ] <= buffer[ 664 : 660 ];
                buffer[ 664 : 660 ] <= buffer[ 669 : 665 ];
                buffer[ 669 : 665 ] <= buffer[ 674 : 670 ];
                buffer[ 674 : 670 ] <= buffer[ 679 : 675 ];
                buffer[ 679 : 675 ] <= buffer[ 684 : 680 ];
                buffer[ 684 : 680 ] <= buffer[ 689 : 685 ];
                buffer[ 689 : 685 ] <= buffer[ 694 : 690 ];
                buffer[ 694 : 690 ] <= buffer[ 699 : 695 ];
                buffer[ 699 : 695 ] <= buffer[ 704 : 700 ];
                buffer[ 704 : 700 ] <= buffer[ 709 : 705 ];
                buffer[ 709 : 705 ] <= buffer[ 714 : 710 ];
                buffer[ 714 : 710 ] <= buffer[ 719 : 715 ];
                buffer[ 719 : 715 ] <= buffer[ 724 : 720 ];
                buffer[ 724 : 720 ] <= buffer[ 729 : 725 ];
                buffer[ 729 : 725 ] <= buffer[ 734 : 730 ];
                buffer[ 734 : 730 ] <= buffer[ 739 : 735 ];
                buffer[ 739 : 735 ] <= buffer[ 744 : 740 ];
                buffer[ 744 : 740 ] <= buffer[ 749 : 745 ];
                buffer[ 749 : 745 ] <= buffer[ 754 : 750 ];
                buffer[ 754 : 750 ] <= buffer[ 759 : 755 ];
                buffer[ 759 : 755 ] <= buffer[ 764 : 760 ];
                buffer[ 764 : 760 ] <= buffer[ 769 : 765 ];
                buffer[ 769 : 765 ] <= buffer[ 774 : 770 ];
                buffer[ 774 : 770 ] <= buffer[ 779 : 775 ];
                buffer[ 779 : 775 ] <= buffer[ 784 : 780 ];
                buffer[ 784 : 780 ] <= buffer[ 789 : 785 ];
                buffer[ 789 : 785 ] <= buffer[ 794 : 790 ];
                buffer[ 794 : 790 ] <= buffer[ 799 : 795 ];
                buffer[ 799 : 795 ] <= buffer[ 804 : 800 ];
                buffer[ 804 : 800 ] <= buffer[ 809 : 805 ];
                buffer[ 809 : 805 ] <= buffer[ 814 : 810 ];
                buffer[ 814 : 810 ] <= buffer[ 819 : 815 ];
                buffer[ 819 : 815 ] <= buffer[ 824 : 820 ];
                buffer[ 824 : 820 ] <= buffer[ 829 : 825 ];
                buffer[ 829 : 825 ] <= buffer[ 834 : 830 ];
                buffer[ 834 : 830 ] <= buffer[ 839 : 835 ];
                buffer[ 839 : 835 ] <= buffer[ 844 : 840 ];
                buffer[ 844 : 840 ] <= buffer[ 849 : 845 ];
                buffer[ 849 : 845 ] <= buffer[ 854 : 850 ];
                buffer[ 854 : 850 ] <= buffer[ 859 : 855 ];
                buffer[ 859 : 855 ] <= buffer[ 864 : 860 ];
                buffer[ 864 : 860 ] <= buffer[ 869 : 865 ];
                buffer[ 869 : 865 ] <= buffer[ 874 : 870 ];
                buffer[ 874 : 870 ] <= buffer[ 879 : 875 ];
                buffer[ 879 : 875 ] <= buffer[ 884 : 880 ];
                buffer[ 884 : 880 ] <= buffer[ 889 : 885 ];
                buffer[ 889 : 885 ] <= buffer[ 894 : 890 ];
                buffer[ 894 : 890 ] <= buffer[ 899 : 895 ];
                buffer[ 899 : 895 ] <= buffer[ 904 : 900 ];
                buffer[ 904 : 900 ] <= buffer[ 909 : 905 ];
                buffer[ 909 : 905 ] <= buffer[ 914 : 910 ];
                buffer[ 914 : 910 ] <= buffer[ 919 : 915 ];
                buffer[ 919 : 915 ] <= buffer[ 924 : 920 ];
                buffer[ 924 : 920 ] <= buffer[ 929 : 925 ];
                buffer[ 929 : 925 ] <= buffer[ 934 : 930 ];
                buffer[ 934 : 930 ] <= buffer[ 939 : 935 ];
                buffer[ 939 : 935 ] <= buffer[ 944 : 940 ];
                buffer[ 944 : 940 ] <= buffer[ 949 : 945 ];
                buffer[ 949 : 945 ] <= buffer[ 954 : 950 ];
                buffer[ 954 : 950 ] <= buffer[ 959 : 955 ];
                buffer[ 959 : 955 ] <= buffer[ 964 : 960 ];
                buffer[ 964 : 960 ] <= buffer[ 969 : 965 ];
                buffer[ 969 : 965 ] <= buffer[ 974 : 970 ];
                buffer[ 974 : 970 ] <= buffer[ 979 : 975 ];
                buffer[ 979 : 975 ] <= buffer[ 984 : 980 ];
                buffer[ 984 : 980 ] <= buffer[ 989 : 985 ];
                buffer[ 989 : 985 ] <= buffer[ 994 : 990 ];
                buffer[ 994 : 990 ] <= buffer[ 999 : 995 ];
                buffer[ 999 : 995 ] <= buffer[ 1004 : 1000 ];
                buffer[ 1004 : 1000 ] <= buffer[ 1009 : 1005 ];
                buffer[ 1009 : 1005 ] <= buffer[ 1014 : 1010 ];
                buffer[ 1014 : 1010 ] <= buffer[ 1019 : 1015 ];
                buffer[ 1019 : 1015 ] <= buffer[ 1024 : 1020 ];
                buffer[ 1024 : 1020 ] <= buffer[ 1029 : 1025 ];
                buffer[ 1029 : 1025 ] <= buffer[ 1034 : 1030 ];
                buffer[ 1034 : 1030 ] <= buffer[ 1039 : 1035 ];
                buffer[ 1039 : 1035 ] <= buffer[ 1044 : 1040 ];
                buffer[ 1044 : 1040 ] <= buffer[ 1049 : 1045 ];
                buffer[ 1049 : 1045 ] <= buffer[ 1054 : 1050 ];
                buffer[ 1054 : 1050 ] <= buffer[ 1059 : 1055 ];
                buffer[ 1059 : 1055 ] <= buffer[ 1064 : 1060 ];
                buffer[ 1064 : 1060 ] <= buffer[ 1069 : 1065 ];
                buffer[ 1069 : 1065 ] <= buffer[ 1074 : 1070 ];
                buffer[ 1074 : 1070 ] <= buffer[ 1079 : 1075 ];
                buffer[ 1079 : 1075 ] <= buffer[ 1084 : 1080 ];
                buffer[ 1084 : 1080 ] <= buffer[ 1089 : 1085 ];
                buffer[ 1089 : 1085 ] <= buffer[ 1094 : 1090 ];
                buffer[ 1094 : 1090 ] <= buffer[ 1099 : 1095 ];
                buffer[ 1099 : 1095 ] <= buffer[ 1104 : 1100 ];
                buffer[ 1104 : 1100 ] <= buffer[ 1109 : 1105 ];
                buffer[ 1109 : 1105 ] <= buffer[ 1114 : 1110 ];
                buffer[ 1114 : 1110 ] <= buffer[ 1119 : 1115 ];
                buffer[ 1119 : 1115 ] <= buffer[ 1124 : 1120 ];
                buffer[ 1124 : 1120 ] <= buffer[ 1129 : 1125 ];
                buffer[ 1129 : 1125 ] <= buffer[ 1134 : 1130 ];
                buffer[ 1134 : 1130 ] <= buffer[ 1139 : 1135 ];
                buffer[ 1139 : 1135 ] <= buffer[ 1144 : 1140 ];
                buffer[ 1144 : 1140 ] <= buffer[ 1149 : 1145 ];
                buffer[ 1149 : 1145 ] <= buffer[ 1154 : 1150 ];
                buffer[ 1154 : 1150 ] <= buffer[ 1159 : 1155 ];
                buffer[ 1159 : 1155 ] <= buffer[ 1164 : 1160 ];
                buffer[ 1164 : 1160 ] <= buffer[ 1169 : 1165 ];
                buffer[ 1169 : 1165 ] <= buffer[ 1174 : 1170 ];
                buffer[ 1174 : 1170 ] <= buffer[ 1179 : 1175 ];
                buffer[ 1179 : 1175 ] <= buffer[ 1184 : 1180 ];
                buffer[ 1184 : 1180 ] <= buffer[ 1189 : 1185 ];
                buffer[ 1189 : 1185 ] <= buffer[ 1194 : 1190 ];
                buffer[ 1194 : 1190 ] <= buffer[ 1199 : 1195 ];
                buffer[ 1199 : 1195 ] <= buffer[ 1204 : 1200 ];
                buffer[ 1204 : 1200 ] <= buffer[ 1209 : 1205 ];
                buffer[ 1209 : 1205 ] <= buffer[ 1214 : 1210 ];
                buffer[ 1214 : 1210 ] <= buffer[ 1219 : 1215 ];
                buffer[ 1219 : 1215 ] <= buffer[ 1224 : 1220 ];
                buffer[ 1224 : 1220 ] <= buffer[ 1229 : 1225 ];
                buffer[ 1229 : 1225 ] <= buffer[ 1234 : 1230 ];
                buffer[ 1234 : 1230 ] <= buffer[ 1239 : 1235 ];
                buffer[ 1239 : 1235 ] <= buffer[ 1244 : 1240 ];
                buffer[ 1244 : 1240 ] <= buffer[ 1249 : 1245 ];
                buffer[ 1249 : 1245 ] <= buffer[ 1254 : 1250 ];
                buffer[ 1254 : 1250 ] <= buffer[ 1259 : 1255 ];
                buffer[ 1259 : 1255 ] <= buffer[ 1264 : 1260 ];
                buffer[ 1264 : 1260 ] <= buffer[ 1269 : 1265 ];
                buffer[ 1269 : 1265 ] <= buffer[ 1274 : 1270 ];
                buffer[ 1274 : 1270 ] <= buffer[ 1279 : 1275 ];

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
