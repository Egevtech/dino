module game

pub struct GameInstance {
pub mut:
	score u64
}

pub fn GameInstance.new() GameInstance {
	return GameInstance{
		score: 0
	}
}
