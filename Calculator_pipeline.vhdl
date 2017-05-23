-- Charles Gouert
-- Matthew Leung

library ieee;
use ieee.std_logic_1164.all;
entity calculator is 
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
	inputSeven : in std_logic;
	inNop : in std_logic;
	outNop : out std_logic;
	inBranch : in std_logic;
	outBranch : out std_logic;
	immediate : in std_logic_vector(3 downto 0);
	outImmediate : in std_logic_vector(3 downto 0);
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
	clock : in std_logic
);
end entity calculator;

architecture behavioral of calculator is 

begin
process(clock)
variable operandOne : std_logic_vector(7 downto 0);
variable operandTwo : std_logic_vector(7 downto 0);
variable result : std_logic_vector(7 downto 0);
variable carry : std_logic;
variable carryTwo : std_logic;
variable carryThree : std_logic;
begin

-- ID
if (stageOne = 1 and stageTwo /= 1 and stageThree /= 1) then
	if (inputZero = '0' and inputOne = '0') then -- add

		-- determine first operand 
		if (inputSeven = '0' and inputSix = '0') then
			outRegSelectFirstOne <= "00";
		elsif (inputSeven = '0' and inputSix = '1') then
			outRegSelectFirstOne <= "01";
		elsif (inputSeven = '1' and inputSix = '0') then
			outRegSelectFirstOne <= "10";
		else
			outRegSelectFirstOne <= "11";
		end if;

		-- determine second operand
		if (inputFive = '0' and inputFour = '0') then
			outRegSelectSecondOne <= "00";
		elsif (inputFive = '0' and inputFour = '1') then
			outRegSelectSecondOne <= "01";
		elsif (inputFive = '1' and inputFour = '0') then
			outRegSelectSecondOne <= "10";
		else
			outRegSelectSecondOne <= "11";
		end if;

		-- determine destination register
		if (inputThree = '0' and inputTwo = '0') then
			outRegSelectDestOne <= "00";
		elsif (inputThree = '0' and inputTwo = '1') then
			outRegSelectDestOne <= "01";
		elsif (inputThree = '1' and inputTwo = '0') then
			outRegSelectDestOne <= "10";
		else
			outRegSelectDestOne <= "11";
		end if;
		
		outOperationOne <= "000";
		outStageOne <= 2;
		outRegisterOne <= registerOne;
		outRegisterTwo <= registerTwo;
		outRegisterThree <= registerThree;
		outRegisterFour <= registerFour;
	
	elsif (inputZero = '1' and inputOne = '0') then -- subtract

		-- determine first operand 
		if (inputSeven = '0' and inputSix = '0') then
			outRegSelectFirstOne <= "00";
		elsif (inputSeven = '0' and inputSix = '1') then
			outRegSelectFirstOne <= "01";
		elsif (inputSeven = '1' and inputSix = '0') then
			outRegSelectFirstOne <= "10";
		else
			outRegSelectFirstOne <= "11";
		end if;

		-- determine second operand
		if (inputFive = '0' and inputFour = '0') then
			outRegSelectSecondOne <= "00";
		elsif (inputFive = '0' and inputFour = '1') then
			outRegSelectSecondOne <= "01";
		elsif (inputFive = '1' and inputFour = '0') then
			outRegSelectSecondOne <= "10";
		else
			outRegSelectSecondOne <= "11";
		end if;

		-- determine destination register
		if (inputThree = '0' and inputTwo = '0') then
			outRegSelectDestOne <= "00";
		elsif (inputThree = '0' and inputTwo = '1') then
			outRegSelectDestOne <= "01";
		elsif (inputThree = '1' and inputTwo = '0') then
			outRegSelectDestOne <= "10";
		else
			outRegSelectDestOne <= "11";
		end if;

		outOperationOne <= "001";
		outStageOne <= 2;
		outRegisterOne <= registerOne;
		outRegisterTwo <= registerTwo;
		outRegisterThree <= registerThree;
		outRegisterFour <= registerFour;

	elsif (inputZero = '0' and inputOne = '1') then -- load
		
		outImmediate(3) <= inputSeven;
		outImmediate(2) <= inputSix;
		outImmediate(1) <= inputFive;
		outImmediate(0) <= inputFour;

		-- determine destination register
		if (inputThree = '0' and inputTwo = '0') then
			outRegisterOne <= result;
		elsif (inputThree = '0' and inputTwo = '1') then
			outRegisterTwo <= result;
		elsif (inputThree = '1' and inputTwo = '0') then
			outRegisterThree <= result;
		else
			outRegisterFour <= result;
		end if;

		outOperationOne <= "010";
		outStageOne <= 2;
		outRegisterOne <= registerOne;
		outRegisterTwo <= registerTwo;
		outRegisterThree <= registerThree;
		outRegisterFour <= registerFour;

	elsif (inputZero = '1' and inputOne = '1' and inputTwo = '0') then -- branch

		-- determine first operand 
		if (inputSeven = '0' and inputSix = '0') then
			outRegSelectFirstOne <= "00";
		elsif (inputSeven = '0' and inputSix = '1') then
			outRegSelectFirstOne <= "01";
		elsif (inputSeven = '1' and inputSix = '0') then
			outRegSelectFirstOne <= "10";
		else
			outRegSelectFirstOne <= "11";
		end if;

		-- determine second operand
		if (inputFive = '0' and inputFour = '0') then
			outRegSelectSecondOne <= "00";
		elsif (inputFive = '0' and inputFour = '1') then
			outRegSelectSecondOne <= "01";
		elsif (inputFive = '1' and inputFour = '0') then
			outRegSelectSecondOne <= "10";
		else
			outRegSelectSecondOne <= "11";
		end if;

		outOperationOne <= "011";
		outNop <= '0';
		outStageOne <= 2;
		outRegisterOne <= registerOne;
		outRegisterTwo <= registerTwo;
		outRegisterThree <= registerThree;
		outRegisterFour <= registerFour;

	elsif (inputZero = '1' and inputOne = '1' and inputTwo = '1') then -- display

		-- determine first operand 
		if (inputSeven = '0' and inputSix = '0') then
			outRegSelectFirstOne <= "00";
		elsif (inputSeven = '0' and inputSix = '1') then
			outRegSelectFirstOne <= "01";
		elsif (inputSeven = '1' and inputSix = '0') then
			outRegSelectFirstOne <= "10";
		else
			outRegSelectFirstOne <= "11";
		end if;
		
		outOperationOne <= "111";
		outStageOne <= 2;
		outRegisterOne <= registerOne;
		outRegisterTwo <= registerTwo;
		outRegisterThree <= registerThree;
		outRegisterFour <= registerFour;

	elsif (inputZero = '1' and inputOne = '1' and inputTwo = '0' and inNop = '1') then -- NOP

		outOperationOne <= "011";
		outNop <= '1';
		outStageOne <= 2;
		outRegisterOne <= registerOne;
		outRegisterTwo <= registerTwo;
		outRegisterThree <= registerThree;
		outRegisterFour <= registerFour;
	end if;

