import sys

def path_to_root(galaxy, start):
	price = 0
	d = dict()
	while start in galaxy:
		start = galaxy[start]
		price += 1
		d[start] = price
	return d

def path_length(galaxy, start, end):
	seen = set()
	minimum = float('inf')
	p1 = path_to_root(galaxy, start)
	p2 = path_to_root(galaxy, end)
	for key in list(p1.keys()) + list(p2.keys()):
		v1 = p1.get(key, float('inf'))
		v2 = p2.get(key, float('inf'))
		minimum = min(v1+v2, minimum)
	return minimum - 2

def main():
	galaxy = dict()
	for frm, to in map(lambda s: s.strip().split(')'), sys.stdin.readlines()):
		galaxy[to] = frm
	print(path_length(galaxy, 'YOU', 'SAN'))

if __name__ == '__main__':
	main()
