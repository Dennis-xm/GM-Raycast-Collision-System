# GameMaker Raycast Collision System
Written by the man, the myth, the legend; me! Dennneh!

This is a raycast collision based system mainly built for the Forms N' Shapes Team, inspired by the Rayman UbiArt platformers.
It is still in development and will change! But it will likely not turn into some grand huge library.

The solution uses geometry built out of lines to create colliders. Raycasts are used to interact with these colliders.
Whilst this is more complicated than your simple AABB system, it also allows for some fun stuff like directionally ambiguous collisions and animated collisions!
I recommend giving the different files a read to get a general understanding of the system, most functions should be maybe a bit too commentated.
The project also includes different test usages of the system, looking through that stuff could prove useful too.

If you want to import the system into your own project you just have to look inside of the "Libraries" group in the Assets Browser.
Inside is more than just the collision system (which you are of course allowed to use too), but the bare essentials of the collision system exist
inside of "Libraries/Collision/Core", including scripts, two objects, and a sprite for those objects.
I also recommend nabbing some debug objects from the "Debug" group. You will very likely benefit from using them when incorporating the system into your own project.
The "Examples" group is also fully okay to grab from, they are meant to be both proof-of-concepts and teaching tools for the collision system.

The project uses an MIT License, meaning that you get to use this all for free as long as you keep those little license headers included in the main files.
All art and sound effect assets inside the project use a CC0 license, meaning you don't need any license or to give any credit, it's in the public domain!
Any potential music files/compositions inside the project use a CC BY license, meaning you can use it as long as you give credit to me (Dennneh).

Good Luck! Hope you enjoy vector math!
