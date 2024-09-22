#set text(font: "Times New Roman", size: 12pt, hyphenate: false)

#align(center)[
  #set text(size: 18pt)
  #underline[*DRAFT PROJECT PROPOSAL FORM*]

  #image("assets/apu-logo.png", width: 50%)
]

// #align(right)[
//   #move(dx: 20pt, dy: -40pt)[
//     #box(width: 80%)[
//       #align(left)[
//         #grid(
//           columns: (1fr, 1fr),
//           stroke: black,
//           inset: 0.65em,
//           [
//             *Office Record* \
//             Date Received: \
//             Received by whom: \
//           ],
//           [
//             *Receipt* \
//             Student Name: Cheng Yi Heng \
//             Student Number: TP058994 \
//             Received by: \
//             Date: \
//           ],
//         )
//       ]

//       #align(left + bottom)[
//         #stack(
//           dir: ltr,
//           image("assets/apu-logo.png", width: 30%),
//           align(top)[#underline[*DRAFT PROJECT PROPOSAL FORM*]],
//         )
//       ]

//     ]
//   ]
// ]

#text(weight: "bold")[
  #grid(
    columns: (auto, auto, 1fr),
    inset: 0.65em,
    [Proposal ID], [:], [],
    [Supervisor], [:], [],
    [Student Name], [:], [Cheng Yi Heng],
    [Student No], [:], [TP058994],
    [Email Address], [:], [tp058994\@mail.epu.edu.my],
    [Programme Name], [:], [Computer Games Development (CGD)],
    [Title of Project],
    [:],
    [Real-time Global Illumination and Dynamic Compute-Centric Vector Graphics in Games],
  )
]

#pagebreak()

#outline()

#pagebreak()

#set heading(numbering: "1.")
#set par(justify: true, leading: 1em)
#set enum(indent: 1em)
#show par: set block(spacing: 2em)
#show heading: set block(height: 1em)

// #show heading: it => [
//   #stack(dir: ltr)[
//     CHAPTER #counter(heading).display(
//        it.numbering
//      ) #it.body
//   ]
// ]

// #pagebreak()

// = Abstract

// Reflection of what information you have.
// How you do sampling.
// 6 keywords

= Introduction

// Assume the reader has very little knowledge of the subject. Introduce the topic, the sector of business/industry concerned and how the project relates to it. Define the context of the problem and identify the research required to solve it.

Achieving visually rich and interactive content in real-time without compromising performance is a key aspect of immersive gameplay.
This project addresses two major challenges in modern game development: creating dynamic, interactive user experiences and implementing accurate, real-time lighting models.
Tackling these challenges requires three key innovations: a compute-centric vector graphics renderer, a programmable approach for developing interactive content, and a performant global illumination technique.

Vector graphics is a form of computer graphics where visual images are generated from geometric shapes, such as points, lines, curves, and polygons, defined on a Cartesian plane.
Vector graphics are often used in situations where scalability and precision are essential. Common applications include: logos, typography, diagrams, charts, motion graphics, etc.
Examples of softwares that generates or uses vector graphics content includes Adobe Illustrator, Adobe After Effects, Affinity Publisher, Graphite, and many more.
Vector graphics is also used in a wide range of file formats including Scalable Vector Graphics (SVG), Portable Document Format (PDF), TrueType Font (TTF), OpenType Font (OTF), etc.
However, these formats are rarely used in the game industry directly (they are often preprocessed into some other formats, i.e. triangulation or signed distance fields [SDF]), as game engines are often only tailored towards rendering triangles and bitmap textures instead of paths and curves that we see in the vector graphics formats.

Markup languages _(i.e. Hypertext Markup Language [HTML], Extensible Markup Language [XML])_ and style sheets _(i.e. Cascading Style Sheets [CSS])_ has dominated the way developers layout and style contents.
Over the years, technologies like Unity UI Toolkit has evolved in the game industry to adopt the same pattern but with a user friendly editor, allowing users to layout content using a drag and drop manner while styling their content using sliders, color pickers, and input fields @jacobsen2023.
While this improves the user experience of content creation, it lacks the capability of integrating logic and custom contents right inside the user interfaces.
These features are often delegated to the programmer which can lead to unintended miscommunications.

