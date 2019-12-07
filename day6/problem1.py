import sys

def total_depth(galaxy, start, value):
	return sum(total_depth(galaxy, to, value+1) for to in galaxy.get(start, [])) + value

def main():
	galaxy = dict()
	for frm, to in map(lambda s: s.strip().split(')'), sys.stdin.readlines()):
		galaxy[frm] = galaxy.get(frm, [])
		galaxy[frm].append(to)
	print(total_depth(galaxy, 'COM', 0))

if __name__ == '__main__':
	main()
