sub countsub($big, $little) { +$big.comb: ~$little }
sub getLayer($data, $layerSize, $i) {substr($data, ($i*$layerSize)..(($i+1)*$layerSize-1))}

my $layerSize = 25*6;
my $data = slurp;

sub solve1($data, $layerSize) {
	my $min = 100000;
	my $answer = 0;
	loop (my $i=0; $i < $data.chars/$layerSize; $i++) {
		my $layer = getLayer($data, $layerSize, $i);
		my $count = countsub($layer, "0");
		if ($count < $min) {
			$min = $count;
			$answer = countsub($layer, "1") * countsub($layer, "2");
		}
	}
	return $answer
}

sub solve2($data, $layerSize) {
	my @answer = ();
	loop (my $i=0; $i < $layerSize; $i++) {
		my $value = 2;
		loop (my $l=0; $l < $data.chars/$layerSize; $l++) {
			my $layer = getLayer($data, $layerSize, $l);
			my $pixel = substr($layer, $i, 1);
			if ($pixel != '2') {
				$value = $pixel;
				last;
			}
		}
		@answer.append: $value;
	}
	return @answer
}


say solve1($data, $layerSize);

my $out = join("", solve2($data, $layerSize)).subst(/0/, ".", :g).subst(/1/, "#", :g);
say getLayer($out, 25, 0);
say getLayer($out, 25, 1);
say getLayer($out, 25, 2);
say getLayer($out, 25, 3);
say getLayer($out, 25, 4);
say getLayer($out, 25, 5);
