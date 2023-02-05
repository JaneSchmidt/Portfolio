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
// This is a test bench for the elevator controller state machine. In this test bench we 
// move the elevator to each floor and test the variables on the negative edge of the clock
// to make sure our process is setting the variables to the expected values.
//
//////////////////////////////////////////////////////////////////////////////////


module ElevCtrl_tb;
    logic clk, rst;
    logic [3:0] floorBtn;
    wire [1:0]floorSel;
    wire door;
    
    ElevCtrl elev (
        .clk,
        .rst,
        .floorBtn,
        .floorSel,
        .door
        );
    
    task testelev;
        input [1:0]floorSelT; 
        input doorT;
        
        #5
        assert(( floorSel == floorSelT ) && (door == doorT))
            else $fatal(1,"ElevC(%h, %b) failed!", floorSel, door);
    endtask
    
    always #5 clk = ~clk;
    
    initial 
    begin 
        clk = 0;
        rst = 1; 
        floorBtn = 4'b0000;

        #10
        
        $monitor("clk:%b, rst=%b, floorBtn: %b, floorSel:%h, door:%b", clk, rst, floorBtn, floorSel, door);
        
        
        $display("one to two ");
        rst = 0;
        floorBtn = 4'b0010;
        testelev(2'h0, 1'h1);
        @(negedge clk);
        testelev(2'h0, 1'h0);
        @(negedge clk);
        testelev(2'h1, 1'h0);
        @(negedge clk);
        testelev(2'h1, 1'h1); 
        
        $display("stay at two ");
        rst = 0;
        floorBtn = 4'b0010;
        testelev(2'h1, 1'h1);
        @(negedge clk);
        testelev(2'h1, 1'h1);
        
        $display("stay at two ");
        rst = 0;
        floorBtn = 4'b0000;
        testelev(2'h1, 1'h1);
        @(negedge clk);
        testelev(2'h1, 1'h1);
        
        $display("two to four");
        rst = 0;
        floorBtn = 4'b1000;
        testelev(2'h1, 1'h1);
        @(negedge clk);
        testelev(2'h1, 1'h0);
        @(negedge clk);
        testelev(2'h2, 1'h0); 
        @(negedge clk);
        testelev(2'h3, 1'h0);
        @(negedge clk);
        testelev(2'h3, 1'h1);
        
        $display("four to two ");
        rst = 0;
        floorBtn = 4'b0010;
        testelev(2'h3, 1'h1);
        @(negedge clk);
        testelev(2'h3, 1'h0);
        @(negedge clk);
        testelev(2'h2, 1'h0);
        @(negedge clk);
        testelev(2'h1, 1'h0);
        @(negedge clk);
        testelev(2'h1, 1'h1); 
        
        $display("two to three ");
        rst = 0;
        floorBtn = 4'b0100;
        testelev(2'h1, 1'h1);
        @(negedge clk);
        testelev(2'h1, 1'h0);
        @(negedge clk);
        testelev(2'h2, 1'h0);
        @(negedge clk);
        testelev(2'h2, 1'h1);  
        
        $display("three to two");
        rst = 0;
        floorBtn = 4'b0010;
        testelev(2'h2, 1'h1);
        @(negedge clk);
        testelev(2'h2, 1'h0);
        @(negedge clk);
        testelev(2'h1, 1'h0);
        @(negedge clk);
        testelev(2'h1, 1'h1); 
        
        $display("two to one ");
        rst = 0;
        floorBtn = 4'b0001;
        testelev(2'h1, 1'h1);
        @(negedge clk);
        testelev(2'h1, 1'h0);
        @(negedge clk);
        testelev(2'h0, 1'h0);
        @(negedge clk);
        testelev(2'h0, 1'h1); 
        
        $display("stay at one ");
        rst = 0;
        floorBtn = 4'b0001;
        testelev(2'h0, 1'h1);
        @(negedge clk);
        testelev(2'h0, 1'h1);
        
        $display("stay at one ");
        rst = 0;
        floorBtn = 4'b0000;
        testelev(2'h0, 1'h1);
        @(negedge clk);
        testelev(2'h0, 1'h1);
        
        $display("one to three");
        rst = 0;
        floorBtn = 4'b0100;
        testelev(2'h0, 1'h1);
        @(negedge clk);
        testelev(2'h0, 1'h0);
        @(negedge clk);
        testelev(2'h1, 1'h0);
        @(negedge clk);
        testelev(2'h2, 1'h0); 
        @(negedge clk);
        testelev(2'h2, 1'h1);
        
        $display("stay at three ");
        rst = 0;
        floorBtn = 4'b0100;
        testelev(2'h2, 1'h1);
        @(negedge clk);
        testelev(2'h2, 1'h1);
        
        $display("stay at three ");
        rst = 0;
        floorBtn = 4'b0000;
        testelev(2'h2, 1'h1);
        @(negedge clk);
        testelev(2'h2, 1'h1);
        
        $display("three to one");
        rst = 0;
        floorBtn = 4'b0001;
        testelev(2'h2, 1'h1);
        @(negedge clk)
        testelev(2'h2, 1'h0);
        @(negedge clk)
        testelev(2'h1, 1'h0);
        @(negedge clk)
        testelev(2'h0, 1'h0);
        @(negedge clk)
        testelev(2'h0, 1'h1);
        
        $display("one to four");
        rst = 0;
        floorBtn = 4'b1000;
        testelev(2'h0, 1'h1);
        @(negedge clk);
        testelev(2'h0, 1'h0);
        @(negedge clk);
        testelev(2'h1, 1'h0);
        @(negedge clk);
        testelev(2'h2, 1'h0);
        @(negedge clk);
        testelev(2'h3, 1'h0);
        @(negedge clk);
        testelev(2'h3, 1'h1); 
        
        $display("four to three ");
        rst = 0;
        floorBtn = 4'b0100;
        testelev(2'h3, 1'h1);
        @(negedge clk);
        testelev(2'h3, 1'h0);
        @(negedge clk);
        testelev(2'h2, 1'h0);
        @(negedge clk);
        testelev(2'h2, 1'h1); 
        
        $display("three to four ");
        rst = 0;
        floorBtn = 4'b1000;
        testelev(2'h2, 1'h1);
        @(negedge clk);
        testelev(2'h2, 1'h0);
        @(negedge clk);
        testelev(2'h3, 1'h0);
        @(negedge clk);
        testelev(2'h3, 1'h1);
        
        $display("stay at four ");
        rst = 0;
        floorBtn = 4'b1000;
        testelev(2'h3, 1'h1);
        @(negedge clk);
        testelev(2'h3, 1'h1);
        
        $display("stay at four ");
        rst = 0;
        floorBtn = 4'b0000;
        testelev(2'h3, 1'h1);
        @(negedge clk);
        testelev(2'h3, 1'h1);
        
        $display("four to one");
        rst = 0;
        floorBtn = 4'b0001;
        testelev(2'h3, 1'h1);
        @(negedge clk);
        testelev(2'h3, 1'h0);
        @(negedge clk);
        testelev(2'h2, 1'h0);
        @(negedge clk);
        testelev(2'h1, 1'h0);
        @(negedge clk);
        testelev(2'h0, 1'h0);
        @(negedge clk);
        testelev(2'h0, 1'h1);
        
        $display("@@@Passed\n");
        $finish;
        
    end
endmodule
