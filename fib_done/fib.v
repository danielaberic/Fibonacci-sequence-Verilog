`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////

// Company: 

// Engineer: 

// 

// Create Date:    12:02:03 05/12/2022 

// Design Name: 

// Module Name:    fibonacci 

// Project Name: 

// Target Devices: 

// Tool versions: 

// Description: 

//

// Dependencies: 

//

// Revision: 

// Revision 0.01 - File Created

// Additional Comments: 

//

//////////////////////////////////////////////////////////////////////////////////

 module fib

(

   input wire clk, reset,sljedeci,preskok,

	input wire start,sw_debouncan,

   input wire [7:0] i,

  // output reg ready, done_tick,

   output wire  f0,f1,f2,f3,f4,f5,f6,f7

); 

// symbolic state declaration

 localparam [1:0]

   idle = 2'b00,

   op =2'b01,

   done = 2'b10;

// signal declaration

  reg [1:0] state_reg , state_next;

  reg [63:0] t0_reg, t0_next, t1_reg, t1_next;

  reg [6:0] n_reg , n_next;

  reg [63:0] brojac_reg,brojac_next;  

  reg [3:0] brojac_izlaz =4;
  //reg [7:0] reg1, reg2, reg3, reg4,reg5;
  reg ready, done_tick;
  reg [7:0] ledice;


// bod,

// FSMD state & data registers

 always @(posedge clk, posedge reset )
 begin

   if (reset)

     begin

         state_reg<=idle;

         t0_reg <= 0;

         t1_reg <= 0;

			brojac_reg<=0;

         n_reg <= 0;

     end

   else

     begin		  

         state_reg <= state_next ;

         t0_reg <= t0_next;

         t1_reg <= t1_next;

			brojac_reg<=brojac_next;

         n_reg <= n_next;

     end

	 end
	

// FSMD next-state logic

 always @(*)

    begin

         state_next = state_reg;

         ready = 1'b0;

			brojac_next=brojac_reg;

         done_tick = 1'b0;

         t0_next = t0_reg;

         t1_next = t1_reg;

         n_next = n_reg;

			

   case (state_reg)

  idle:

    begin

        ready = 1'b1;

   if (start)

		begin

			t0_next = 0;

			t1_next = 20'd1;

			brojac_next=0;

			n_next = i;

			state_next = op;

    end

	 if(preskok)

	 begin

	 t0_next = t0_reg;

			t1_next = t1_reg;

			brojac_next=0;

			n_next = i+1;

			state_next = op;

	 end
	 
	  if(sljedeci)

	 begin

			t0_next = t0_reg;

			t1_next = t1_reg;

			n_next = 2;

			state_next = op;
			
			brojac_next=0;
	 end
	 
  end
 

  op :

	if (n_reg==0)

		begin

			t1_next = 0;

			state_next = done;

		end

	else if (n_reg==1)

			state_next = done;

	else

		begin

			t1_next = t1_reg + t0_reg;

			t0_next = t1_reg;

			n_next = n_reg-1;

		end



	done :

		begin

			if(brojac_reg<1000000000)

			begin

			done_tick=1'b1;

			brojac_next=brojac_reg+1;

			state_next=done;

			end

			else

			begin

			state_next=idle;

			end

		end		

		default : state_next = idle ;

	endcase

 end

// output

always @(posedge clk)
begin
		ledice <= t1_reg[brojac_izlaz*8+7 -:8];

end

always@(posedge sw_debouncan) begin
	if(reset)
		brojac_izlaz <= 4;
	else begin
	if(sw_debouncan)
		begin
			if(brojac_izlaz==0)
				brojac_izlaz <= 4;
			else
				brojac_izlaz <= brojac_izlaz-1;
		end
	end
end

assign f0 = ledice[0];
assign f1 = ledice[1];
assign f2 = ledice[2];
assign f3 = ledice[3];
assign f4 = ledice[4];
assign f5 = ledice[5];
assign f6 = ledice[6];
assign f7 = ledice[7];


/*always @(posedge clk)
	begin
		case(brojac_izlaz)
				1:begin
						f0<=reg1[0];
						f1<=reg1[1];
						f2<=reg1[2];
						f3<=reg1[3];
						f4<=reg1[4];
						f5<=reg1[5];
						f6<=reg1[6];
						f7<=reg1[7];
					end
				2: begin
						f0<=reg2[0];
						f1<=reg2[1];
						f2<=reg2[2];
						f3<=reg2[3];
						f4<=reg2[4];
						f5<=reg2[5];
						f6<=reg2[6];
						f7<=reg2[7];
						brojac_izlaz=brojac_izlaz-1;
					end
				3: begin
						f0<=reg3[0];
						f1<=reg3[1];
						f2<=reg3[2];
						f3<=reg3[3];
						f4<=reg3[4];
						f5<=reg3[5];
						f6<=reg3[6];
						f7<=reg3[7];
						brojac_izlaz=brojac_izlaz-1;
					end
				4: begin
						f0<=reg4[0];
						f1<=reg4[1];
						f2<=reg4[2];
						f3<=reg4[3];
						f4<=reg4[4];
						f5<=reg4[5];
						f6<=reg4[6];
						f7<=reg4[7];
						brojac_izlaz=brojac_izlaz-1;
					end
				5: begin
						f0<=reg5[0];
						f1<=reg5[1];
						f2<=reg5[2];
						f3<=reg5[3];
						f4<=reg5[4];
						f5<=reg5[5];
						f6<=reg5[6];
						f7<=reg5[7];
						brojac_izlaz=brojac_izlaz-1;
					end
			endcase
		
		
	end*/

endmodule