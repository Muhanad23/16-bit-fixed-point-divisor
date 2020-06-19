--partial full adder "eithout carry"
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity Partial_Full_Adder is
Port ( A : in STD_LOGIC;
B : in STD_LOGIC;
Cin : in STD_LOGIC;
S : out STD_LOGIC;
P : out STD_LOGIC;
G : out STD_LOGIC);
end Partial_Full_Adder;
 
architecture Behavioral of Partial_Full_Adder is
 
begin
 
S <= A xor B xor Cin;
P <= A xor B;
G <= A and B;
 
end Behavioral;

------------------------------------------------------------
------------------------------------------------------------

--carry look ahead adder
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity Carry_Look_Ahead is
Port ( A : in STD_LOGIC_VECTOR (15 downto 0);
B : in STD_LOGIC_VECTOR (15 downto 0);
Cin : in STD_LOGIC;
S : out STD_LOGIC_VECTOR (15 downto 0));
--Cout : out STD_LOGIC);
end Carry_Look_Ahead;
 
architecture Behavioral of Carry_Look_Ahead is
 
component Partial_Full_Adder
Port ( A : in STD_LOGIC;
B : in STD_LOGIC;
Cin : in STD_LOGIC;
S : out STD_LOGIC;
P : out STD_LOGIC;
G : out STD_LOGIC);
end component;
 
signal c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15: STD_LOGIC;
signal P,G: STD_LOGIC_VECTOR(15 downto 0);
begin
 
PFA1: Partial_Full_Adder port map( A(0), B(0), Cin, S(0), P(0), G(0));
PFA2: Partial_Full_Adder port map( A(1), B(1), c1, S(1), P(1), G(1));
PFA3: Partial_Full_Adder port map( A(2), B(2), c2, S(2), P(2), G(2));
PFA4: Partial_Full_Adder port map( A(3), B(3), c3, S(3), P(3), G(3));
PFA5: Partial_Full_Adder port map( A(4), B(4), c4, S(4), P(4), G(4));
PFA6: Partial_Full_Adder port map( A(5), B(5), c5, S(5), P(5), G(5));
PFA7: Partial_Full_Adder port map( A(6), B(6), c6, S(6), P(6), G(6));
PFA8: Partial_Full_Adder port map( A(7), B(7), c7, S(7), P(7), G(7));
PFA9: Partial_Full_Adder port map( A(8), B(8), c8, S(8), P(8), G(8));
PFA10: Partial_Full_Adder port map( A(9), B(9), c9, S(9), P(9), G(9));
PFA11: Partial_Full_Adder port map( A(10), B(10), c10, S(10), P(10), G(10));
PFA12: Partial_Full_Adder port map( A(11), B(11), c11, S(11), P(11), G(11));
PFA13: Partial_Full_Adder port map( A(12), B(12), c12, S(12), P(12), G(12));
PFA14: Partial_Full_Adder port map( A(13), B(13), c13, S(13), P(13), G(13));
PFA15: Partial_Full_Adder port map( A(14), B(14), c14, S(14), P(14), G(14));
PFA16: Partial_Full_Adder port map( A(15), B(15), c15, S(15), P(15), G(15));
 
c1 <= G(0) OR (P(0) AND Cin);
c2 <= G(1) OR (P(1) AND G(0)) OR (P(1) AND P(0) AND Cin);
c3 <= G(2) OR (P(2) AND G(1)) OR (P(2) AND P(1) AND G(0)) OR (P(2) AND P(1) AND P(0) AND Cin);
c4 <= G(3) OR (P(3) AND G(2)) OR (P(3) AND P(2) AND G(1)) OR (P(3) AND P(2) AND P(1) AND G(0)) OR (P(3) AND P(2) AND P(1) AND P(0) AND Cin);
c5 <= G(4) OR (P(4) AND (G(3) OR (P(3) AND G(2)) OR (P(3) AND P(2) AND G(1)) OR (P(3) AND P(2) AND P(1) AND G(0)) OR (P(3) AND P(2) AND P(1) AND P(0) AND Cin)));
C6 <= G(5) OR (P(5) AND (G(4) OR (P(4) AND (G(3) OR (P(3) AND G(2)) OR (P(3) AND P(2) AND G(1)) OR (P(3) AND P(2) AND P(1) AND G(0)) OR (P(3) AND P(2) AND P(1) AND P(0) AND Cin)))));
C7 <= G(6) OR (P(6) AND (G(5) OR (P(5) AND (G(4) OR (P(4) AND (G(3) OR (P(3) AND G(2)) OR (P(3) AND P(2) AND G(1)) OR (P(3) AND P(2) AND P(1) AND G(0)) OR (P(3) AND P(2) AND P(1) AND P(0) AND Cin)))))));
C8 <= G(7) OR (P(7) AND (G(6) OR (P(6) AND (G(5) OR (P(5) AND (G(4) OR (P(4) AND (G(3) OR (P(3) AND G(2)) OR (P(3) AND P(2) AND G(1)) OR (P(3) AND P(2) AND P(1) AND G(0)) OR (P(3) AND P(2) AND P(1) AND P(0) AND Cin)))))))));
C9 <= G(8) OR (P(8) AND (G(7) OR (P(7) AND (G(6) OR (P(6) AND (G(5) OR (P(5) AND (G(4) OR (P(4) AND (G(3) OR (P(3) AND G(2)) OR (P(3) AND P(2) AND G(1)) OR (P(3) AND P(2) AND P(1) AND G(0)) OR (P(3) AND P(2) AND P(1) AND P(0) AND Cin)))))))))
));

