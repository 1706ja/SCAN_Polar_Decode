SCAN (Soft Cancellation) Decoder For Polar Codes (Hardware Implementation via verilog)

## Architecture:
SCAN decoder consists of a storage module, processing elements, and a control module. For detailed analysis, please refer to [1].
1. Storage: For storage of processing LLRs, it consists of the files: frozen_rom.v, ram_a.v, ram_b.v, ram_b1.v, ram_btop.v, w_address.v, r_address.v, and storage.v. 
2. Processing elements: This module is illustrated in PE.v, PE_cal.v, PE_bottom.v, f1_array.v, f2_array.v, f1.v, f2.v, minsum.v, and saturated_adder.v.
3. Control module: Quite tricky. As a control module for both r-w control and algorithmic unit, implementing a finite-state machine is the correct choice. Consisting of opcode.v and control.v.


## Unfortunately, Some Shortcomings:
1. Seperate design of saturated adder and comparator. There remains logic redundancy.


## References

1. Guillaume Berhault, Camille Leroux, Christophe Jego, and Dominique Dallet. 2015. Hardware implementation of a soft cancellation decoder for polar codes. In 2015 Conference on Design and Architectures for Signal and Image Processing (DASIP), pages 1–8. DOI:[10.1109/DASIP.2015.7367252](https://doi.org/10.1109/DASIP.2015.7367252)