elsif (stageOne /= 1 and stageTwo = 1 and stageThree /= 1) then
	if (inputZero = '0' and inputOne = '0') then -- add

		-- determine first operand 
		if (inputSeven = '0' and inputSix = '0') then
			outRegSelectFirstTwo <= "00";
		elsif (inputSeven = '0' and inputSix = '1') then
			outRegSelectFirstTwo <= "01";
		elsif (inputSeven = '1' and inputSix = '0') then
			outRegSelectFirstTwo <= "10";
		else
			outRegSelectFirstTwo <= "11";
		end if;

		-- determine second operand
		if (inputFive = '0' and inputFour = '0') then
			outRegSelectSecondTwo <= "00";
		elsif (inputFive = '0' and inputFour = '1') then
			outRegSelectSecondTwo <= "01";
		elsif (inputFive = '1' and inputFour = '0') then
			outRegSelectSecondTwo <= "10";
		else
			outRegSelectSecondTwo <= "11";
		end if;

		-- determine destination register
		if (inputThree = '0' and inputTwo = '0') then
			outRegSelectDestTwo <= "00";
		elsif (inputThree = '0' and inputTwo = '1') then
			outRegSelectDestTwo <= "01";
		elsif (inputThree = '1' and inputTwo = '0') then
			outRegSelectDestTwo <= "10";
		else
			outRegSelectDestTwo <= "11";
		end if;
		
		outOperationTwo <= "000";
		outStageTwo <= 2;
		outRegisterOne <= registerOne;
		outRegisterTwo <= registerTwo;
		outRegisterThree <= registerThree;
		outRegisterFour <= registerFour;
	
	elsif (inputZero = '1' and inputOne = '0') then -- subtract

		-- determine first operand 
		if (inputSeven = '0' and inputSix = '0') then
			outRegSelectFirstTwo <= "00";
		elsif (inputSeven = '0' and inputSix = '1') then
			outRegSelectFirstTwo <= "01";
		elsif (inputSeven = '1' and inputSix = '0') then
			outRegSelectFirstTwo <= "10";
		else
			outRegSelectFirstTwo <= "11";
		end if;

		-- determine second operand
		if (inputFive = '0' and inputFour = '0') then
			outRegSelectSecondTwo <= "00";
		elsif (inputFive = '0' and inputFour = '1') then
			outRegSelectSecondTwo <= "01";
		elsif (inputFive = '1' and inputFour = '0') then
			outRegSelectSecondTwo <= "10";
		else
			outRegSelectSecondTwo <= "11";
		end if;

		-- determine destination register
		if (inputThree = '0' and inputTwo = '0') then
			outRegSelectDestTwo <= "00";
		elsif (inputThree = '0' and inputTwo = '1') then
			outRegSelectDestTwo <= "01";
		elsif (inputThree = '1' and inputTwo = '0') then
			outRegSelectDestTwo <= "10";
		else
			outRegSelectDestTwo <= "11";
		end if;

		outOperationTwo <= "001";
		outStageTwo <= 2;
		outRegisterOne <= registerOne;
		outRegisterTwo <= registerTwo;
		outRegisterThree <= registerThree;
		outRegisterFour <= registerFour;

	elsif (inputZero = '0' and inputOne = '1') then -- load
		
		outImmediate(3) <= inputSeven;
		outImmediate(2) <= inputSix;
		outImmediate(1) <= inputFive;
		outImmediate(0) <= inputFour;

		-- determine destination register
		if (inputThree = '0' and inputTwo = '0') then
			outRegisterOne <= result;
		elsif (inputThree = '0' and inputTwo = '1') then
			outRegisterTwo <= result;
		elsif (inputThree = '1' and inputTwo = '0') then
			outRegisterThree <= result;
		else
			outRegisterFour <= result;
		end if;

		outOperationTwo <= "010";
		outStageTwo <= 2;
		outRegisterOne <= registerOne;
		outRegisterTwo <= registerTwo;
		outRegisterThree <= registerThree;
		outRegisterFour <= registerFour;

	elsif (inputZero = '1' and inputOne = '1' and inputTwo = '0') then -- branch

		-- determine first operand 
		if (inputSeven = '0' and inputSix = '0') then
			outRegSelectFirstTwo <= "00";
		elsif (inputSeven = '0' and inputSix = '1') then
			outRegSelectFirstTwo <= "01";
		elsif (inputSeven = '1' and inputSix = '0') then
			outRegSelectFirstTwo <= "10";
		else
			outRegSelectFirstTwo <= "11";
		end if;

		-- determine second operand
		if (inputFive = '0' and inputFour = '0') then
			outRegSelectSecondTwo <= "00";
		elsif (inputFive = '0' and inputFour = '1') then
			outRegSelectSecondTwo <= "01";
		elsif (inputFive = '1' and inputFour = '0') then
			outRegSelectSecondTwo <= "10";
		else
			outRegSelectSecondTwo <= "11";
		end if;

		outOperationTwo <= "011";
		outStageTwo <= 2;
		outNop <= '0';
		outRegisterOne <= registerOne;
		outRegisterTwo <= registerTwo;
		outRegisterThree <= registerThree;
		outRegisterFour <= registerFour;

	elsif (inputZero = '1' and inputOne = '1' and inputTwo = '1') then -- display

		-- determine first operand 
		if (inputSeven = '0' and inputSix = '0') then
			outRegSelectFirstTwo <= "00";
		elsif (inputSeven = '0' and inputSix = '1') then
			outRegSelectFirstTwo <= "01";
		elsif (inputSeven = '1' and inputSix = '0') then
			outRegSelectFirstTwo <= "10";
		else
			outRegSelectFirstTwo <= "11";
		end if;
		
		outOperationTwo <= "111";
		outStageTwo <= 2;
		outRegisterOne <= registerOne;
		outRegisterTwo <= registerTwo;
		outRegisterThree <= registerThree;
		outRegisterFour <= registerFour;

	elsif (inputZero = '1' and inputOne = '1' and inputTwo = '0' and inNop = '1') then -- NOP

		outOperationTwo <= "011";
		outNop <= '1';
		outStageTwo <= 2;
		outRegisterOne <= registerOne;
		outRegisterTwo <= registerTwo;
		outRegisterThree <= registerThree;
		outRegisterFour <= registerFour;
	end if;

