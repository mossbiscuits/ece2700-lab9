`timescale 1ns/1ps

module tb;
    reg clk = 0;
    reg reset = 1;
    reg load = 0;
    reg serial_in = 0;

    wire unlock_fsm;
    wire [1:0] state_out;
    wire [1:0] next_state_out;

    // Create a fast clock signal to emulate your fast board clock
    always #1 clk = ~clk;

    // Instantiate your FSM device 
    // (ignoring the top module for variable name clarity)
    FsmDetect u2 (
        .clk            (clk),
        .reset          (reset),
        .load           (load),
        .serial_in      (serial_in),
        .unlock         (unlock_fsm),
        .state_out      (state_out),
        .next_state_out (next_state_out)
    );

    integer i;
    reg [15:0] pattern = 16'b0010110101010100;

    // Report the FSM's one-cycle unlock pulse.
    always @(posedge clk) begin
        if (!reset && unlock_fsm)
            $display("t=%0t FSM detected 101", $time);
    end

    // Feed in the pattern input from above, slowly to emulate user behavior
    initial begin
        #12 reset = 0;
        #2;

        for (i = 15; i >= 0; i = i - 1) begin
            serial_in = pattern[i];

            // Hold load high, then low, creating one press per input bit.
            load = 1;
            #10;
            load = 0;
            #4;

            // This works just like a printf statement in C;
            // Check the TCL console during simulation for its output.
            $display(
                "t=%0t in=%b fsm_unlock=%b state=%d next=%d",
                $time, serial_in, unlock_fsm,
                state_out, next_state_out
            );

            // Leave time for the low level to pass through the synchronizer.
            #10;
        end

        #10 $finish;
    end
endmodule
