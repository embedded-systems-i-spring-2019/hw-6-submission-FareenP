Library IEEE;
use ieee.std_logic_1164.all;

entity p13 is
port(X1,X2,clk: in std_logic;
     Y: out std_logic_vector(1 downto 0);
     Y3,Y2,Y1,CS,RD: out std_logic);
end p13;

architecture p13_ct of p13 is
type state_type is (A,B,C);
attribute ENUM_ENCODING: STRING;
attribute ENUM_ENCODING of state_type: type is "100 010 001";
signal P,N : state_type;
begin
    synchro : process(clk,N)
    begin
        if(rising_edge(clk)) then P<=N; end if;
    end process synchro;
    
    fsm_13 : process(P,X1,X2)
    begin
      Y3<='0';Y2<='0';Y1<='0';CS<='0';RD<='0';
      case P is  
        when A =>
            Y3<='0';Y2<='0';Y1<='1';
            if(x1='1') then N<=C; CS<='1';RD<='0';
            elsif(x1='0') then N<=B; CS<='0';RD<='1';
            end if;
        when B=>
            Y3<='0';Y2<='1';Y1<='0';
            N<=C; CS<='1'; RD<='1';
        when C=>
            Y3<='1';Y2<='0';Y1<='0';
            if(X2='0')then N<=A;CS<='0';RD<='0';
            elsif(X2='1') then N<=C; CS<='0'; RD<='1';
            end if;
       end case;
    end process fsm_13;
    with P select 
        Y<="001" when A,
           "010" when B,
           "100" when C;
end p13_ct;
    