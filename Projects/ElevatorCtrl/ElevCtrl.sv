`timescale 1ns / 1ps


module ElevCtrl(
    input        clk, //clock
    input        rst, //reset
    input [3:0]  floorBtn,
    output logic [1:0] floorSel,
    output logic       door
);

enum { ONE_O, ONE_C, TWO_O, TWO_C, THREE_O, THREE_C, FOUR_O, FOUR_C} floor, nextfloor;

logic [4:0] nextsaveBtn;
logic [4:0] saveBtn;

always_ff @ (posedge clk) begin
    if(rst) begin
        floor <= ONE_O;
        saveBtn <= 4'b0000;
        end
    else begin
        floor <= nextfloor;
        saveBtn <= nextsaveBtn;;
        end
end

always_comb begin
    nextfloor = floor;
    door = 1'h1;
    floorSel = 2'h0;
    nextsaveBtn = saveBtn;
    
    case(floor) 
        ONE_O: begin
            floorSel = 2'h0;
            door = 1'h1;
            nextsaveBtn = floorBtn;
            if(nextsaveBtn > 4'b0001)
                nextfloor = ONE_C;
            else 
               nextfloor = floor;
        end
        ONE_C: begin
            floorSel = 2'h0;
            door = 1'h0;
            if(saveBtn == 4'b0001)
                nextfloor = ONE_O;
            else
                nextfloor = TWO_C;
        end
        TWO_O: begin
            floorSel = 2'h1;
            door = 1'h1;
            nextsaveBtn = floorBtn;
            if(nextsaveBtn == 4'b0010 | nextsaveBtn == 4'b0000)
                nextfloor = floor;
            else begin
                nextfloor = TWO_C;
            end
        end
        TWO_C: begin
            floorSel = 2'h1;
            door = 1'h0;
            if(saveBtn == 4'b0010)
                nextfloor = TWO_O;
            else if(saveBtn == 4'b0001)
                nextfloor = ONE_C;
            else
                nextfloor = THREE_C;
        end
        THREE_O:begin
            floorSel = 2'h2;
            nextsaveBtn = floorBtn;
            if(nextsaveBtn == 4'b0100 | nextsaveBtn == 4'b0000)
                nextfloor = floor;
            else begin
                door = 1'h0;
                nextfloor = THREE_C;
            end
         
        end
        THREE_C:begin
            floorSel = 2'h2;
            door = 1'h0;
            if(saveBtn == 4'b0100)
                nextfloor = THREE_O;
            else if(saveBtn > 4'b0100)
                nextfloor = FOUR_C;
            else
                nextfloor = TWO_C;
        
        end 
        FOUR_O: begin
            floorSel = 2'h3;
            door = 1'h1;
            nextsaveBtn = floorBtn;
            if(nextsaveBtn == 4'b1000 | nextsaveBtn == 4'b0000)
                nextfloor = floor;
            else begin
                door = 1'h0;
                nextfloor = FOUR_C;
            end
        
        end
        FOUR_C: begin
            floorSel = 2'h3;
            door = 1'h0;
            if(saveBtn == 4'b1000)
                nextfloor = FOUR_O;
            else
                nextfloor = THREE_C;

        end    
    endcase
end



endmodule 