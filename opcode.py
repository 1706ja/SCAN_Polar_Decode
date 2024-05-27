import numpy as np
N = 256
n = int(np.log2(N))
P = 8
p = int(np.log2(P))
k = int(((2*N)/P)*(n-p-2+P) - N/(2*P)*(n-1-p))
x = np.zeros(5*k)
y = np.zeros(5*k)
z = np.zeros(5*k)
aa = np.zeros(n+1)
aa2 = np.zeros(n+1)
aa3 = 0
aa1 = np.zeros(5*k)
k2 = int(0)
cnt = np.zeros(5*k)
def SCAN_decode(j, N, P, k2):

    if j == 0:
        k2 =  k2 + 1
        # print(2,'Bottom',k2)
        x[k2-1] = 2
        y[k2-1] = 4
        z[k2-1] = 0
        return k2

    node = 1 << j

    # aa[int(j-1)] += 1
    # aa1[k2] = aa[int(j)]
    for i in range(int(np.ceil(node / P))):

        if(node>2):
            k2 =  k2 + 1
            # print(node,'Type1',k2)
        # else:
        #     k2 = k2 + 1
        #     print(2, 'Bottom', k2)
            x[k2 - 1] = node
            y[k2 - 1] = 1
            z[k2 - 1] = i
            kk = int(np.log2(node))
            # aa1[k2 - 1] = aa[int(kk-1)]
    k2 = SCAN_decode(j - 1, N,P,k2)
    # polar.BP_function2(LLR_L[j - 1][start + length:], LLR_L[j][start:], LLR_R[j - 1][start:], LLR_L[j][start + length:],
    #                    length)
    for i in range(int(np.ceil(2*node / P))):
        if(2*node<=N):
            k2 =  k2 + 1
            # print(2*node, 'Type2', k2)
            x[k2 - 1] = 2*node
            y[k2 - 1] = 2
            z[k2-1] = i
    if (2 * node >= 8):
        for i in range(int(np.ceil(node / P))):
            k2 = k2 + 1
            # print(node, 'Type1', k2)
            x[k2 - 1] = node
            y[k2 - 1] = 1
            z[k2-1] = i
    k2 = SCAN_decode(j - 1, N,P,k2)
    if (j!=np.log2(N)):
        # polar.BP_function(LLR_R[j][start:], LLR_R[j - 1][start:], LLR_R[j - 1][start + length:],
        #                   LLR_L[j][start + length:],
        #                   length)
        # polar.BP_function2(LLR_R[j][start + length:], LLR_R[j - 1][start:], LLR_L[j][start:],
        #                    LLR_R[j - 1][start + length:],
        #                    length)
        for i in range(int(np.ceil(2*node / P))):
            if(4*node<=N):
                k2 = k2 + 1
                # print(4*node,'Type3',k2)

                x[k2 - 1] = 2*node
                y[k2 - 1] = 3
                z[k2 - 1] = i
    return k2
SCAN_decode(n,N,2*P,k2)




for i in range(1,k):
    # aa[n] = 1
    # aa1[0] = 1
    if(y[i]==1):
        jj = int(np.log2(x[i]))
        if(x[i]!=x[i-1]):
            aa[jj] += 1
        aa1[i] = aa[jj]
    elif(y[i]==3):
        jj = int(np.log2(x[i]))
        if(x[i]!=x[i-1]):
            aa2[jj] += 1
        aa1[i] = aa2[jj]
    elif(y[i]==4):
        aa3 += 1
        aa1[i] = aa3
for i in range(k):
    if(aa1[i]>0): aa1[i]-=1

# for i in range(k):
#     if((y[i]==3) or (y[i]==4)):
#         if((aa1[i]//2)*2 == aa1[i]):
#             aa1[i] = -1
#         else:
#             aa1[i] = (aa1[i]-1)/2
#     if(y[i]==2):
#         aa1[i] = -1

# print(y)
# print(x)
# print(aa)
# print(aa1)
# print(aa2)
def praa2(aa):
    for i in range(k):
        # if (aa[i] != -1):
        #     print('       ', i,': Address<=',int(aa[i]),';')
        # if ((y[i]==3)|(y[i]==1)):
        if (aa[i]!=0) :
            print('       ',320+i-3, ': Address2_next<=', int(aa[i]), ';')
def prx(x):
    for i in range(k):
        print('       ',i,': L_Nv<=',int(x[i]),';')
def pry(y):
    for i in range(k):
        if(y[i]==1):
            print('      ', i,':L_opcode <= TYPE1;')
        elif(y[i]==2):
            print('       ',  i, ':L_opcode <= TYPE2;')
        elif(y[i]==3):
            print('       ',i, ':L_opcode <= TYPE3;')
        else: print('       ',    i,':L_opcode <= BOTTOM;')
