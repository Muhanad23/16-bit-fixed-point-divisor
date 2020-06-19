library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;



entity Fixed_division_tb is
generic (N : integer := 16);
end Fixed_division_tb;

architecture Behavioral of Fixed_division_tb is
signal clk: std_logic;
signal done: std_logic;
signal Err: std_logic;
signal start: std_logic;
signal overflow : std_logic;
signal Dividend : std_logic_vector(15 downto 0);   -- -10.5
signal Divisor : std_logic_vector(15 downto 0);    -- 2
Signal Result_test : std_logic_vector(15 downto 0); -- -5.25	
signal Reset : std_logic;
Signal Result : std_logic_vector(15 downto 0) ;	


begin
ttb : entity work.fixed_division  port map (Dividend,Divisor,Reset,clk,start,Result,Err,done,overflow);

-- Clock process definitions
clock_process :process
begin
     clk <= '0';
     wait for 50 ns;
     clk <= '1';
     wait for 50 ns;
end process;


-- Testbench sequence
test_bench: process
begin 
	start<='0';
	Reset<='1';
	Dividend<="0000010101000000";--     10.5/
	Divisor<= "0000000100000000";--        2=
	Result_test<="0000001010100000";--       5.25

	wait for 100 ns;
	Reset<='0';
	---case 1 positive / positive
	Dividend<="0000010101000000";--     10.5/
	Divisor<= "0000000100000000";--        2=
	Result_test<="0000001010100000";--       5.25
	start <= '1';
	wait for 100 ns;
	start <= '0';
	if (done ='1') then 
		REPORT  "Result is Wrong in case 1";
	else 		
		wait for 2200 ns;
		if(done='1' and err='0' and overflow='0')then
			ASSERT Result_test=Result REPORT  "Result is Wrong in case 1" ;
		else
			REPORT  "Result is Wrong in case 1" ;
		end if;
	end if;

	---case 2  negative / positive
	Reset<='1';
	wait for 100 ns;
	Reset<='0';
	Dividend<="1111101011000000";-- -10.5
	Divisor<= "0000000100000000";--  2
	Result_test<="1111110101100000";-- -5.25
	start <= '1';
	wait for 100 ns;
	start <= '0';
	if (done ='1') then 
		REPORT  "Result is Wrong in case 1";
	else 	
		wait for 2200 ns;
		if(done='1' and err='0' and overflow='0')then
			ASSERT Result_test = Result REPORT  "Result is Wrong in case 2" ;
		else
			REPORT  "Result is Wrong in case 2"  ;
		end if;
	end if ;	

	---case 3 positive /negative
	Reset<='1';
	wait for 100 ns;
	Reset<='0';
	Dividend<="0000010101000000"; -- 10.5
	Divisor<="1111111100000000";-- -2
	Result_test<="1111110101100000";-- -5.25
	start <= '1';
	wait for 100 ns;
	start <= '0';
	if (done ='1') then 
		REPORT  "Result is Wrong in case 1";
	else 	
		wait for 2200 ns;
		if(done='1' and err='0' and overflow='0')then
			ASSERT(Result_test = Result)
			REPORT  "Result is Wrong in case 3"  ;
		else
			REPORT  "Result is Wrong in case 3" ;
		end if;
	end if;

	---case 4 negative / negative
	Reset<='1';
	wait for 100 ns;
	Reset<='0';
	Dividend<="1111101011000000";-- -10.5
	Divisor<="1111111100000000";-- -2
	Result_test<="0000001010100000";-- 5.25
	start <= '1';
	wait for 100 ns;
	start <= '0';
	if (done ='1') then 
		REPORT  "Result is Wrong in case 1";	
	else 
		wait for 2200 ns;
		if(done='1' and err='0' and overflow='0')then
			ASSERT(Result_test = Result)
			REPORT  "Result is Wrong in case 4"  ;
		else
			REPORT  "Result is Wrong in case 4" ;
		end if;
	end if;

	---case 5 overflow test
	Reset<='1';
	wait for 100 ns;
	Reset<='0';
	Dividend<="0100000000000000"; -- 256
	Divisor<= "0000000001000000"; -- .5
	Result_test<="1111110101100000";-- 512 overflow
	start <= '1';
	wait for 100 ns;
	start <= '0';
	if (done ='1') then 
		Assert overflow='1' REPORT  "Result is Wrong in case 5 'OverFlow is not detected'";
	else	
		wait for 2200 ns;
		REPORT  "Result is Wrong in case 5 'OverFlow is not detected'" ; -- fel overflow ana el mfrod aqaren el result wla la2a
	end if;
	wait for 100 ns;

	---case 6 Error Test
	Reset<='1';
	wait for 100 ns;
	Reset<='0';
	Dividend<="1111101011000000";
	Divisor<="0000000000000000";
	Result_test<="1111110101100000";--5.25
	start <= '1';
	wait for 100 ns;
	start <= '0';
	if(done='1')then
		Assert err = '1' REPORT  "Result is Wrong in case 6 'Division by zero is not detected'" ;
	else
		wait for 2200 ns;
		REPORT  "Result is Wrong in case 6 'Division by zero is not detected'" ; 
	end if;
	wait for 100 ns;

	---case 7 Division by one
	Reset<='1';
	wait for 100 ns;
	Reset<='0';
	Dividend<="1111101011000000";
	Divisor<="0000000010000000";
	Result_test<="1111101011000000";
	start <= '1';
	wait for 100 ns;
	start <= '0';
	if(done='1')then
		Assert Result_test = Result REPORT  "Result is Wrong in case 7 'Division by one is not detected'" ;
	else
		wait for 2200 ns;
		REPORT  "Result is Wrong in case 7 'Division by one is not detected'" ;
	end if;
	wait for 100 ns;
	---case 8 Division Zero by anything
	Reset<='1';
	wait for 100 ns;
	Reset<='0';
	Dividend<="0000000000000000";
	Divisor<= "0000000010000000";
	Result_test<="0000000000000000";
	start <= '1';
	wait for 100 ns;
	start <= '0';
	if(done='1')then
		Assert Result_test = Result REPORT  "Result is Wrong in case 8 'Division zero by anything is not detected'" ;
	else
		wait for 2200 ns;
		REPORT  "Result is Wrong in case 8 'Division zero by anything is not detected'" ;
	end if;
	wait for 100 ns;
	

	
end process;

end Behavioral;
