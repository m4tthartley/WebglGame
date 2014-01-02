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