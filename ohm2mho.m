% Simple helper function for converting kOhms to µS
function signal = ohm2mho(signal)
	signal = (1 / (signal * 1e3)) * 1e6;
end
