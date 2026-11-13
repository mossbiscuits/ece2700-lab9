module Top (
    input  wire       clk,  // board clock
    input  wire       btnC, // reset button 
    input  wire       btnR, // load button 
    input  wire       sw,   // serial_in  
    output wire [4:0] led   // 0 output; 2:1 state; 4:3 next
);


    // Top-level function mapping port names to board device names
    // Rememer to update your constraints!
    FsmDetect u_fsm (
        .clk           (clk),
        .reset         (btnC),
        .load          (btnR),
        .serial_in     (sw),
        .unlock        (led[0]),
        .state_out     (led[2:1]),
        .next_state_out(led[4:3])
    );

endmodule