elsif (stageOne /= 1 and stageTwo /= 1 and stageThree = 1) then
	if (inputZero = '0' and inputOne = '0') then -- add

		-- determine first operand 
		if (inputSeven = '0' and inputSix = '0') then
			outRegSelectFirstThree <= "00";
		elsif (inputSeven = '0' and inputSix = '1') then
			outRegSelectFirstThree <= "01";
		elsif (inputSeven = '1' and inputSix = '0') then
			outRegSelectFirstThree <= "10";
		else
			outRegSelectFirstThree <= "11";
		end if;

		-- determine second operand
		if (inputFive = '0' and inputFour = '0') then
			outRegSelectSecondThree <= "00";
		elsif (inputFive = '0' and inputFour = '1') then
			outRegSelectSecondThree <= "01";
		elsif (inputFive = '1' and inputFour = '0') then
			outRegSelectSecondThree <= "10";
		else
			outRegSelectSecondThree <= "11";
		end if;

		-- determine destination register
		if (inputThree = '0' and inputTwo = '0') then
			outRegSelectDestThree <= "00";
		elsif (inputThree = '0' and inputTwo = '1') then
			outRegSelectDestThree <= "01";
		elsif (inputThree = '1' and inputTwo = '0') then
			outRegSelectDestThree <= "10";
		else
			outRegSelectDestThree <= "11";
		end if;
		
		outOperationThree <= "000";
		outStageThree <= 2;
		outRegisterOne <= registerOne;
		outRegisterTwo <= registerTwo;
		outRegisterThree <= registerThree;
		outRegisterFour <= registerFour;
	
	elsif (inputZero = '1' and inputOne = '0') then -- subtract

		-- determine first operand 
		if (inputSeven = '0' and inputSix = '0') then
			outRegSelectFirstThree <= "00";
		elsif (inputSeven = '0' and inputSix = '1') then
			outRegSelectFirstThree <= "01";
		elsif (inputSeven = '1' and inputSix = '0') then
			outRegSelectFirstThree <= "10";
		else
			outRegSelectFirstThree <= "11";
		end if;

		-- determine second operand
		if (inputFive = '0' and inputFour = '0') then
			outRegSelectSecondThree <= "00";
		elsif (inputFive = '0' and inputFour = '1') then
			outRegSelectSecondThree <= "01";
		elsif (inputFive = '1' and inputFour = '0') then
			outRegSelectSecondThree <= "10";
		else
			outRegSelectSecondThree <= "11";
		end if;

		-- determine destination register
		if (inputThree = '0' and inputTwo = '0') then
			outRegSelectDestThree <= "00";
		elsif (inputThree = '0' and inputTwo = '1') then
			outRegSelectDestThree <= "01";
		elsif (inputThree = '1' and inputTwo = '0') then
			outRegSelectDestThree <= "10";
		else
			outRegSelectDestThree <= "11";
		end if;

		outOperationThree <= "001";
		outStageThree <= 2;
		outRegisterOne <= registerOne;
		outRegisterTwo <= registerTwo;
		outRegisterThree <= registerThree;
		outRegisterFour <= registerFour;

	elsif (inputZero = '0' and inputOne = '1') then -- load
		
		outImmediate(3) <= inputSeven;
		outImmediate(2) <= inputSix;
		outImmediate(1) <= inputFive;
		outImmediate(0) <= inputFour;

		-- determine destination register
		if (inputThree = '0' and inputTwo = '0') then
			outRegisterOne <= result;
		elsif (inputThree = '0' and inputTwo = '1') then
			outRegisterTwo <= result;
		elsif (inputThree = '1' and inputTwo = '0') then
			outRegisterThree <= result;
		else
			outRegisterFour <= result;
		end if;

		outOperationThree <= "010";
		outStageThree <= 2;
		outRegisterOne <= registerOne;
		outRegisterTwo <= registerTwo;
		outRegisterThree <= registerThree;
		outRegisterFour <= registerFour;

	elsif (inputZero = '1' and inputOne = '1' and inputTwo = '0') then -- branch

		-- determine first operand 
		if (inputSeven = '0' and inputSix = '0') then
			outRegSelectFirstThree <= "00";
		elsif (inputSeven = '0' and inputSix = '1') then
			outRegSelectFirstThree <= "01";
		elsif (inputSeven = '1' and inputSix = '0') then
			outRegSelectFirstThree <= "10";
		else
			outRegSelectFirstThree <= "11";
		end if;

		-- determine second operand
		if (inputFive = '0' and inputFour = '0') then
			outRegSelectSecondThree <= "00";
		elsif (inputFive = '0' and inputFour = '1') then
			outRegSelectSecondThree <= "01";
		elsif (inputFive = '1' and inputFour = '0') then
			outRegSelectSecondThree <= "10";
		else
			outRegSelectSecondThree <= "11";
		end if;

		outOperationThree <= "011";
		outStageThree <= 2;
		outNop <= '0';
		outRegisterOne <= registerOne;
		outRegisterTwo <= registerTwo;
		outRegisterThree <= registerThree;
		outRegisterFour <= registerFour;

	elsif (inputZero = '1' and inputOne = '1' and inputTwo = '1') then -- display

		-- determine first operand 
		if (inputSeven = '0' and inputSix = '0') then
			outRegSelectFirstThree <= "00";
		elsif (inputSeven = '0' and inputSix = '1') then
			outRegSelectFirstThree <= "01";
		elsif (inputSeven = '1' and inputSix = '0') then
			outRegSelectFirstThree <= "10";
		else
			outRegSelectFirstThree <= "11";
		end if;
		
		outOperationThree <= "111";
		outStageThree <= 2;
		outRegisterOne <= registerOne;
		outRegisterTwo <= registerTwo;
		outRegisterThree <= registerThree;
		outRegisterFour <= registerFour;

	elsif (inputZero = '1' and inputOne = '1' and inputTwo = '0' and inNop = '1') then -- NOP

		outOperationThree <= "011";
		outNop <= '1';
		outStageThree <= 2;
		outRegisterOne <= registerOne;
		outRegisterTwo <= registerTwo;
		outRegisterThree <= registerThree;
		outRegisterFour <= registerFour;
	end if;
