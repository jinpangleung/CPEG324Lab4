library ieee;
use ieee.std_logic_1164.all;

entity calculatorPipelineTest is
end calculatorPipelineTest;

architecture behavioral of calculatorTest is 
component calculator
port(	registerOne : in std_logic_vector(7 downto 0);
	registerTwo : in std_logic_vector(7 downto 0);
	registerThree : in std_logic_vector(7 downto 0);
	registerFour : in std_logic_vector(7 downto 0);
	outRegisterOne : out std_logic_vector(7 downto 0);
	outRegisterTwo : out std_logic_vector(7 downto 0);
	outRegisterThree : out std_logic_vector(7 downto 0);
	outRegisterFour : out std_logic_vector(7 downto 0);
	inputZero : in std_logic;
	inputOne : in std_logic;
	inputTwo : in std_logic;
	inputThree : in std_logic;
	inputFour : in std_logic;
	inputFive : in std_logic;
	inputSix : in std_logic;
	inNop : in std_logic;
	outNop : out std_logic;
	inBranch : in std_logic;
	outBranch : out std_logic;
	immediate : in std_logic_vector(3 downto 0);
	outImmediate : out std_logic_vector ( 3 downto 0);
	operationOne : in std_logic_vector(2 downto 0);
	operationTwo : in std_logic_vector(2 downto 0);
	operationThree : in std_logic_vector(2 downto 0);
	outOperationOne : out std_logic_vector(2 downto 0); 
	outOperationTwo : out std_logic_vector(2 downto 0);
	outOperationThree : out std_logic_vector(2 downto 0);
	regSelectFirstOne : in std_logic_vector(1 downto 0);
	regSelectSecondOne : in std_logic_vector(1 downto 0);
	regSelectDestOne : in std_logic_vector(1 downto 0);
	outRegSelectFirstOne : out std_logic_vector(1 downto 0);
	outRegSelectSecondOne : out std_logic_vector(1 downto 0);
	outRegSelectDestOne : out std_logic_vector(1 downto 0);
	regSelectFirstTwo : in std_logic_vector(1 downto 0);
	regSelectSecondTwo : in std_logic_vector(1 downto 0);
	regSelectDestTwo : in std_logic_vector(1 downto 0);
	outRegSelectFirstTwo : out std_logic_vector(1 downto 0);
	outRegSelectSecondTwo : out std_logic_vector(1 downto 0);
	outRegSelectDestTwo : out std_logic_vector(1 downto 0);
	regSelectFirstThree : in std_logic_vector(1 downto 0);
	regSelectSecondThree : in std_logic_vector(1 downto 0);
	regSelectDestThree : in std_logic_vector(1 downto 0);
	outRegSelectFirstThree : out std_logic_vector(1 downto 0);
	outRegSelectSecondThree : out std_logic_vector(1 downto 0);
	outRegSelectDestThree : out std_logic_vector(1 downto 0);
	stageOne : in integer;
	stageTwo : in integer;
	stageThree : in integer;
	outStageOne : out integer;
	outStageTwo : out integer;
	outStageThree : out integer;
	inputSeven : in std_logic;
	clock : in std_logic
);
end component;

signal RegisterOne, RegisterTwo, RegisterThree, RegisterFour, OutRegisterOne, OutRegisterTwo, OutRegisterThree, OutRegisterFour, ExpectedAnswer : std_logic_vector(7 downto 0);
signal InputZero, InputOne, InputTwo, InputThree, InputFour, InputFive, InputSix, InputSeven, InputEight, Clock : std_logic;
signal InNop, OutNop, InBranch, OutBranch : std_logic;
signal OperationOne, OperationTwo, OperationThree, OutOperationOne, OutOperationTwo, OutOperationThree : std_logic_vector(2 downto 0);
signal RegSelectFirstOne, RegSelectSecondOne, RegSelectDestOne, OutRegSelectFirstOne, OutRegSelectSecondOne, OutRegSelectDestOne : std_logic_vector(1 downto 0);
signal RegSelectFirstTwo, RegSelectSecondTwo, RegSelectDestTwo, OutRegSelectFirstTwo, OutRegSelectSecondTwo, OutRegSelectDestTwo : std_logic_vector(1 downto 0);
signal RegSelectFirstThree, RegSelectSecondThree, RegSelectDestThree, OutRegSelectFirstThree, OutRegSelectSecondThree, OutRegSelectDestThree : std_logic_vector(1 downto 0);

