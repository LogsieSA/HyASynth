s.boot;

// #IHateMyDAW :) 28/04/26
// Mutable Instruments Elements, the way Emilie Gillet, my crush, intended the module to be used, incorrectly. 
// Needs mi-Ugens to work, see https://github.com/v7b1/mi-UGens

~hhcnineohnine = Buffer.read(s, "HHCDA.WAV").bufnum; //0 (N.B CHANGE THESE TO YOUR OWN SAMPLES AND WRITE THE PRINTED VALUE HERE!)
~hhonineohnine = Buffer.read(s, "HHODA.WAV").bufnum; //1 (N.B CHANGE THESE TO YOUR OWN SAMPLES AND WRITE THE PRINTED VALUE HERE!)
(
SynthDef(\spectralhhc, {
	arg bufnum1 = 0, bufnum2 = 1, rate = 1,  gate = 0, pitch = 48, strength = 0.5, cont = 0.25,
	bow_lvl = 0.5, blow_lvl = 0, str_lvl = 0, flow = 0.5, mal = 0,
	bow_t = 0.1, blow_t = 0.1, str_t = 0.1, geom = 0.001, bright = 0.5, damp = 0.6, pos = 0.5, space = 0.4, model = 0,
	amp = 0.5, rel = 4, atk = 0.4;
	var siggy, env;

	env = EnvGen.ar(Env.perc(atk, rel), doneAction:2);
	siggy = MiElements.ar(PlayBuf.ar(1, bufnum1, rate), PlayBuf.ar(1, bufnum2, rate) , 1, pitch, strength, cont, bow_lvl, blow_lvl, str_lvl, flow, mal, bow_t, blow_t, str_t, geom, bright, damp, pos, space, model) * amp;
	Out.ar(0, siggy!2 * env);
}).add;
)

y = Pdef(\m, Pbind(\instrument, \spectralhhc, \dur, 2, \strength, 0.4, \bow_lvl, 0, \blow_lvl, 0.35, \model, 2, \mal, 0.15, \str_lvl, 0.3, \space, 0.6, \rel, 4, \rate, 0.004, \damp, 0.6, \geom, 0.73, \pitch, Pseq([38,44,48],inf), \bright, 0.9, \cont, 0.7,  \flow, 0.15, \pos, 0.4, \amp, 1, \str_t, 0.45));
y.play;
