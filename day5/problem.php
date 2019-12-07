<?php

function interpret($reader) {
	$memory = array_map('intval', explode(",", $reader()));
	$pointer = 0;

	while (true) {
		$operation = $memory[$pointer] % 100;
		$parameter = $memory[$pointer] / 100;

		$index1 = $memory[$pointer+1];
		$index2 = $memory[$pointer+2];
		$index3 = $memory[$pointer+3];

		$val1 = ($parameter % 10 == 1) ? $index1: $memory[$index1];
		$val2 = (($parameter / 10) % 10 == 1) ? $index2: $memory[$index2];

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
				echo $memory[$index1]."\n";
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
			case 99:
				return;
			default:
				echo "INVALID OPCODE: ".$operation."\n";
				return;
		}
	}
}


if (isset($_GET['stdin'])) {
	// Execute via HTTP request.
	$index = 0;
	$input = explode(";", $_GET['stdin']);

	$mockedSTDIN = function() use ($input, &$index) {
		return $input[$index++];
	};

	interpret($mockedSTDIN);
} else {
	// Execute directly using `php problem.php`
	interpret('readline');
}