end if;
------------------------------------------------------------------------------------------------------------------
-- EXE
if (stageOne = 2 and stageTwo /= 2 and stageThree /= 2) then
	if (operationOne = "000" or operationOne = "001") then -- add/sub
	
		-- determine first operand
		if (regSelectFirstOne = "00") then
			operandOne := registerOne;
		elsif (regSelectFirstOne = "01") then
			operandOne := registerTwo;
		elsif (regSelectFirstOne = "10") then
			operandOne := registerThree;
		elsif (regSelectFirstOne = "11") then
			operandOne := registerFour;
		end if;

		-- determine second operand
		if (regSelectSecondOne = "00") then
			operandTwo := registerOne;
		elsif (regSelectSecondOne = "01") then
			operandTwo := registerTwo;
		elsif (regSelectSecondOne = "10") then
			operandTwo := registerThree;
		elsif (regSelectSecondOne = "11") then
			operandTwo := registerFour;
		end if;

		if (operationOne = "000") then

			-- addition
			result(0) := operandOne(0) xor operandTwo(0);
			carry := operandOne(0) and operandTwo(0);
			result(1) := (operandOne(1) and operandTwo(1) and carry) or ((operandOne(1) xor operandTwo(1)) and (not carry)) or ((not operandOne(1)) and (not operandTwo(1)) and carry);
			carryTwo := (operandOne(1) and operandTwo(1)) or (operandOne(1) and carry) or (operandTwo(1) and carry);
			result(2) := (operandOne(2) and operandTwo(2) and carryTwo) or ((operandOne(2) xor operandTwo(2)) and (not carryTwo)) or ((not operandOne(2)) and (not operandTwo(2)) and carryTwo);
			carryThree := (operandOne(2) and operandTwo(2)) or (operandOne(2) and carryTwo) or (operandTwo(2) and carryTwo);
			result(3) := (operandOne(3) and operandTwo(3) and carryThree) or ((operandOne(3) xor operandTwo(3)) and (not carryThree)) or ((not operandOne(3)) and (not operandTwo(3)) and carryThree);
			result(4) := result(3);
			result(5) := result(3);
			result(6) := result(3);
			result(7) := result(3);
			outOperationOne <= "000";

		else

			-- change sign of operandTwo before adding
			if (operandTwo(0) = '1') then
				operandTwo(1) := not operandTwo(1);
				operandTwo(2) := not operandTwo(2);
				operandTwo(3) := not operandTwo(3);
				operandTwo(4) := operandTwo(3);
				operandTwo(5) := operandTwo(3);
				operandTwo(6) := operandTwo(3);
				operandTwo(7) := operandTwo(3);
			else
				operandTwo(1) := not operandTwo(1);
				operandTwo(2) := not operandTwo(2);
				operandTwo(3) := not operandTwo(3);
				operandTwo(4) := operandTwo(3);
				operandTwo(5) := operandTwo(3);
				operandTwo(6) := operandTwo(3);
				operandTwo(7) := operandTwo(3);
				if (operandTwo(1) = '0') then
					operandTwo(1) := '1';
				else
					operandTwo(1) := '0';
					if (operandTwo(2) = '0') then
						operandTwo(2) := '1';
					else
						operandTwo(2) := '0';
						if (operandTwo(3) = '0') then
							operandTwo(3) := '1';
						else
							operandTwo(3) := '0';
						end if;
					end if;
				end if;
			end if;

			-- subtraction
			result(0) := operandOne(0) xor operandTwo(0);
			carry := operandOne(0) and operandTwo(0);
			result(1) := (operandOne(1) and operandTwo(1) and carry) or ((operandOne(1) xor operandTwo(1)) and (not carry)) or ((not operandOne(1)) and (not operandTwo(1)) and carry);
			carryTwo := (operandOne(1) and operandTwo(1)) or (operandOne(1) and carry) or (operandTwo(1) and carry);
			result(2) := (operandOne(2) and operandTwo(2) and carryTwo) or ((operandOne(2) xor operandTwo(2)) and (not carryTwo)) or ((not operandOne(2)) and (not operandTwo(2)) and carryTwo);
			carryThree := (operandOne(2) and operandTwo(2)) or (operandOne(2) and carryTwo) or (operandTwo(2) and carryTwo);
			result(3) := (operandOne(3) and operandTwo(3) and carryThree) or ((operandOne(3) xor operandTwo(3)) and (not carryThree)) or ((not operandOne(3)) and (not operandTwo(3)) and carryThree);
			result(4) := result(3);
			result(5) := result(3);
			result(6) := result(3);
			result(7) := result(3);
			outOperationOne <= "001";
		end if;

		-- determine destination register
		if (regSelectDestOne = "00") then
			outRegisterOne <= result;
			outRegisterTwo <= registerTwo;
			outRegisterThree <= registerThree;
			outRegisterFour <= registerFour;
			outStageOne <= 3;
		elsif (regSelectDestOne = "01") then
			outRegisterOne <= registerOne;
			outRegisterTwo <= result;
			outRegisterThree <= registerThree;
			outRegisterFour <= registerFour;
			outStageOne <= 3;
		elsif (regSelectDestOne = "10") then
			outRegisterOne <= registerOne;
			outRegisterTwo <= registerTwo;
			outRegisterThree <= result;
			outRegisterFour <= registerFour;
			outStageOne <= 3;
		elsif (regSelectDestOne = "11") then
			outRegisterOne <= registerOne;
			outRegisterTwo <= registerTwo;
			outRegisterThree <= registerThree;
			outRegisterFour <= result;
			outStageOne <= 3;
		end if;	

	elsif (operationOne = "010" or operationOne = "111" or (operationOne = "011" and inNop = '1')) then -- load/display/NOP
		-- do nothing
		outRegisterOne <= registerOne;
		outRegisterTwo <= registerTwo;
		outRegisterThree <= registerThree;
		outRegisterFour <= registerFour;
		outOperationOne <= operationOne;
		outStageOne <= 3;
		if (inNop = '1') then
			outNop = '1';
		else
			outNop = '0';
		end if;

	elsif (operationOne = "011" and inNop /= 1) then -- branch

		-- determine first operand
		if (regSelectFirstOne = "00") then
			operandOne := registerOne;
		elsif (regSelectFirstOne = "01") then
			operandOne := registerTwo;
		elsif (regSelectFirstOne = "10") then
			operandOne := registerThree;
		elsif (regSelectFirstOne = "11") then
			operandOne := registerFour;
		end if;

		-- determine second operand
		if (regSelectSecondOne = "00") then
			operandTwo := registerOne;
		elsif (regSelectSecondOne = "01") then
			operandTwo := registerTwo;
		elsif (regSelectSecondOne = "10") then
			operandTwo := registerThree;
		elsif (regSelectSecondOne = "11") then
			operandTwo := registerFour;
		end if;

		-- calculate branch condition
		if (operandOne = operandTwo) then
			outBranch <= '1';
		else
			outBranch <= '0';
		end if;

		outRegisterOne <= registerOne;
		outRegisterTwo <= registerTwo;
		outRegisterThree <= registerThree;
		outRegisterFour <= registerFour;
		outOperationOne <= operationOne;
		outNop <= '0';
		outStageOne <= 3;
	end if;

