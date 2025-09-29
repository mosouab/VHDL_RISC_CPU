library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity reg_file is
  port (
    clk                : in std_logic;
    en, enW            : in std_logic;
    Add_w              : in std_logic_vector(2 downto 0);
    regA, regB         : out std_logic_vector(15 downto 0);
    Add_regA, Add_regB : out std_logic_vector(2 downto 0);
    data_in            : std_logic_vector(15 downto 0)
  );
end entity;

architecture bhv of reg_file is
  subtype reg is std_logic_vector(15 downto 0);
  type reg_array is array(0 to 7) of reg;
  signal regf : reg_array := (others => x"0000");
begin
  process (clk)
  begin
    if rising_edge(clk) then
      if (en = '1') then
        regA <= regf(conv_integer(Add_regA));
        regB <= regf(conv_integer(Add_regB));
        if (enW = '1') then
          regf(conv_integer(Add_w)) <= data_in;
        end if;
      end if;
    end if;
  end process;
end architecture bhv;