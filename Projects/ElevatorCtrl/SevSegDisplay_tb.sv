`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jane Schmidt, Jivitesh Yadav
// 
// Create Date: 03/06/2021 03:00:39 PM
// Design Name: 
// Module Name: ElevCtrl_tb
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
// This is a test bench for the seven segment display. In this test bench we 
// move the elevator to each floor and test that the seven segment display is
// creating the correct display at both an open and closed state.
//
//////////////////////////////////////////////////////////////////////////////////


module SevSegDisplay_tb;
    logic [1:0] floorSel;
    logic door;
    wire [6:0] segments;  
    wire [3:0] select;
    
    
    SevSegDisplay seg (
        .floorSel,
        .door,
        .segments,
        .select
        );
    
    task testseg;
        input [3:0] selectT;
        input [6:0] segmentsT; 
        
        #5
        assert((select == selectT) && ( segments == segmentsT ))
            else $fatal(1,"SevSeg(%b, %b) failed!", select, segments);
    endtask
    
    initial 
    begin
    
        $monitor("floorSel:%h, door:%b, select:%b, segments:%b", floorSel, door, select, segments);
    
        $display("floor one");
        floorSel = 2'h0;
        door = 1'h1;
        testseg(4'b1110, 7'b1000011);
        #10
        floorSel = 2'h0;
        door = 1'h0;
        testseg(4'b1110, 7'b0100011);
    
        $display("floor two");
        floorSel = 2'h1;
        door = 1'h1;
        testseg(4'b1101, 7'b1000011);
        #10
        floorSel = 2'h1;
        door = 1'h0;
        testseg(4'b1101, 7'b0100011);
    
        $display("floor three");
        floorSel = 2'h2;
        door = 1'h1;
        testseg(4'b1011, 7'b1000011);
        #10
        floorSel = 2'h2;
        door = 1'h0;
        testseg(4'b1011, 7'b0100011);
    
        $display("floor four");
        floorSel = 2'h3;
        door = 1'h1;
        testseg(4'b0111, 7'b1000011);
        #10
        floorSel = 2'h3;
        door = 1'h0;
        testseg(4'b0111, 7'b0100011);
    
        $display("@@@Passed\n");
        $finish;
        
    end
endmodule