Calculating indirect lighting is extremely computationally expensive, as it requires simulating how light bounces off surfaces and interacts with the environment.
Ray tracing is an algorithm that calculates these light interactions by tracing lights from the camera into the scene, following their paths as they bounce off surfaces and interact with materials.
Each bounce contributes to the final color and lighting of the scene, accounting for reflections, refractions, and scattering.

Unfortunately, ray tracing is too slow for real-time applications, like games.
New techniques like light probes and light baking has been employed to approximate global illumination in modern game engines.
However, the major issue still exists for these techniques --- scalability to larger and more complex scenes.

#pagebreak()

= Problem Statement

// Identify past and current work in the subject area. Outline the key references to other people’s work, indicate for the most pertinent of these how your proposal relates to the ideas they contain.

== Vector Graphics

#figure(caption: [Vector vs Bitmap graphics @arneratermanis2017])[#image("assets/vector-vs-bitmap.png")] <vector-vs-bitmap>

Traditional methods of rendering 2D graphics has always relied on bitmap-based texture mapping @ray2005vector.
While this approach is ubiquitous, it suffers a major drawback of the _pixelation_ effect when being scaled beyond the original resolution @nehab2008random.
Furthermore, creating animations using bitmap graphics can be extremely limited and complex because of the rigid grid-like data structure used to store the data.
Animating bitmap graphics are commonly done through the use of shaders which directly manipulates the individual pixels, or relying on image sequences (flipbooks) which produces an illusion of movement.

Unlike raster graphics, which rely on a fixed grid of pixels, vector graphics are resolution-independent.
This means that it can scale without losing quality (shown in @vector-vs-bitmap).
A vector illustration is composed of multiple _paths_ that define _shapes_ to be painted in a given order @ganacim2014massively.
Each of these individual paths can be traced, altered, or even morphed into a completely different shape which allows for a huge variety of animation techniques.

// TODO: use this in limitations?
Lastly, it is crucial to recognize that while vector graphics offer numerous benefits, it is only suitable for representing precise shapes --- such as fonts, logos, and icons.
In contrast, complex images with intricate details, like photographs of a cat are far better represented using bitmap formats.

== Interactive UI/UX

Most game engines in the market like Unity, Godot, Game Maker, and Unreal Engine uses a WYSIWYG _(What You See Is What You Get)_ editor for creating user interfaces.
WYSIWYG editors are visual centric tools that let users work directly within the presentation form of the content @madje2022programmable.
Users normally layout their contents using a drag and drop editor and then style them using a style-sheet.
To bind interactions or animations towards a content, users would need to label it with a unique tag and query them through code.

Complex content and logic wouldn't be possible through a typical WYSIWYG editor.
For instance, it is virtually impossible to author a custom polygon shape in the editor with custom math based animation based on a time value.
This can only be achieved through code, and is often limited by the application programming interface (API) layer provided by the WYSIWYG editor.
This creates a huge distinction between the game logic and the visual representation that is needed to convey the messages.

While hot-reloading is applicable for the layout and styling (and simple logic to some extend) of a content.
A WYSIWYG editor would not be capable of hot-reloading complex logic as these can only be achieved using code, which in most cases, requires a re-compilation.
This could lead to frustration and lost of creativity due to the slow feedback loop.

In summary, WYSIWYG editors are great for prototyping but suffers from complex animations and interactions.

== Global Illumination

#figure(caption: [Local illumination vs global illumination @jalnionis2022])[#image("assets/global-illumination.png")]

Global illumination has been a notoriously hard problem to solve in computer graphics.
To put things into perspective, global illumination intends to solve the _many to many_ interactions between light, obstacles, and volumes.
In real-time game engines like Unity and Unreal Engine, light probes _(a.k.a radiance probes)_ are placed around the scene to capture lighting information into a cube map, which can be applied to nearby objects.
To smoothen out the transition between probes, objects interpolate between various nearby probes weighted by distance to approximate the global radiance.

