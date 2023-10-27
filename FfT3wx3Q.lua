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
								if (Enum == 0) then
									local B = Inst[3];
									local K = Stk[B];
									for Idx = B + 1, Inst[4] do
										K = K .. Stk[Idx];
									end
									Stk[Inst[2]] = K;
								else
									Env[Inst[3]] = Stk[Inst[2]];
								end
							elseif (Enum <= 2) then
								Stk[Inst[2]] = Inst[3] ~= 0;
							elseif (Enum == 3) then
								if (Stk[Inst[2]] == Inst[4]) then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							elseif (Stk[Inst[2]] == Stk[Inst[4]]) then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						elseif (Enum <= 7) then
							if (Enum <= 5) then
								for Idx = Inst[2], Inst[3] do
									Stk[Idx] = nil;
								end
							elseif (Enum == 6) then
								local A = Inst[2];
								Stk[A](Unpack(Stk, A + 1, Inst[3]));
							else
								Stk[Inst[2]] = Inst[3];
							end
						elseif (Enum <= 8) then
							do
								return;
							end
						elseif (Enum == 9) then
							Stk[Inst[2]] = Stk[Inst[3]];
						else
							Stk[Inst[2]] = {};
						end
					elseif (Enum <= 16) then
						if (Enum <= 13) then
							if (Enum <= 11) then
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
							elseif (Enum == 12) then
								if Stk[Inst[2]] then
									VIP = VIP + 1;
								else
									VIP = Inst[3];
								end
							else
								for Idx = Inst[2], Inst[3] do
									Stk[Idx] = nil;
								end
							end
						elseif (Enum <= 14) then
							local A = Inst[2];
							local Results = {Stk[A]()};
							local Limit = Inst[4];
							local Edx = 0;
							for Idx = A, Limit do
								Edx = Edx + 1;
								Stk[Idx] = Results[Edx];
							end
						elseif (Enum == 15) then
							local A = Inst[2];
							Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
						else
							VIP = Inst[3];
						end
					elseif (Enum <= 19) then
						if (Enum <= 17) then
							local A = Inst[2];
							local B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
						elseif (Enum == 18) then
							Stk[Inst[2]] = Stk[Inst[3]];
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
					elseif (Enum <= 20) then
						Stk[Inst[2]] = Env[Inst[3]];
					elseif (Enum == 21) then
						Stk[Inst[2]] = {};
					else
						Stk[Inst[2]]();
					end
				elseif (Enum <= 33) then
					if (Enum <= 27) then
						if (Enum <= 24) then
							if (Enum > 23) then
								local A = Inst[2];
								local Results, Limit = _R(Stk[A](Unpack(Stk, A + 1, Inst[3])));
								Top = (Limit + A) - 1;
								local Edx = 0;
								for Idx = A, Top do
									Edx = Edx + 1;
									Stk[Idx] = Results[Edx];
								end
							else
								Stk[Inst[2]][Inst[3]] = Stk[Inst[4]];
							end
						elseif (Enum <= 25) then
							Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
						elseif (Enum == 26) then
							if (Stk[Inst[2]] == Stk[Inst[4]]) then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						else
							Stk[Inst[2]] = Inst[3];
						end
					elseif (Enum <= 30) then
						if (Enum <= 28) then
							local A = Inst[2];
							Stk[A] = Stk[A](Stk[A + 1]);
						elseif (Enum > 29) then
							if Stk[Inst[2]] then
								VIP = VIP + 1;
							else
								VIP = Inst[3];
							end
						elseif not Stk[Inst[2]] then
							VIP = VIP + 1;
						else
							VIP = Inst[3];
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
						local A = Inst[2];
						Stk[A] = Stk[A](Unpack(Stk, A + 1, Top));
					else
						VIP = Inst[3];
					end
				elseif (Enum <= 39) then
					if (Enum <= 36) then
						if (Enum <= 34) then
							local A = Inst[2];
							local B = Stk[Inst[3]];
							Stk[A + 1] = B;
							Stk[A] = B[Inst[4]];
						elseif (Enum > 35) then
							Stk[Inst[2]] = Env[Inst[3]];
						elseif not Stk[Inst[2]] then
							VIP = VIP + 1;
						else
							VIP = Inst[3];
						end
					elseif (Enum <= 37) then
						Env[Inst[3]] = Stk[Inst[2]];
					elseif (Enum == 38) then
						Stk[Inst[2]]();
					else
						do
							return;
						end
					end
				elseif (Enum <= 42) then
					if (Enum <= 40) then
						if (Stk[Inst[2]] == Inst[4]) then
							VIP = VIP + 1;
						else
							VIP = Inst[3];
						end
					elseif (Enum == 41) then
						local A = Inst[2];
						Stk[A] = Stk[A](Stk[A + 1]);
					else
						Stk[Inst[2]] = Inst[3] ~= 0;
					end
				elseif (Enum <= 43) then
					Stk[Inst[2]] = Stk[Inst[3]][Inst[4]];
				elseif (Enum == 44) then
					local A = Inst[2];
					Stk[A](Unpack(Stk, A + 1, Inst[3]));
				else
					local B = Inst[3];
					local K = Stk[B];
					for Idx = B + 1, Inst[4] do
						K = K .. Stk[Idx];
					end
					Stk[Inst[2]] = K;
				end
				VIP = VIP + 1;
			end
		end;
	end
	return Wrap(Deserialize(), {}, vmenv)(...);
