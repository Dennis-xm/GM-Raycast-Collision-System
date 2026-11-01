# GameMaker Raycast Collision System
Written by the man, the myth, the legend; me! Dennneh!

This is a raycast collision based system mainly built for the Forms N' Shapes Team, inspired by the Rayman UbiArt platformers.
It is still in development and will change! But it will likely not turn into some grand huge library.

The solution uses geometry built out of lines to create colliders. Raycasts are used to interact with these colliders.
Whilst this is more complicated than your simple AABB system, it also allows for some fun stuff like directionally ambiguous collisions and animated collisions!
I recommend giving the different files a read to get a general understanding of the system, most functions should be maybe a bit too commentated.
The project also includes different test usages of the system, looking through that stuff could prove useful too.

If you want to import the system into your own project you just have to include the scripts in the "Collisions/Core" folder (or the entire "Collision" folder for the extra stuff),
along with the objects "obj_collider_static" and "obj_collider_dynamic". The rest is entirely optional, but still free for the taking.

The project uses an MIT License, meaning that you get to use this all for free as long as you keep those little license headers included in the main files.

Good Luck! Hope you enjoy vector math!