C10 <= G(9) OR (P(9) AND (G(8) OR (P(8) AND (G(7) OR (P(7) AND (G(6) OR (P(6) AND (G(5) OR (P(5) AND (G(4) OR (P(4) AND (G(3) OR (P(3) AND G(2)) OR (P(3) AND P(2) AND G(1)) OR (P(3) AND P(2) AND P(1) AND G(0)) OR (P(3) AND P(2) AND P(1) AND P(0) AND Cin)))))))))
))));

C11 <= G(10) OR (P(10) AND (G(9) OR (P(9) AND (G(8) OR (P(8) AND (G(7) OR (P(7) AND (G(6) OR (P(6) AND (G(5) OR (P(5) AND (G(4) OR (P(4) AND (G(3) OR (P(3) AND G(2)) OR (P(3) AND P(2) AND G(1)) OR (P(3) AND P(2) AND P(1) AND G(0)) OR (P(3) AND P(2) AND P(1) AND P(0) AND Cin)))))))))
))))));

C12 <= G(11) OR (P(11) AND (G(10) OR (P(10) AND (G(9) OR (P(9) AND (G(8) OR (P(8) AND (G(7) OR (P(7) AND (G(6) OR (P(6) AND (G(5) OR (P(5) AND (G(4) OR (P(4) AND (G(3) OR (P(3) AND G(2)) OR (P(3) AND P(2) AND G(1)) OR (P(3) AND P(2) AND P(1) AND G(0)) OR (P(3) AND P(2) AND P(1) AND P(0) AND Cin)))))))))
))))))));

C13 <= G(12) OR (P(12) AND (G(11) OR (P(11) AND (G(10) OR (P(10) AND (G(9) OR (P(9) AND (G(8) OR (P(8) AND (G(7) OR (P(7) AND (G(6) OR (P(6) AND (G(5) OR (P(5) AND (G(4) OR (P(4) AND (G(3) OR (P(3) AND G(2)) OR (P(3) AND P(2) AND G(1)) OR (P(3) AND P(2) AND P(1) AND G(0)) OR (P(3) AND P(2) AND P(1) AND P(0) AND Cin)))))))))
))))))))));

C14 <= G(13) OR (P(13) AND (G(12) OR (P(12) AND (G(11) OR (P(11) AND (G(10) OR (P(10) AND (G(9) OR (P(9) AND (G(8) OR (P(8) AND (G(7) OR (P(7) AND (G(6) OR (P(6) AND (G(5) OR (P(5) AND (G(4) OR (P(4) AND (G(3) OR (P(3) AND G(2)) OR (P(3) AND P(2) AND G(1)) OR (P(3) AND P(2) AND P(1) AND G(0)) OR (P(3) AND P(2) AND P(1) AND P(0) AND Cin)))))))))
))))))))))));

C15 <= G(14) OR (P(14) AND (G(13) OR (P(13) AND (G(12) OR (P(12) AND (G(11) OR (P(11) AND (G(10) OR (P(10) AND (G(9) OR (P(9) AND (G(8) OR (P(8) AND (G(7) OR (P(7) AND (G(6) OR (P(6) AND (G(5) OR (P(5) AND (G(4) OR (P(4) AND (G(3) OR (P(3) AND G(2)) OR (P(3) AND P(2) AND G(1)) OR (P(3) AND P(2) AND P(1) AND G(0)) OR (P(3) AND P(2) AND P(1) AND P(0) AND Cin)))))))))
))))))))))))));


end Behavioral;

