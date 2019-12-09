<?php

declare(strict_types=1);
include '/app/src/Interpreter.php';

if (isset($_GET['stdin'])) {
	// Execute via HTTP request.
	$reader = strToReader($_GET['stdin']);
	interpret($reader, 'writer');
} else {
	// Execute directly using `php problem.php`
	interpret('readline', 'writer');
}
