part of game;

Buffer wall = new Buffer(
	/*Vertices*/
	[
		-0.5, -0.5, 0.0,
		-0.5, 0.5, 0.0,
		0.5, 0.5, 0.0,
		0.5, -0.5, 0.0,
	],
	/*Idices*/
	[
		0, 1, 2,
		0, 2, 3,
	],
	/*Colors*/
	[],
	/*Texture coords*/
	[
		0.0, 1.0,
		0.0, 0.0,
		1.0, 0.0,
		1.0, 1.0,
	]
);

Buffer floor = new Buffer(
	/*Vertices*/
	[
		-0.5, 0.0, 0.5,
		-0.5, 0.0, -0.5,
		0.5, 0.0, -0.5,
		0.5, 0.0, 0.5,
	],
	/*Idices*/
	[
		0, 1, 2,
		0, 2, 3,
	],
	/*Colors*/
	[],
	/*Texture coords*/
	[
		0.0, 1.0,
		0.0, 0.0,
		1.0, 0.0,
		1.0, 1.0,
	]
);

var playerVertices =
[
-0.5, 0.0, 0.5,
-0.5, 0.0, -0.5,
0.5, 0.0, -0.5,
0.5, 0.0, 0.5,
];

var playerIndices =
[
0, 1, 2,
0, 2, 3,
];

var playerColors = [];

List<Buffer> playerSwing = new List<Buffer>(8);
List<Buffer> playerWalk = new List<Buffer>(6);

void createPlayerBuffer () {

	for(int i = 0; i < 8; i++) {
		playerSwing[i] = new Buffer(playerVertices, playerIndices, playerColors,
		[
			0.125*i.toDouble(), 0.5,
			0.125*i.toDouble(), 0.0,
			0.125*i.toDouble()+0.125, 0.0,
			0.125*i.toDouble()+0.125, 0.5,
		]);
	}

	for(int i = 0; i < 6; i++) {
		playerWalk[i] = new Buffer(playerVertices, playerIndices, playerColors,
		[
			0.125*i.toDouble(), 1.0,
			0.125*i.toDouble(), 0.5,
			0.125*i.toDouble()+0.125, 0.5,
			0.125*i.toDouble()+0.125, 1.0,
		]);
	}
}

//List<Buffer> player = [
//	new Buffer(playerVertices, playerIndices, playerColors,
//	[
//		0.0, 1.0,
//		0.0, 0.0,
//		0.125, 0.0,
//		0.125, 1.0,
//	])
//];