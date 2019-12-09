<?php
declare(strict_types=1);

include '/app/src/Interpreter.php';

use PHPUnit\Framework\TestCase;

final class InterpreterTest extends TestCase
{
    public function runInterpreter($input)
    {
        $reader = strToReader($input);
        $output = "";
        $mockedWriter = function($s) use (&$output) {
            $output .= $s.";";
        };
        interpret($reader, $mockedWriter);
        return $output;
    }

    public function testReturnNumberInTheMiddle(): void
    {
        $want = "1125899906842624;";
        $got = $this->runInterpreter("104,1125899906842624,99");
        $this->assertEquals($want, $got);
    }

    public function testOutput16digitNumber(): void
    {
        $want = 17;
        $got = $this->runInterpreter("1102,34915192,34915192,7,4,7,99,0");
        $this->assertEquals($want, strlen($got));
    }

    public function testQuine(): void
    {
        $want = "109;1;204;-1;1001;100;1;100;1008;100;16;101;1006;101;0;99;";
        $got = $this->runInterpreter("109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99");
        $this->assertEquals($want, $got);
    }

    public function testCopyInputToOutput(): void
    {
        $want = "-1234;";
        $got = $this->runInterpreter("3,0,4,0,99;-1234");
        $this->assertEquals($want, $got);
    }

    public function testIsEqualTo8(): void
    {
        $this->assertEquals("1;", $this->runInterpreter("3,9,8,9,10,9,4,9,99,-1,8;8"));
        $this->assertEquals("0;", $this->runInterpreter("3,9,8,9,10,9,4,9,99,-1,8;1234"));
        $this->assertEquals("1;", $this->runInterpreter("3,3,1108,-1,8,3,4,3,99;8"));
        $this->assertEquals("0;", $this->runInterpreter("3,3,1108,-1,8,3,4,3,99;1234"));
    }

    public function testIsLessThan8(): void
    {
        $this->assertEquals("0;", $this->runInterpreter("3,9,7,9,10,9,4,9,99,-1,8;8"));
        $this->assertEquals("1;", $this->runInterpreter("3,9,7,9,10,9,4,9,99,-1,8;7"));
        $this->assertEquals("0;", $this->runInterpreter("3,3,1107,-1,8,3,4,3,99;8"));
        $this->assertEquals("1;", $this->runInterpreter("3,3,1107,-1,8,3,4,3,99;7"));
    }

	public function testToBool(): void
    {

        $this->assertEquals("0;", $this->runInterpreter("3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9;0"));
        $this->assertEquals("1;", $this->runInterpreter("3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9;7"));
        $this->assertEquals("0;", $this->runInterpreter("3,3,1105,-1,9,1101,0,0,12,4,12,99,1;0"));
        $this->assertEquals("1;", $this->runInterpreter("3,3,1105,-1,9,1101,0,0,12,4,12,99,1;7"));
    }

	public function testLessOrEqualOrGreater(): void
    {
    	$code = "3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99";

        $this->assertEquals("999;", $this->runInterpreter($code.";7"));
        $this->assertEquals("1000;", $this->runInterpreter($code.";8"));
        $this->assertEquals("1001;", $this->runInterpreter($code.";9"));
    }
}
