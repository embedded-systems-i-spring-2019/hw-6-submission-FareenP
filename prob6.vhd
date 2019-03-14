library ieee;
use ieee.std_logic_1164.all;

entity p6 is
port(clk,X :in std_logic;
     Z1,Z2:out std_logic;
     y:out std_logic_vector(1 downto 0));
end p6;

architecture p6_ct of p6 is
type state_type is (s0,s1,s2,s3);
signal N,P : state_type;
begin
    syn : process(clk,N)
    begin
        if(rising_edge(clk)) then P<=N;
        end if;
    end process syn;
   
    fsm: process(X,P)
    begin
        Z1<='0';Z2<='0';
        case P is
            when s0=>
                z1<='1';
                if(x='0') then N<=s2;z2<='0';
                else N<=s0; Z2<='0';
                end if;
            when s1=>
                Z1<='0';
                if(x='0') then N<=s3;Z2<='0';
                else N<=s1; z2<='0';
                end if;
            when s2=> 
                z1<='1';
                if(x='0') then N<=S1; z2<='0';
                else n<=s2; z2<='0';
                end if;
            when s3=>
                z1<='1';
                if(x='1') then N<=S1; z2<='0';
                else N<=s0;Z2<='1';
                end if;
             when others=>
                  N<=S0;
                  Z1<='0';Z2<='0';
        end case;
        end process fsm;
      with P select
            y<="00" when S0,
                "01" when s1,
                "10" when s2,
                "11" when s3;
end p6_ct;
                
                  