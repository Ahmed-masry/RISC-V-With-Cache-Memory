module AND (
    input Zero,Branch,jump,
    output PCsrc
);
wire out;
    assign out=Zero& Branch;
    assign PCsrc = out | jump;
endmodule   