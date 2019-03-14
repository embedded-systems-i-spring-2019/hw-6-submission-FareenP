Library IEEE;
use ieee.std_logic_1164.all;

entity p2 is
port(X1,X2,clk: in std_logic;
     Y: out std_logic_vector(1 downto 0);
     Y1,Y0,Z: out std_logic);
end p2;

architecture p2_crt of p2 is
type state_type is (A,B,C);
signal N,P : state_type;
begin
    sync:process(clk,N)
    begin
        if(rising_edge(clk)) then
            P<=N;
        end if;
     end process sync;
     fsm:process(P,X1,X2)
     begin
        Z<='0';Y1<='1';Y0<='0';
        case P is
            when A=>
            Y1<='1';Y0<='0';
                if(x1='1') then N<=C;Z<='0';
                elsif(x1='0') then N<=A;Z<='0';
                else N<=A; Z<='0';
                end if;
            when B=> 
            Y1<='1';Y0<='1';
                if(X2='0') then N<=A; Z<='1';
                else N<=B;Z<='0';
                end if;
            when C=>
                Y1<='0';Y0<='1';
                if(X2='1') then  N<=B;Z<='0';
                elsif(X2='0') then  N<=A;Z<='1';
                end if;
            when others=>
                Y1<='0';
                y0<='0';
                N<=A;
            end case;
          end process fsm;
          
          with P select
          Y<="10" when A,
             "01" when C,
             "11" when B;
 end p2_crt;
         
            
            
            
            
            
            
            
            
            
            
     
     