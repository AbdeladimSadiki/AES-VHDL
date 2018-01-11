----------------------------------------------------------------------------------
-- National Institute of Posts and Telecommunications: 
-- student Engineer: Abdeladim SADIKI
-- 
-- Create Date:    21:47 09/01/2018 
-- Module Name:    AES - Behavioral 
-- Project Name:   AES Algorithm
-- Description:    A VHDL implementation of The AES algorithm

-- Revision:       1.0
-- Additional Comments: In collaboration with Mohamed ZELMAD
-- Suppervised by : Dr. BOUSSELAM KAOUTHAR
----------------------------------------------------------------------------------

Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AES is
  port( Plaintext : in std_logic_vector(127 downto 0);
        Key       : in std_logic_vector(127 downto 0);
        Ciphertext: out std_logic_vector(127 downto 0));
        
end AES;

architecture AES_archi of AES is 
component  addroundkey is
  port( addroundkey_in : in std_logic_vector(127 downto 0);
        Key       : in std_logic_vector(127 downto 0);
        addroundkey_out : out std_logic_vector(127 downto 0));
end component;

component round is
 Port ( round_in  : in  STD_LOGIC_VECTOR (127 downto 0);
           keyin     : in  STD_LOGIC_VECTOR (127 downto 0);
			     keyout    : inout  STD_LOGIC_VECTOR (127 downto 0);
			     Rcon      : in STD_LOGIC_VECTOR (7 DOWNTO 0);
           round_out : out  STD_LOGIC_VECTOR (127 downto 0)
			  );
end component;

component lastRound is
Port ( lastRound_in : in  STD_LOGIC_VECTOR (127 downto 0);
       key         : in  STD_LOGIC_VECTOR (127 downto 0);
		   Rcon        : in  std_logic_vector(7 downto 0);
       lastRound_out: out STD_LOGIC_VECTOR (127 downto 0));
end component;

signal preround : std_logic_vector (127 downto 0);
signal key1,key2,key3,key4,key5,key6,key7,key8,key9 : std_logic_vector (127 downto 0);
signal r1,r2,r3,r4,r5,r6,r7,r8,r9 : std_logic_vector (127 downto 0);
signal fout : STD_LOGIC_VECTOR (127 downto 0);

begin

o0: addroundkey port map (Plaintext, key, preround);

o1: round port map(preround,key,key1,x"01",r1);

o2: round port map(r1,key1,key2,x"02",r2);

o3: round port map(r2,key2,key3,x"04",r3);

o4: round port map(r3,key3,key4,x"08",r4);

o5: round port map(r4,key4,key5,x"10",r5);

o6: round port map(r5,key5,key6,x"20",r6);

o7: round port map(r6,key6,key7,x"40",r7);

o8: round port map(r7,key7,key8,x"80",r8);

o9: round port map(r8,key8,key9,x"1b",r9);

o10: lastRound port map(r9,key9,x"36",fout);

Ciphertext <= fout;

end AES_archi;