elsif (stageOne /= 2 and stageTwo = 2 and stageThree /= 2) then

	if (operationTwo = "000" or operationTwo = "001") then -- add/sub
	
		-- determine first operand
		if (regSelectFirstTwo = "00") then
			operandOne := registerOne;
		elsif (regSelectFirstTwo = "01") then
			operandOne := registerTwo;
		elsif (regSelectFirstTwo = "10") then
			operandOne := registerThree;
		elsif (regSelectFirstTwo = "11") then
			operandOne := registerFour;
		end if;

		-- determine second operand
		if (regSelectSecondTwo = "00") then
			operandTwo := registerOne;
		elsif (regSelectSecondTwo = "01") then
			operandTwo := registerTwo;
		elsif (regSelectSecondTwo = "10") then
			operandTwo := registerThree;
		elsif (regSelectSecondTwo = "11") then
			operandTwo := registerFour;
		end if;

		if (operationTwo = "000") then

			-- addition
			result(0) := operandOne(0) xor operandTwo(0);
			carry := operandOne(0) and operandTwo(0);
			result(1) := (operandOne(1) and operandTwo(1) and carry) or ((operandOne(1) xor operandTwo(1)) and (not carry)) or ((not operandOne(1)) and (not operandTwo(1)) and carry);
			carryTwo := (operandOne(1) and operandTwo(1)) or (operandOne(1) and carry) or (operandTwo(1) and carry);
			result(2) := (operandOne(2) and operandTwo(2) and carryTwo) or ((operandOne(2) xor operandTwo(2)) and (not carryTwo)) or ((not operandOne(2)) and (not operandTwo(2)) and carryTwo);
			carryThree := (operandOne(2) and operandTwo(2)) or (operandOne(2) and carryTwo) or (operandTwo(2) and carryTwo);
			result(3) := (operandOne(3) and operandTwo(3) and carryThree) or ((operandOne(3) xor operandTwo(3)) and (not carryThree)) or ((not operandOne(3)) and (not operandTwo(3)) and carryThree);
			result(4) := result(3);
			result(5) := result(3);
			result(6) := result(3);
			result(7) := result(3);
			outOperationTwo <= "000";

		else

			-- change sign of operandTwo before adding
			if (operandTwo(0) = '1') then
				operandTwo(1) := not operandTwo(1);
				operandTwo(2) := not operandTwo(2);
				operandTwo(3) := not operandTwo(3);
				operandTwo(4) := operandTwo(3);
				operandTwo(5) := operandTwo(3);
				operandTwo(6) := operandTwo(3);
				operandTwo(7) := operandTwo(3);
			else
				operandTwo(1) := not operandTwo(1);
				operandTwo(2) := not operandTwo(2);
				operandTwo(3) := not operandTwo(3);
				operandTwo(4) := operandTwo(3);
				operandTwo(5) := operandTwo(3);
				operandTwo(6) := operandTwo(3);
				operandTwo(7) := operandTwo(3);
				if (operandTwo(1) = '0') then
					operandTwo(1) := '1';
				else
					operandTwo(1) := '0';
					if (operandTwo(2) = '0') then
						operandTwo(2) := '1';
					else
						operandTwo(2) := '0';
						if (operandTwo(3) = '0') then
							operandTwo(3) := '1';
						else
							operandTwo(3) := '0';
						end if;
					end if;
				end if;
			end if;

			-- subtraction
			result(0) := operandOne(0) xor operandTwo(0);
			carry := operandOne(0) and operandTwo(0);
			result(1) := (operandOne(1) and operandTwo(1) and carry) or ((operandOne(1) xor operandTwo(1)) and (not carry)) or ((not operandOne(1)) and (not operandTwo(1)) and carry);
			carryTwo := (operandOne(1) and operandTwo(1)) or (operandOne(1) and carry) or (operandTwo(1) and carry);
			result(2) := (operandOne(2) and operandTwo(2) and carryTwo) or ((operandOne(2) xor operandTwo(2)) and (not carryTwo)) or ((not operandOne(2)) and (not operandTwo(2)) and carryTwo);
			carryThree := (operandOne(2) and operandTwo(2)) or (operandOne(2) and carryTwo) or (operandTwo(2) and carryTwo);
			result(3) := (operandOne(3) and operandTwo(3) and carryThree) or ((operandOne(3) xor operandTwo(3)) and (not carryThree)) or ((not operandOne(3)) and (not operandTwo(3)) and carryThree);
			result(4) := result(3);
			result(5) := result(3);
			result(6) := result(3);
			result(7) := result(3);
			outOperationTwo <= "001";
		end if;

		-- determine destination register
		if (regSelectDestTwo = "00") then
			outRegisterOne <= result;
			outRegisterTwo <= registerTwo;
			outRegisterThree <= registerThree;
			outRegisterFour <= registerFour;
			outStageTwo <= 3;
		elsif (regSelectDestTwo = "01") then
			outRegisterOne <= registerOne;
			outRegisterTwo <= result;
			outRegisterThree <= registerThree;
			outRegisterFour <= registerFour;
			outStageTwo <= 3;
		elsif (regSelectDestTwo = "10") then
			outRegisterOne <= registerOne;
			outRegisterTwo <= registerTwo;
			outRegisterThree <= result;
			outRegisterFour <= registerFour;
			outStageTwo <= 3;
		elsif (regSelectDestTwo = "11") then
			outRegisterOne <= registerOne;
			outRegisterTwo <= registerTwo;
			outRegisterThree <= registerThree;
			outRegisterFour <= result;
			outStageTwo <= 3;
		end if;	

	elsif (operationTwo = "010" or operationTwo = "111" or (operationTwo = "011" and inNop = '1')) then -- load/display/NOP
		-- do nothing
		outRegisterOne <= registerOne;
		outRegisterTwo <= registerTwo;
		outRegisterThree <= registerThree;
		outRegisterFour <= registerFour;
		outOperationTwo <= operationTwo;
		outStageTwo <= 3;
		if (inNop = '1') then
			outNop = '1';
		else
			outNop = '0';
		end if;

	elsif (operationTwo = "011" and inNop /= 1) then -- branch

		-- determine first operand
		if (regSelectFirstTwo = "00") then
			operandOne := registerOne;
		elsif (regSelectFirstTwo = "01") then
			operandOne := registerTwo;
		elsif (regSelectFirstTwo = "10") then
			operandOne := registerThree;
		elsif (regSelectFirstTwo = "11") then
			operandOne := registerFour;
		end if;

		-- determine second operand
		if (regSelectSecondTwo = "00") then
			operandTwo := registerOne;
		elsif (regSelectSecondTwo = "01") then
			operandTwo := registerTwo;
		elsif (regSelectSecondTwo = "10") then
			operandTwo := registerThree;
		elsif (regSelectSecondTwo = "11") then
			operandTwo := registerFour;
		end if;

		-- calculate branch condition
		if (operandOne = operandTwo) then
			outBranch <= '1';
		else
			outBranch <= '0';
		end if;

		outRegisterOne <= registerOne;
		outRegisterTwo <= registerTwo;
		outRegisterThree <= registerThree;
		outRegisterFour <= registerFour;
		outOperationTwo <= operationTwo;
		outNop <= '0';
		outStageTwo <= 3;
	end if;