Manual placement of probes leads to questions like "how many probes should a scene have?" or "how much probes is a good approximation?".
It ultimately becomes a trade-off between fidelity and performance with more probes resulting in better approximation, while fewer probes improve performance.
This paradoxical issue raises the challenge of finding the optimal balance.
This dilemma underscores the need for smarter, adaptive techniques, ensuring both visual fidelity and efficiency.

#pagebreak()

= Project Aim and Objectives

In this project, we aim to empower creators to create rich and visually appealing content in games in an efficient and streamlined workflow.
This allows the creator to have the luxury of focusing most of their time on quality content rather than the technical details needed to achieve the look or feel that they envisioned.

The objectives of this project are:

+ To utilize Vello, a compute-centric vector graphics renderer for rendering animated and dynamic vector graphics content.
+ To create an intuitive and yet powerful (programmable) workflow for generating animated and dynamic content.
+ To streamline the collaboration between UI/UX developer and gameplay programmers
+ To allow creators to focus on the creative aspects of game development.
+ To implement Radiance Cascades, a technique that provides realistic lighting without sacrificing real-time performance.

#pagebreak()

= Literature Review

== Vector Graphics

Scanline rendering is the process of shooting rays from one side of the screen to the other while coloring pixels in between based on collision checkings with paths in between.
A GPU based scanline rasterization method is proposed by parallelizing over _boundary fragments_ while bulk processing non-boundary fragments as horizontal spans @li2016efficient.
This method allows fully animated vector graphics to be rendered in interactive frame rates.

Apart from scanline rasterization, tesselation method can also be used to convert vector graphics into triangles and then pushed to the GPU for hardware accelerated rasterization.
#cite(<loop2005resolution>, form: "prose") further improved this method by removing the need of approximating curve segments into lines.
Instead, each curve segments is evalulated in a _fragment shader_ which can be calculated on the GPU.
This allows for extreme zoom levels without sacrificing qualities.

Re-tesselation of vector graphics can be computationally expensive, especially when it's inherently a serial algorithm that often needs to be solved on the CPU.
#cite(<kokojima2006resolution>, form: "prose") combines the work of #cite(<loop2005resolution>, form: "prose") with the usage of GPU's stencil buffer by using _triangle fans_ to skip the tesselation process.
This approch, however, does not extend to cubic Bézier segments as they might not be convex.
#cite(<rueda2008gpu>, form: "prose") addressed this issue by implementing a fragment shader that evaluates the implicit equation of the Bézier curve to discard the pixels that fall outside it.
The two-step "Stencil then Cover" (StC) method builds upon all of these work and unified path rendering with OpenGL's shading pipeline --- #text(font: "Consolas")[NV_path_rendering] @kilgard2012gpu.
This library was further improved upon by adding support for transparency groups, patterns, gradients, more color spaces, etc. @batra2015accelerating.
It was eventually integrated into Adobe Illustrator.

// TODO: Vector textures
// TODO: Other solutions as well (Skia, Pathfinder, etc.)

/*
Vector Graphics
- Scanline
- Triangulation
- Stencil then Cover (StC)
- Further improved and applied to real world application like Adobe Illustrator
- ^ Composition, Gradients
- Vector texture
- Massively parallel
*/

== Interactive UI/UX

Beneath all graphical interfaces lies the underlying code that structure and renders the visual elements.
The two most notable approach towards creating user interface frameworks are immediate-mode graphical user interface (IMGUI) and retained-mode graphical user interface (RMGUI).
Some popular IMGUI frameworks includes Dear IMGUI and egui @imgui @egui, while some popular RMGUI frameworks includes Xilem @xilem.
Although powerful, these UI frameworks strongly relies on hardcoded programming.

Enter the web technologies.
Modern browsers typically render UI elements using markup languages like HTML and SVG for structuring the content and style-sheets like CSS for styling them.
The use of markup structures allows developers to fully separate their UI layout from the codebase, simplifying the identification and management of UI components.
With style sheets, developers can create, share, and reuse templates, enhancing consistency and streamlining the design process throughout the application.
// TODO: explore in more detail on each framework
Notable frameworks that utilizes this model includes Unity UI Toolkit, React, Vue, etc @jacobsen2023 @react @vue.

