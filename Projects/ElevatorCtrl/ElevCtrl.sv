`timescale 1ns / 1ps

// module used to declare the variables used for the inputs and outputs of the elevator
module ElevCtrl(
    input        clk, //clock
    input        rst, //reset
    input [3:0]  floorBtn,
    output logic [1:0] floorSel,
    output logic       door
);

    
// defining a set of values for the state of the door at each floor (open or closed) 
enum { ONE_O, ONE_C, TWO_O, TWO_C, THREE_O, THREE_C, FOUR_O, FOUR_C} floor, nextfloor;

logic [4:0] nextsaveBtn;
logic [4:0] saveBtn;

    
// this process is triggered at every positive edge of the clock
// if the reset button has been pressed then the elevator is put back on the first floor
// otherwise the elevator moves to the floor requested by the push buttons
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

    
// process automatically executed at time zero 
// starting the elevator at floor one with the door open
always_comb begin
    nextfloor = floor;
    door = 1'h1;
    floorSel = 2'h0;
    nextsaveBtn = saveBtn;
    
    // case statement used to switch between states
    case(floor) 
        
        // at each open open state (where the door is open) the next saved button is checked
        // if the button is the current floor do nothing otherwise send the elevator to the closed state of the same floor 
        ONE_O: begin
            floorSel = 2'h0;
            door = 1'h1;
            nextsaveBtn = floorBtn;
            if(nextsaveBtn > 4'b0001)
                nextfloor = ONE_C;
            else 
               nextfloor = floor;
        end
        
        // at each closed state the save button is checked
        // if the save button is for the current floor the elevator is sent to the open state of that floor
        // otherwise it is either sent to the closed state of the floor below or above
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