elsif (stageOne /= 2 and stageTwo /= 2 and stageThree = 2) then

	if (operationTwo = "000" or operationTwo = "001") then -- add/sub
	
		-- determine first operand
		if (regSelectFirstThree = "00") then
			operandOne := registerOne;
		elsif (regSelectFirstThree = "01") then
			operandOne := registerTwo;
		elsif (regSelectFirstThree = "10") then
			operandOne := registerThree;
		elsif (regSelectFirstThree = "11") then
			operandOne := registerFour;
		end if;

		-- determine second operand
		if (regSelectSecondThree = "00") then
			operandTwo := registerOne;
		elsif (regSelectSecondThree = "01") then
			operandTwo := registerTwo;
		elsif (regSelectSecondThree = "10") then
			operandTwo := registerThree;
		elsif (regSelectSecondThree = "11") then
			operandTwo := registerFour;
		end if;

		if (operationTwo = "000") then

			-- addition
			result(0) := operandOne(0) xor operandTwo(0);
			carry := operandOne(0) and operandTwo(0);
			result(1) := (operandOne(1) and operandTwo(1) and carry) or ((operandOne(1) xor operandTwo(1)) and (not carry)) or ((not operandOne(1)) and (not operandTwo(1)) and carry);
			carryTwo := (operandOne(1) and operandTwo(1)) or (operandOne(1) and carry) or (operandTwo(1) and carry);
			result(2) := (operandOne(2) and operandTwo(2) and carryTwo) or ((operandOne(2) xor operandTwo(2)) and (not carryTwo)) or ((not operandOne(2)) and (not operandTwo(2)) and carryTwo);
			carryThree := (operandOne(2) and operandTwo(2)) or (operandOne(2) and carryTwo) or (operandTwo(2) and carryTwo);
			result(3) := (operandOne(3) and operandTwo(3) and carryThree) or ((operandOne(3) xor operandTwo(3)) and (not carryThree)) or ((not operandOne(3)) and (not operandTwo(3)) and carryThree);
			result(4) := result(3);
			result(5) := result(3);
			result(6) := result(3);
			result(7) := result(3);
			outOperationThree <= "000";

		else

			-- change sign of operandTwo before adding
			if (operandTwo(0) = '1') then
				operandTwo(1) := not operandTwo(1);
				operandTwo(2) := not operandTwo(2);
				operandTwo(3) := not operandTwo(3);
				operandTwo(4) := operandTwo(3);
				operandTwo(5) := operandTwo(3);
				operandTwo(6) := operandTwo(3);
				operandTwo(7) := operandTwo(3);
			else
				operandTwo(1) := not operandTwo(1);
				operandTwo(2) := not operandTwo(2);
				operandTwo(3) := not operandTwo(3);
				operandTwo(4) := operandTwo(3);
				operandTwo(5) := operandTwo(3);
				operandTwo(6) := operandTwo(3);
				operandTwo(7) := operandTwo(3);
				if (operandTwo(1) = '0') then
					operandTwo(1) := '1';
				else
					operandTwo(1) := '0';
					if (operandTwo(2) = '0') then
						operandTwo(2) := '1';
					else
						operandTwo(2) := '0';
						if (operandTwo(3) = '0') then
							operandTwo(3) := '1';
						else
							operandTwo(3) := '0';
						end if;
					end if;
				end if;
			end if;

			-- subtraction
			result(0) := operandOne(0) xor operandTwo(0);
			carry := operandOne(0) and operandTwo(0);
			result(1) := (operandOne(1) and operandTwo(1) and carry) or ((operandOne(1) xor operandTwo(1)) and (not carry)) or ((not operandOne(1)) and (not operandTwo(1)) and carry);
			carryTwo := (operandOne(1) and operandTwo(1)) or (operandOne(1) and carry) or (operandTwo(1) and carry);
			result(2) := (operandOne(2) and operandTwo(2) and carryTwo) or ((operandOne(2) xor operandTwo(2)) and (not carryTwo)) or ((not operandOne(2)) and (not operandTwo(2)) and carryTwo);
			carryThree := (operandOne(2) and operandTwo(2)) or (operandOne(2) and carryTwo) or (operandTwo(2) and carryTwo);
			result(3) := (operandOne(3) and operandTwo(3) and carryThree) or ((operandOne(3) xor operandTwo(3)) and (not carryThree)) or ((not operandOne(3)) and (not operandTwo(3)) and carryThree);
			result(4) := result(3);
			result(5) := result(3);
			result(6) := result(3);
			result(7) := result(3);
			outOperationThree <= "001";
		end if;

		-- determine destination register
		if (regSelectDestThree = "00") then
			outRegisterOne <= result;
			outRegisterTwo <= registerTwo;
			outRegisterThree <= registerThree;
			outRegisterFour <= registerFour;
			outStageThree <= 3;
		elsif (regSelectDestThree = "01") then
			outRegisterOne <= registerOne;
			outRegisterTwo <= result;
			outRegisterThree <= registerThree;
			outRegisterFour <= registerFour;
			outStageThree <= 3;
		elsif (regSelectDestThree = "10") then
			outRegisterOne <= registerOne;
			outRegisterTwo <= registerTwo;
			outRegisterThree <= result;
			outRegisterFour <= registerFour;
			outStageThree <= 3;
		elsif (regSelectDestThree = "11") then
			outRegisterOne <= registerOne;
			outRegisterTwo <= registerTwo;
			outRegisterThree <= registerThree;
			outRegisterFour <= result;
			outStageThree <= 3;
		end if;	

	elsif (operationTwo = "010" or operationTwo = "111" or (operationTwo = "011" and inNop = '1')) then -- load/display/NOP
		-- do nothing
		outRegisterOne <= registerOne;
		outRegisterTwo <= registerTwo;
		outRegisterThree <= registerThree;
		outRegisterFour <= registerFour;
		outOperationThree <= operationTwo;
		outStageThree <= 3;
		if (inNop = '1') then
			outNop = '1';
		else
			outNop = '0';
		end if;

	elsif (operationTwo = "011" and inNop /= 1) then -- branch

		-- determine first operand
		if (regSelectFirstThree = "00") then
			operandOne := registerOne;
		elsif (regSelectFirstThree = "01") then
			operandOne := registerTwo;
		elsif (regSelectFirstThree = "10") then
			operandOne := registerThree;
		elsif (regSelectFirstThree = "11") then
			operandOne := registerFour;
		end if;

		-- determine second operand
		if (regSelectSecondThree = "00") then
			operandTwo := registerOne;
		elsif (regSelectSecondThree = "01") then
			operandTwo := registerTwo;
		elsif (regSelectSecondThree = "10") then
			operandTwo := registerThree;
		elsif (regSelectSecondThree = "11") then
			operandTwo := registerFour;
		end if;

		-- calculate branch condition
		if (operandOne = operandTwo) then
			outBranch <= '1';
		else
			outBranch <= '0';
		end if;

		outRegisterOne <= registerOne;
		outRegisterTwo <= registerTwo;
		outRegisterThree <= registerThree;
		outRegisterFour <= registerFour;
		outOperationThree <= operationTwo;
		outNop <= '0';
		outStageThree <= 3;
	end if;
