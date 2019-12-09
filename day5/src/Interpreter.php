<?php
declare(strict_types=1);

function getValue(&$memory, $index, $parameter, $relativeBase) {
	switch ($parameter) {
		case 0:
			return $memory[$index];
		case 1:
			return $index;
		case 2:
			return $memory[$relativeBase + $index];
	}
}

function interpret($reader, $writer) {
	$memory = array_map('intval', explode(",", $reader()));
	$pointer = 0;
	$relativeBase = 0;

	while (true) {
		$operation = $memory[$pointer] % 100;
		$parameter = $memory[$pointer] / 100;

		$index1 = $memory[$pointer+1];
		$index2 = $memory[$pointer+2];
		$index3 = $memory[$pointer+3];

		$val1 = getValue($memory, $index1, $parameter % 10, $relativeBase);
		$val2 = getValue($memory, $index2, ($parameter/10) % 10, $relativeBase);

		switch ($operation) {
			case 1:
				$memory[$index3] = $val1 + $val2;
				$pointer += 4;
				break;
			case 2:
				$memory[$index3] = $val1 * $val2;
				$pointer += 4;
				break;
			case 3:
				$memory[$index1] = intval($reader());
				$pointer += 2;
				break;
			case 4:
				$writer($val1);
				$pointer += 2;
				break;
			case 5:
				$pointer = ($val1 != 0) ? $val2: $pointer + 3;
				break;
			case 6:
				$pointer = ($val1 == 0) ? $val2: $pointer + 3;
				break;
			case 7:
				$memory[$index3] = ($val1 < $val2)? 1 : 0;
				$pointer += 4;
				break;
			case 8:
				$memory[$index3] = ($val1 == $val2)? 1 : 0;
				$pointer += 4;
				break;
			case 9:
				$relativeBase += $index1;
				$pointer += 2;
				break;
			case 99:
				return;
			default:
				echo "INVALID OPCODE: ".$operation."\n";
				return;
		}
	}
}

function strToReader($str) {
	$index = 0;
	$input = explode(";", $str);

	return function() use ($input, &$index) {
		return $input[$index++];
	};
}

function writer($str) {
	echo $str."\n";
}