def prz(z):
    for i in range(k):
        if(z[i]!=0):
            print('       ',  i,': L_part_count <=',int(z[i]),';')


def praa(aa,y):
    for i in range(k):
        if ((y[i]==3)|(y[i]==4)):
            if ((aa[i]%2)==1):
                x = (aa[i]-1)/2
                print('       ', i-1, ': Address<=', int(x), ';')
def prx2(x):
    for i in range(k):
        print( '        ', i-2,': L_Nv_next<=',int(x[i]),';')
def pry2(y):
    for i in range(k):
        if(y[i]==1):
            print( '        ',  i-2,':L_opcode_next <= TYPE1;')
        elif(y[i]==2):
            print( '        ', i-2, ':L_opcode_next <= TYPE2;')
        elif(y[i]==3):
            print( '        ', i-2, ':L_opcode_next <= TYPE3;')
        else: print( '      ',   i-2,':L_opcode_next <= BOTTOM;')
def prz2(z):
    for i in range(k):
        if(z[i]!=0):
            print( '        ', i-2,': L_part_count_next <=',int(z[i]),';')
#
# print('''module opcode(clk, rst, I_program_counter,O_opcode, O_opcode_next, O_opcode_delay
#         O_Nv,O_Nv_next, O_part_count,O_part_count_next, O_address, O_address_next, O_opcode_before, O_Nv_before, O_part_count_before, O_address_before);
#         input clk,rst;
#         input [15:0] I_program_counter;
#         output [3:0] O_opcode,O_opcode_next, O_opcode_before, O_opcode_delay;
#         output [10:0] O_Nv, O_Nv_next, O_Nv_before;
#         output [5:0] O_part_count, O_part_count_next, O_part_count_before;
#         output [10:0] O_address, O_address_next, O_address_before;
#         localparam TYPE1     = 4'b0000;
#         localparam TYPE2     = 4'b0001;
#         localparam BOTTOM    = 4'b0010;
#         localparam TYPE3     = 4'b0011;
#         localparam IDLE      = 4'b1011;
#
#         reg [3:0] L_opcode, L_opcode_next, L_opcode_before, L_opcode_delay;
#         reg [10:0] L_Nv,L_Nv_next,L_Nv_before;
#         reg [3:0] L_part_count, L_part_count_next,L_part_count_before;
#         reg [10:0] Address, Address_next, Address_before;
#
#         // assignment of outputs
#         assign O_opcode = L_opcode;
#         assign O_opcode = L_opcode_delay;
#         assign O_opcode_next = L_opcode_next;
#         assign O_opcode_before = L_opcode_before;
#         assign O_Nv = L_Nv;
#         assign O_Nv_next = L_Nv_next;
#         assign O_Nv_before = L_Nv_before;
#         assign O_part_count = L_part_count;
#         assign O_part_count_next = L_part_count_next;
#         assign O_part_count_before = L_part_count_before;
#         assign O_address = Address;
#         assign O_address_before = Address_before;
#         assign O_address_next = Address_next;
#
#
#        always @(posedge clk)
#      begin
#            if(!rst) begin
#                 L_Nv_before <= L_Nv;
#                 L_opcode_before <= L_opcode;
#                 L_opcode_delay <= L_opcode_next;
#                 L_part_count_before <= L_part_count;
#                 Address_before <= Address;
#             end
#         end
#
#
#         always @(*) begin
#                  if(rst) begin
#             L_Nv                          <=1024;
#             L_Nv_next                     <=1024;;
#             L_opcode                      <=TYPE1;
#             L_opcode_next <= TYPE1;
#             L_part_count <= 0;
#             L_part_count_next <= 0;
#             Address <= 0;
#             Address_next <= 0;
#             end
#             else begin
#               case(I_program_counter)''')
# prx(x)
# print('       endcase')
# print('       case(I_program_counter)')
# pry(y)
# print('       endcase')
# print('       case(I_program_counter)')
# prz(z)
# print('       endcase')
# print('       case(I_program_counter)')
# praa(aa1,y)
# print('       endcase')
# print('       case(I_program_counter)')
# prx2(x)
# print('       endcase')
# print('       case(I_program_counter)')
# pry2(y)
# print('       endcase')
# print('       case(I_program_counter)')
# prz2(z)
# print('       endcase')
print('       case(I_program_counter)')
praa2(aa1)
print('       endcase')
# print('end')
# print('end')
# print('endmodule')
