Library IEEE;
use ieee.std_logic_1164.all;

entity p4 is
port(X1,X2,INIT,clk : in std_logic;
     Z1,Z2: out std_logic;
     Y :out std_logic_vector( 1 downto 0));
end p4;

architecture p4_crt of p4 is
type state_type is (A,B,C);
signal P,N : state_type;
begin
    sync: process(clk,init,N)
    begin
         if(INIT='1') then
            P<=A;
         elsif(rising_edge(clk)) then
            P<=N;
         end if;
   end process sync;
   
   fsm : process(P,X1,X2)
   begin
    Z1<='0';
        Z2<='0';
    case P is
        when A =>
        Z1<='0'; 
            if(X1='1') then 
                N<=B;
                Z2<='1';
            elsif(X1='0') then 
                N<=C; 
                Z2<='0';
           -- else 
            --    N<=A; 
             --   Z2<='0';
            end if;
         when B=> 
         Z1<='1';
            if(X2='0') then N<=C; Z2<='1';
            elsif(X2='1') then N<=A;Z2<='0';
            --else N<=B; Z2<='0';
            end if;
         When C=>
            Z1<='1';
            if(X1='1')then N<=B; Z2<='1';
            elsif(X1='0') then N<=A; Z2<='1';
          --  else N<=C; Z2<='0';
            end if;
         when others=>
            Z1<='0';
            Z2<='0';
            N<=A;
         end case;
      end process fsm;
   with  P select
        Y<="00" when A,
           "01" when B,
           "10" when C,
           "00" when others;
 end p4_crt;
        