Markup languages also give rise to many WYSIWYG editors.
These editors let users perform drag and drop actions to layout UI for quick prototyping as each components can now be represented using only markup syntax (no code required).

A major limitation of simple markup languages like HTML is that structure changes can only be achieved through code.
For example, if you want a form to disappear after button press, you would need to alter the HTML via code.
Typst offers an alternative towards this problem by introducing programming capabilities into markdown.

Typst is a competitor of LaTeX, designed to simplify the typesetting process with a modern and intuitive approach.
Unlike its predecessors, Typst can directly embed logic.
Using the previous example, developers would only need to pass in a boolean value and Typst will automatically exclude the form from being in the layout at all.
This currently works only in theory, as Typst is primarily a document generator without a user-friendly interface for modifying defined variables.

This is where our project comes in, we aim to provide this interface through Velyst, which couple Typst with Vello for rendering dynamic and programmable content in real-time.

/*
Interactive UI/UX
- From code to markup to css styling
- Research on WYSIWYG editors
- Explore competitors: LaTeX
*/

== Global Illumination

Ray tracing is the de-facto standard for calculating light bounces which contributes to global illumination.
Clever methods like backwards ray tracing has been introduced to speed up the algorithm, but still, it is no where near real-time frame rates @arvo1986backward.
Light baking is introduced to solve this issue, however, it lacks the ability to adapt to runtime scene changes.

Recent studies has shown great results of utilizing neural networks for approximating global illumination @choi2024baking.
// TODO: add more sources to support the claim
However, neural network based methods tend to suffer from unpredictability as the output is highly basd upon the input training data, making it unreliable.

Recent works by #cite(<mcguire2017real>, form: "prose") places light field probes around the scene to encode lighting information from static objects and sample them in real-time.
Dynamic diffuse global illumination (DDGI) further improves this technique by allowing light field probes to update dynamically based on scene changes @majercik2019dynamic.


Radiance cascades improves upon this technique by using a hierarchical structure to place light probes @osborne2024radiance.
This technique is based upon the _penumbra condition_, where closer distance require low angular resolution and high spatial resolution while further distance require high angular resolution and low spatial resolution.

/*
Global illumination
- Backwards Ray Tracing
- Light baking
- Light probes
- Adaptive probes volumes (only capture local volumes)
- Voxell GI
- SDF GI
*/

#pagebreak()

= Deliverables

This project introduces *Velyst*, an innovative approach towards generating interactive content.
It utilizes *Vello*, a compute-centric vector graphics renderer @linebender, and *Typst*, a programmable markup language for typesetting @madje2022programmable.
Velyst provides an extremely streamlined workflow that allows both UI/UX developers and gameplay programmers to easily collaborate in a project. The following are the deliverables that will be implemented in the Velyst library:

+ Allows the user to create interactive content that responds to user inputs in real-time.
+ Allows the user to perform hot-reloading during the development phase.
+ Allows the user to synchronize components with in-app states dynamically.
+ Allows the user to embed logic directly inside Typst scripts for rendering complex scenes.

#figure(caption: "Velyst wave (custom shape + animation) demo")[#image(
    "assets/velyst-wave.png",
    width: 90%,
  )]
#figure(caption: "Velyst user interface demo")[#image(
    "assets/velyst-ui.png",
    width: 90%,
  )]

A library will also be created that utilizes the *Radiance Cascades* technique for rendering real-time 2D global illumination in the Bevy game engine. The following are the deliverables for the Radiance Cascades library:

+ Allows the user to implement global illumination using Radiance Cascades.
+ Allows the user to create adaptive lighting that responds to scene changes in real-time.
+ Allows the user to use arbritrary emmisive shapes to illuminate the scene in game.

#figure(caption: "Radiance cascades demo")[#image(
    "assets/radiance-cascades.png",
    width: 90%,
  )]

// Data Gathering Design:
// 2 techniques

#pagebreak()

= References
#bibliography("citation.bib", style: "apa", title: none)