begin 
calculator1: calculator port map (outRegSelectFirstThree => OutRegSelectFirstThree, outRegSelectSecondThree => OutRegSelectSecondThree, outRegSelectDestThree => OutRegSelectDestThree, outRegSelectFirstTwo => OutRegSelectFirstTwo, outRegSelectSecondTwo => OutRegSelectSecondTwo, outRegSelectDestTwo => OutRegSelectDestTwo, outRegSelectFirstOne => OutRegSelectFirstOne, outRegSelectSecondOne => OutRegSelectSecondOne, outRegSelectDestOne => OutRegSelectDestOne, regSelectFirstThree => RegSelectFirstThree, regSelectSecondThree => RegSelectSecondThree, regSelectDestThree => RegSelectDestThree, regSelectFirstTwo => RegSelectFirstTwo, regSelectSecondTwo => RegSelectSecondTwo, regSelectDestTwo => RegSelectDestTwo, regSelectFirstOne => RegSelectFirstOne, regSelectSecondOne => RegSelectSecondOne, regSelectDestOne => RegSelectDestOne, operationOne => OperationOne, operationTwo => OperationTwo, operationThree => OperationThree, outOperationOne => OutOperationOne, outOperationTwo => OutOperationTwo, outOperationThree => OutOperationThree, inNop => InNop, outNop => OutNop, inBranch => InBranch, outBranch => OutBranch, registerOne => RegisterOne, registerTwo => RegisterTwo, registerThree => RegisterThree, registerFour => RegisterFour, outRegisterOne => OutRegisterOne, outRegisterTwo => OutRegisterTwo, outRegisterThree => OutRegisterThree, outRegisterFour => OutRegisterFour, inputZero => InputZero, inputOne => InputOne, inputTwo => InputTwo, inputThree => InputThree, inputFour => InputFour, inputFive => InputFive, inputSix => InputSix, inputSeven => InputSeven, skip => Skip, outSkip => OutSkip, clock => Clock);
process
begin

RegisterOne <= "11111001";
RegisterTwo <= "00000001";
RegisterThree <= "00000000";
RegisterFour <= "00000011";
InputZero <= '0';
InputOne <= '0';
InputTwo <= '0';
InputThree <= '0';
InputFour <= '1';
InputFive <= '1';
InputSix <= '0';
InputSeven <= '0';
inNop <= '0';
inBranch <= '0';
immediate <= "000";
operationOne <= "000";
stageOne <= 1;
Clock <= '1';
ExpectedAnswer <= "11111100";
wait for 10 ns;

for i in 7 downto 0 loop
	assert(OutRegisterOne(i) = ExpectedAnswer(i)) report "Addition 1 test failed!!!";
end loop;

RegisterOne <= "00000000";
RegisterTwo <= "00000000";
RegisterThree <= "00000010";
RegisterFour <= "00000001";
InputZero <= '1';
InputOne <= '0';
InputTwo <= '1';
InputThree <= '0';
InputFour <= '1';
InputFive <= '1';
InputSix <= '0';
InputSeven <= '1';
inNop <= '0';
inBranch <= '0';
immediate <= "000";
operationTwo <= "101";
stageTwo <= 1;
Clock <= '0';
ExpectedAnswer <= "00000001";
wait for 10 ns;

for i in 7 downto 0 loop
	assert(OutRegisterTwo(i) = ExpectedAnswer(i)) report "Subtraction 1 test failed!!!";
end loop;

RegisterOne <= "00000000";
RegisterTwo <= "00000000";
RegisterThree <= "00000000";
RegisterFour <= "00000000";
InputZero <= '1';
InputOne <= '1';
InputTwo <= '0';
InputThree <= '1';
InputFour <= '0';
InputFive <= '0';
InputSix <= '0';
InputSeven <= '1';
inNop <= '0';
inBranch <= '0';
immediate <= "000";
operationThree <= "011";
stageThree <= 1;
Clock <= '1';
wait for 10 ns;

-- should print B1


RegisterOne <= "00000001";
RegisterTwo <= "00000010";
RegisterThree <= "00000011";
RegisterFour <= "00000100";
InputZero <= '1';
InputOne <= '1';
InputTwo <= '1';
InputThree <= '1';
InputFour <= '1';
InputFive <= '0';
InputSix <= '0';
InputSeven <= '0';
operationOne <= "111";
stageOne <= 1;
Clock <= '0';
wait for 10 ns;

-- should print 4

RegisterOne <= "00000001";
RegisterTwo <= "00000010";
RegisterThree <= "11111000";
RegisterFour <= "00000100";
InputZero <= '1';
InputOne <= '1';
InputTwo <= '1';
InputThree <= '0';
InputFour <= '1';
InputFive <= '0';
InputSix <= '0';
InputSeven <= '0';
Skip <= 0;
Clock <= '1';
wait for 10 ns;

-- should print -8


wait;
end process;
end behavioral;