end if;

------------------------------------------------------------------------------------------------------------------
-- WB
if (stageOne = 3 and stageTwo /= 3 and stageThree /= 3) then
	if (operationOne = "000" or operationOne = "001" or operationOne = "111") then --add/subtract/print

		-- determine destination register
		if (regSelectDestOne = "00") then
			operandOne := registerOne;
		elsif (regSelectDestOne = "01") then
			operandOne := registerTwo;
		elsif (regSelectDestOne = "10") then
			operandOne := registerThree;
		elsif (regSelectDestOne = "11") then
			operandOne := registerFour;
		end if;	

		if (operandOne(0) = '0' and operandOne(1) = '0' and operandOne(2) = '0' and operandOne(3) = '0') then
			report(integer'image(0));
		elsif (operandOne(0) = '1' and operandOne(1) = '0' and operandOne(2) = '0' and operandOne(3) = '0') then
			report(integer'image(1));
		elsif (operandOne(0) = '0' and operandOne(1) = '1' and operandOne(2) = '0' and operandOne(3) = '0') then
			report(integer'image(2));
		elsif (operandOne(0) = '1' and operandOne(1) = '1' and operandOne(2) = '0' and operandOne(3) = '0') then
			report(integer'image(3));
		elsif (operandOne(0) = '0' and operandOne(1) = '0' and operandOne(2) = '1' and operandOne(3) = '0') then
			report(integer'image(4));
		elsif (operandOne(0) = '1' and operandOne(1) = '0' and operandOne(2) = '1' and operandOne(3) = '0') then
			report(integer'image(5));
		elsif (operandOne(0) = '0' and operandOne(1) = '1' and operandOne(2) = '1' and operandOne(3) = '0') then
			report(integer'image(6));
		elsif (operandOne(0) = '1' and operandOne(1) = '1' and operandOne(2) = '1' and operandOne(3) = '0') then
			report(integer'image(7));
		elsif (operandOne(0) = '0' and operandOne(1) = '0' and operandOne(2) = '0' and operandOne(3) = '1') then
			report(integer'image(-8));
		elsif (operandOne(1) = '1' and operandOne(1) = '0' and operandOne(2) = '0' and operandOne(3) = '1') then
			report(integer'image(-7));
		elsif (operandOne(0) = '0' and operandOne(1) = '1' and operandOne(2) = '0' and operandOne(3) = '1') then
			report(integer'image(-6));
		elsif (operandOne(0) = '1' and operandOne(1) = '1' and operandOne(2) = '0' and operandOne(3) = '1') then
			report(integer'image(-5));
		elsif (operandOne(0) = '0' and operandOne(1) = '0' and operandOne(2) = '1' and operandOne(3) = '1') then
			report(integer'image(-4));
		elsif (operandOne(0) = '0' and operandOne(1) = '1' and operandOne(2) = '1' and operandOne(3) = '1') then
			report(integer'image(-2));
		elsif (operandOne(0) = '1' and operandOne(1) = '1' and operandOne(2) = '1' and operandOne(3) = '1') then
			report(integer'image(-1));
		end if;
	
	elsif (operationOne = "011") then
		if (inNop = '1') then
			report("NOP");
		elsif (inBranch = '0') then
			report("B0");
		elsif (inBranch = '1') then
			report("B1");
		end if;
	end if;

	outRegisterOne <= registerOne;
	outRegisterTwo <= registerTwo;
	outRegisterThree <= registerThree;
	outRegisterFour <= registerFour;
	outNop <= '0';

elsif (stageOne /= 3 and stageTwo = 3 and stageThree /= 3) then

	if (operationTwo = "000" or operationTwo = "001" or operationTwo = "111") then --add/subtract/print

		-- determine destination register
		if (regSelectDestTwo = "00") then
			operandOne := registerOne;
		elsif (regSelectDestTwo = "01") then
			operandOne := registerTwo;
		elsif (regSelectDestTwo = "10") then
			operandOne := registerThree;
		elsif (regSelectDestTwo = "11") then
			operandOne := registerFour;
		end if;	

		if (operandOne(0) = '0' and operandOne(1) = '0' and operandOne(2) = '0' and operandOne(3) = '0') then
			report(integer'image(0));
		elsif (operandOne(0) = '1' and operandOne(1) = '0' and operandOne(2) = '0' and operandOne(3) = '0') then
			report(integer'image(1));
		elsif (operandOne(0) = '0' and operandOne(1) = '1' and operandOne(2) = '0' and operandOne(3) = '0') then
			report(integer'image(2));
		elsif (operandOne(0) = '1' and operandOne(1) = '1' and operandOne(2) = '0' and operandOne(3) = '0') then
			report(integer'image(3));
		elsif (operandOne(0) = '0' and operandOne(1) = '0' and operandOne(2) = '1' and operandOne(3) = '0') then
			report(integer'image(4));
		elsif (operandOne(0) = '1' and operandOne(1) = '0' and operandOne(2) = '1' and operandOne(3) = '0') then
			report(integer'image(5));
		elsif (operandOne(0) = '0' and operandOne(1) = '1' and operandOne(2) = '1' and operandOne(3) = '0') then
			report(integer'image(6));
		elsif (operandOne(0) = '1' and operandOne(1) = '1' and operandOne(2) = '1' and operandOne(3) = '0') then
			report(integer'image(7));
		elsif (operandOne(0) = '0' and operandOne(1) = '0' and operandOne(2) = '0' and operandOne(3) = '1') then
			report(integer'image(-8));
		elsif (operandOne(1) = '1' and operandOne(1) = '0' and operandOne(2) = '0' and operandOne(3) = '1') then
			report(integer'image(-7));
		elsif (operandOne(0) = '0' and operandOne(1) = '1' and operandOne(2) = '0' and operandOne(3) = '1') then
			report(integer'image(-6));
		elsif (operandOne(0) = '1' and operandOne(1) = '1' and operandOne(2) = '0' and operandOne(3) = '1') then
			report(integer'image(-5));
		elsif (operandOne(0) = '0' and operandOne(1) = '0' and operandOne(2) = '1' and operandOne(3) = '1') then
			report(integer'image(-4));
		elsif (operandOne(0) = '0' and operandOne(1) = '1' and operandOne(2) = '1' and operandOne(3) = '1') then
			report(integer'image(-2));
		elsif (operandOne(0) = '1' and operandOne(1) = '1' and operandOne(2) = '1' and operandOne(3) = '1') then
			report(integer'image(-1));
		end if;
	
	elsif (operationOne = "011") then
		if (inNop = '1') then
			report("NOP");
		elsif (inBranch = '0') then
			report("B0");
		elsif (inBranch = '1') then
			report("B1");
		end if;
	end if;

	outRegisterOne <= registerOne;
	outRegisterTwo <= registerTwo;
	outRegisterThree <= registerThree;
	outRegisterFour <= registerFour;
	outNop <= '0';

elsif (stageOne /= 3 and stageTwo /= 3 and stageThree = 3) then

	if (operationThree = "000" or operationThree = "001" or operationThree = "111") then --add/subtract/print

		-- determine destination register
		if (regSelectDestThree = "00") then
			operandOne := registerOne;
		elsif (regSelectDestThree = "01") then
			operandOne := registerTwo;
		elsif (regSelectDestThree = "10") then
			operandOne := registerThree;
		elsif (regSelectDestThree = "11") then
			operandOne := registerFour;
		end if;	

		if (operandOne(0) = '0' and operandOne(1) = '0' and operandOne(2) = '0' and operandOne(3) = '0') then
			report(integer'image(0));
		elsif (operandOne(0) = '1' and operandOne(1) = '0' and operandOne(2) = '0' and operandOne(3) = '0') then
			report(integer'image(1));
		elsif (operandOne(0) = '0' and operandOne(1) = '1' and operandOne(2) = '0' and operandOne(3) = '0') then
			report(integer'image(2));
		elsif (operandOne(0) = '1' and operandOne(1) = '1' and operandOne(2) = '0' and operandOne(3) = '0') then
			report(integer'image(3));
		elsif (operandOne(0) = '0' and operandOne(1) = '0' and operandOne(2) = '1' and operandOne(3) = '0') then
			report(integer'image(4));
		elsif (operandOne(0) = '1' and operandOne(1) = '0' and operandOne(2) = '1' and operandOne(3) = '0') then
			report(integer'image(5));
		elsif (operandOne(0) = '0' and operandOne(1) = '1' and operandOne(2) = '1' and operandOne(3) = '0') then
			report(integer'image(6));
		elsif (operandOne(0) = '1' and operandOne(1) = '1' and operandOne(2) = '1' and operandOne(3) = '0') then
			report(integer'image(7));
		elsif (operandOne(0) = '0' and operandOne(1) = '0' and operandOne(2) = '0' and operandOne(3) = '1') then
			report(integer'image(-8));
		elsif (operandOne(1) = '1' and operandOne(1) = '0' and operandOne(2) = '0' and operandOne(3) = '1') then
			report(integer'image(-7));
		elsif (operandOne(0) = '0' and operandOne(1) = '1' and operandOne(2) = '0' and operandOne(3) = '1') then
			report(integer'image(-6));
		elsif (operandOne(0) = '1' and operandOne(1) = '1' and operandOne(2) = '0' and operandOne(3) = '1') then
			report(integer'image(-5));
		elsif (operandOne(0) = '0' and operandOne(1) = '0' and operandOne(2) = '1' and operandOne(3) = '1') then
			report(integer'image(-4));
		elsif (operandOne(0) = '0' and operandOne(1) = '1' and operandOne(2) = '1' and operandOne(3) = '1') then
			report(integer'image(-2));
		elsif (operandOne(0) = '1' and operandOne(1) = '1' and operandOne(2) = '1' and operandOne(3) = '1') then
			report(integer'image(-1));
		end if;
	
	elsif (operationOne = "011") then
		if (inNop = '1') then
			report("NOP");
		elsif (inBranch = '0') then
			report("B0");
		elsif (inBranch = '1') then
			report("B1");
		end if;
	end if;

	outRegisterOne <= registerOne;
	outRegisterTwo <= registerTwo;
	outRegisterThree <= registerThree;
	outRegisterFour <= registerFour;
	outNop <= '0';
end if;

end process;
end architecture;