end
VMCall("LOL!2F3O0003043O007461736B03043O007761697403043O0067616D6503083O0049734C6F6164656403073O0073796E617073652O033O0073796E03073O007265717565737403043O00756E633103043O00682O747003043O00756E6332030C3O00682O74705F7265717565737403043O00756E633303083O0073796E617061736503093O0053796E617073652058030B3O005363726970742D57617265030C3O00555750204578656375746F7203103O006964656E746966796578656375746F72028O0003063O00612O7365727403403O00556E73752O706F72746564206578656375746F723F3A204D692O73696E67202F204D69736D61746368696E6720526571756573742046756E6374696F6E28732903043O007761726E03093O006578656375746F723A03073O00506C6163654964026O00564003083O0066417A364E4A4744026O00364003083O006376386D34523854022O00902B2C27044203083O0044635A63476A7232022O00E0A918D3074203083O0075424D347A457154022O009010B49AF94103093O0061386136764A696D68023O008AD8BDC34103043O002O6C2O62022O0040432O88F54103043O005443615503373O00682O7470733A2O2F7261772E67697468756275736572636F6E74656E742E636F6D2F417173796E2F776F726B73706163652F6D61696E2F030A3O006C6F6164737472696E6703073O00482O7470476574030A3O0077726F6E67322E6C756103053O007072696E74030F3O006C6F6164737472696E6720646F6E6503083O0046612O6C2E6C756103073O006474682E6C756103073O006C2O622E6C756103093O005463616E552E6C756100B53O0012143O00013O00202B5O00022O00163O000100010012143O00033O0020225O00042O00293O0002000200061E5O00013O0004105O00012O000A5O0004001214000100063O00061E0001000E00013O0004103O000E0001001214000100063O00202B00010001000700100B3O00050001001214000100093O00061E0001001400013O0004103O00140001001214000100093O00202B00010001000700100B3O000800010012140001000B3O00100B3O000A0001001214000100073O00100B3O000C00012O0005000100013O00202B00023O000D00061E0002002800013O0004103O0028000100202B00023O000800061D00020028000100010004103O0028000100202B00023O000A00061D00020028000100010004103O0028000100202B00023O000C00061D00020028000100010004103O0028000100121B0001000E3O0004103O003D000100202B00023O000800061E0002003300013O0004103O0033000100202B00023O000A00061D00020033000100010004103O0033000100202B00023O000C00061D00020033000100010004103O0033000100121B0001000F3O0004103O003D000100202B00023O000800061D0002003C000100010004103O003C000100202B00023O000A00061D0002003C000100010004103O003C000100202B00023O000C00061E0002003D00013O0004103O003D000100121B000100103O001214000200114O001300020001000300061E0003004300013O0004103O0043000100061A00030044000100020004103O0044000100121B000300123O001214000400134O0009000500013O00121B000600144O002C000400060001001214000400153O00121B000500164O0009000600014O002C000400060001001214000400033O00202B00040004001700260300040053000100180004103O005300012O002A000500013O001225000500193O0004103O007F0001002603000400580001001A0004103O005800012O002A000500013O0012250005001B3O0004103O007F00010026030004005D0001001C0004103O005D00012O002A000500013O0012250005001D3O0004103O007F0001002603000400620001001E0004103O006200012O002A000500013O0012250005001F3O0004103O007F000100260300040067000100200004103O006700012O002A000500013O001225000500213O0004103O007F00010026030004006C000100220004103O006C00012O002A000500013O001225000500233O0004103O007F000100260300040071000100240004103O007100012O002A000500013O001225000500253O0004103O007F000100121B000500263O001214000600273O001214000700033O0020220007000700282O0009000900053O00121B000A00294O002D00090009000A2O0018000700094O000F00063O00022O00160006000100010012140006002A3O00121B0007002B4O0009000800044O002C000600080001001214000500153O00121B000600174O0009000700044O002C00050007000100121B000500263O0012140006001D3O00061E0006009000013O0004103O00900001001214000600273O001214000700033O0020220007000700282O0009000900053O00121B000A002C4O002D00090009000A2O0018000700094O000F00063O00022O0016000600010001001214000600213O00061E0006009C00013O0004103O009C0001001214000600273O001214000700033O0020220007000700282O0009000900053O00121B000A002D4O002D00090009000A2O0018000700094O000F00063O00022O0016000600010001001214000600233O00061E000600A800013O0004103O00A80001001214000600273O001214000700033O0020220007000700282O0009000900053O00121B000A002E4O002D00090009000A2O0018000700094O000F00063O00022O0016000600010001001214000600253O00061E000600B400013O0004103O00B40001001214000600273O001214000700033O0020220007000700282O0009000900053O00121B000A002F4O002D00090009000A2O0018000700094O000F00063O00022O00160006000100012O00083O00017O00", GetFEnv(), ...);
