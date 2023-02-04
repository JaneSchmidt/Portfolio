`timescale 1ns / 1ps

module SevSegDisplay(
    input   [1:0] floorSel,
    input         door, 

    output logic [6:0] segments,  
    output logic [3:0] select  
);

always_comb begin
select = 4'b1110;
segments = 7'b1000011;

if(door == 1'h0)
    segments = 7'b0100011;
else
    segments = 7'b1000011;

if(floorSel == 2'h0) 
    select = 4'b1110;
if(floorSel == 2'h1) 
    select = 4'b1101; 
if(floorSel == 2'h2) 
    select = 4'b1011;
if(floorSel == 2'h3)
    select = 4'b0111;

end

endmodule