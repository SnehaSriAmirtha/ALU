module ALU4_signed_unsigned (
input [3:0] A_signed, B_signed,
input [3:0] A_unsigned, B_unsigned,
input [2:0] Op,
output reg [3:0] Result_unsigned,
output reg Zero, Carry, Overflow,
output reg[3:0] Result_signed,
);
reg [4:0] temp;
reg [4:0] temp1;
always @(*) begin
Carry = 1'b0;
Overflow = 1'b0;
Result_unsigned = 1'b0;
Result_signed = 1'b0;
case (Op)
3'b000: begin // ADD
temp = A_unsigned + B_unsigned;
Result = temp[3:0];
Carry = temp[4];
Overflow = (A_signed[3] == B_signed[3]) && (temp[4] != A_signed[3]);
end
3'b001: begin // SUB
temp = A_unsigned - B_unsigned;
Result_unsigned = temp[3:0];
Carry = ~temp[4];
temp1 = A_signed - B_signed;
Result_signed = temp1[3:0];
Overflow = (A_signed[3] != B_signed[3]) && (temp[4] != A_signed[3]);
end
3'b010: begin
Result_unsigned = A_unsigned & B_unsigned; // AND
Result_signed = A_signed & B_signed; // AND
end
3'b011: begin
Result_unsigned = A_unsigned | B_unsigned; // OR
Result_signed = A_unsigned | B_unsigned; // OR
end
3'b100: begin
Result_unsigned = A_unsigned ^ B_unsigned; // XOR
Result_signed = A_unsigned ^ B_unsigned;
end
3'b101: begin
Result = ~A_unsigned; // NOT A
Result = ~A_signed;
end
3'b110: begin // Shift Left
Result = A_unsigned << 1;
Carry = A_unsigned[3];
end
3'b111: begin // Shift Right
Result = A_unsigned >> 1;
Carry = A_unsigned[0];
end
default: Result = 4'b0000;
endcase
Zero = (Result == 4'b0000);
end
endmodule
