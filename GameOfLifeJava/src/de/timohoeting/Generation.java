package de.timohoeting;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

import de.timohoeting.Position;

public class Generation {

	private Set<Position> currentGen = new HashSet<Position>();
	private ArrayList<Position> NEIGHBOURS = new ArrayList<Position>();

	public Generation() {
		NEIGHBOURS.add(new Position(-1, -1));
		NEIGHBOURS.add(new Position(-1, 0));
		NEIGHBOURS.add(new Position(-1, 1));
		NEIGHBOURS.add(new Position(0, -1));

		NEIGHBOURS.add(new Position(0, 1));
		NEIGHBOURS.add(new Position(1, -1));
		NEIGHBOURS.add(new Position(1, 0));
		NEIGHBOURS.add(new Position(1, 1));
	}

	public void setAlive(int x, int y) {
		Position p = new Position(x, y);
		currentGen.add(p);
	}

	private boolean setContains(Position p) {
		if (currentGen.contains(p)) {
			return true;
		}
		return false;
	}

	private boolean checkNeighbourLivingPoint(Position p) {
		int count = 0;
		for (int i = 0; i < NEIGHBOURS.size(); i++) {
			if (setContains(new Position(p.x + NEIGHBOURS.get(i).x, p.y
					+ NEIGHBOURS.get(i).y))) {
				count++;
			}
		}
		switch (count) {
		case 2:
			if (setContains(p)) {
				return true;
			}
			return false;
		case 3:
			return true;
		default:
			return false;
		}
	}

	private ArrayList<Position> checkNeighbourDeathPoint(Position p) {
		ArrayList<Position> temp = new ArrayList<Position>();
		for (int i = 0; i < NEIGHBOURS.size(); i++) {
			if (checkNeighbourLivingPoint(new Position(p.x
					+ NEIGHBOURS.get(i).x, p.y + NEIGHBOURS.get(i).y))) {
				temp.add(new Position(p.x + NEIGHBOURS.get(i).x, p.y
						+ NEIGHBOURS.get(i).y));
			}
		}
		return temp;
	}

	public void backToTheFuture() {
		Set<Position> nextGen = new HashSet<Position>();
		for (Position p : currentGen) {
			if (setContains(p)) {
				nextGen.add(p);
			}
			ArrayList<Position> temp = checkNeighbourDeathPoint(p);
			if (temp.size() > 0) {
				for (Position t : temp) {
					nextGen.add(t);
				}
			}
		}
		currentGen.clear();
		currentGen = nextGen;
		System.out.println("Neue Generation erzeugt.");
	}

}
