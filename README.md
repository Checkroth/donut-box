# donut-box

A Godot extension of the blender guru donut tutorial.

> "I want to use Blender to make assets for a game in Godot. I've followed the [Donut Tutorial](https://www.youtube.com/playlist?list=PLjEaoINr3zgEPv5y--4MKpciLaoQYZB1Z), now what?"

If you had this thought, you might find this project useful.

Disclaimer that at the time of writing this, I am a novice at both Blender and Godot. If you see a problem or have a suggestion for a better approach, feel free to open an issue.

# The Tutorial

This tutorial is aimed to get a sort of WYSIWYG export of a blender object directly in to a Godot project. I do not think it is the best practice to follow for something larger scale that needs maintainability, but is a helpful step to learning how godot works with blender. It may also be a simpler, more preferrable approach for development of smaller scale projects, like a game jam.

## 1: Starting with Blender

This project assumes that you have followed the [Blender Guru Donut Tutorial]((https://www.youtube.com/playlist?list=PLjEaoINr3zgEPv5y--4MKpciLaoQYZB1Z)).

I suggest you do the whole thing, but you could get away with any step after `Part 5: Shading`. Most of the problems this tutorial addresses will appear after `Part 8: Rendering`. Everything after `Part 10: Lighting` is irrelevant to this project.

All in all, you should have a `.blend` file with your whole donut scene (including all the parts of the scene that might be superflous to the godot project)

## 2: Importing to Godot

There are a lot of guides on how to do this. You can drag and drop, you can export to `.glb`, you can edit the file directly within the godot project space, etc.
I'm using "drag a `.blend` file from your filesystem in to the Godot interface"

### Problems

If you imported your blender scene, a few problems should be immediately apparent.

#### I don't want the whole Scene from blender!

You probably have a plate, a cup of cuttlery, a light, some sort of marble surface, etc...

But for this game, all you really need is the donut. There are two things you can do here:

1. In godot, when you import the scene: check "skip import" for all the assets you don't want.
2. In blender, select the Donut you want and copy it. Open a new blender project and paste the donut (and the sprinkle instances)

I suggest (2), otherwise things will get messy when solving the other problems. We'll still need to do (1) down the road for those sprinkles.

#### Why is the entire shape messed up?

This is one that some may run in to -- of the donut has a bunch of holes in it or otherwise just looks very strange compared to the source in blender, a decent guess is that your *normals* are wrong. You can fix this pretty easily in blender by selecting everything an "recalculate outside normals" (shift-N in Edit Mode).

#### Where are my Sprinkles?

You copied the whole donut and Blender brought over the dependent sprinkles with it. Now you've imported it in to godot and... the original instance of the sprinkles is there, but the donut itself is baren, what gives?

The blender tutorial uses *geometry nodes* for the sprinkles. That means the sprinkles are more of an *effect*, and less of an actual component of your model. They aren't a part of the mesh, and they don't really "exist".

Luckily, Blender's Geometry Nodes have a feature called "Realize Instances". Just pop it right before the "Geometry" output of your geometry nodes -- or so I thought!. You'll notice that you've lost any color randomization you got from the *shaders* for your donut. You've just taken a copy of a single instance and droppe it all over the donut, and everything has gotten much more boring!

You can undo that last step. There are other solutions:

*In blender*, select everything (hotkey `a`) and click `Object -> Apply -> Make Instances Real`. This will realize everything. The geometry node will also still be there and you may notice flickering on the sprinkles -- it's safe to delete the geometry node setup now.

[Michael Jared's Blender-Godot Pipeline video on Geometry Nodes](https://www.youtube.com/watch?v=z0p-PTyaou8)'s video goes in to some detail about why this isn't really a *great* solution, but it's okay for now. If you'd like to learn more about Blender-Godot pipeline, feel free to watch that video and use that tool instead of just realizing everything in the solo donut scene.

Now you can load the donut in Godot, and you should have a proper donut with icing and sprinkles. But something is still funny...

#### Where are my Colors?

This is the biggest head-scratcher for me. Realizing instances for the sprinkles not appropriately applying shaders is one thing, but you might also notice if you just load the donut with the realized sprinkles, the sprinkles don't have *any* color, including the one that you can clearly see in blender!
And if you're anything like me, you are also missing the color of the frosting *and* the texture of the donut itself!

Somehow, only a glimpse of color has made its way in to Godot and everything else is white.

#### Where are my Textures?

Now that the *material* for all of your sprinkles is working, you might notice that the donut itself, which is a *texture*, is still just a matte white.

Textures are a *separate* file from the `.blend` file. If you're working in one big project with godot and blender assets together, this is *probably* fine. But for the limited scope of this tutorial, all we want to do is *take a blender object and drop it as-is in to godot*, without worrying about larger-scale project tooling.

You can *pack* a texture directly in to the `.blend` file, but that functionality is off by default. In *blender*, go to `File -> Export -> Automatically Pack Resources`, and make sure `Automatically Pack Resources` is checked. Save the blender project and add it to godot, and now your donut should have the texture you createad in part 5 of the blender guru tutorial.

You will notice now that the texture file you created in blender is also showing up in the godot project.

#### Where is my Collision Mesh?

Dragging a `.blend` file from the filesystem browser in to your scene will give you an instance of the blend file's scene. This should at this point visually look right, but you'll notice that you're missing something important that the whitebox donut has: A collision shape.

If you try to replace the whole whitebox scene with your blender scene, you'll lose collision. If you try to replace the torus in the whitebox donut scene with your blender scene, it's incredibly unlikely that the existing torus collision shape (which was modeled directly against the torus mesh using godot's `Mesh -> Create Collision Shape` feature) will match your donut.

You could just resize the collision shape to more or less match your donut and call it a day, but that won't help you decide you want something more complex than a slightly deformed but otherwise basic core shape in your game.

## 3: Implementing The Game

You can clone the repository to get a nearly-working version of the game.

The game is simply a hollow 3D cube. Double-clicking will spawn a torus object (a "whitebox donut"), which you can fling around the cube.

In order to make use of your own, cooler donut, you will need to do two things:

1. Create a new scene for your donut, to be used instead of the whitebox donut
2. Replace usage of the whitebox donut with yours
3. Follow-up implementation: Setting important attributes on your imported scene


# Attributions

- [Blender Guru's Donut Tutorial](https://www.youtube.com/playlist?list=PLjEaoINr3zgEPv5y--4MKpciLaoQYZB1Z)
- [Michael Jared's Blender-Godot Pipeline video on Geometry Nodes](https://www.youtube.com/watch?v=z0p-PTyaou8)
- [ALL THE WORK's Blender Geometry Node Export video](https://www.youtube.com/watch?v=qrXZNG4yAa8)
- [Kids Can Code's Camera Gimbal recipe](https://kidscancode.org/godot_recipes/4.x/3d/camera_gimbal/index.html) (for the game implementation)