Given a module that consumes a data bus, its job is to output the position of bit(s) that has value 1’b1. \
It should be **bubble free**, and the vld_o shall be de-asserted when job is done.

|e.g 1|||
|---|---|---|
|input: |  data = 0101 |   vld_i 1|
|ouput: |  addr = 2	|			vld_o = 1|
|next clk |addr = 0	|			vld_o = 1|
|next clk |done	|			|

|e.g 2|||
|---|---|---|
|input: |  data = 1111 |  	vld_i 1|
|ouput: |  addr = 3 |    	vld_o = 1|
|next clk| addr = 2 |    	vld_o = 1|
|next clk| addr = 1 |    	vld_o = 1|
|next clk| addr = 0 |    	vld_o = 1|
|next clk| done |    	|


