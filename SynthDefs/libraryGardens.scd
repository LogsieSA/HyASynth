s.boot;
/// #IHateMyDAW 20/04/26
// An evolving drone Synth with an adjustable ASR envelope, inspired by the Moffenzeef Stargazer, named after the Johannesburg Library Gardens park.







(
SynthDef(\libraryGardens, {
	arg pitch = 110, mOscVol = 1, detune = 0, amp = 1, subOscVol = 0, f1Cut = 16000,
	f1Res = 0.0, flowCut = 5500, alias = 18000, redux = 16, rt= 5, sus = 1,
	lfo1Rate = 0.1, lfo2Rate = 0.1,  lfo3Rate = 0.01, mainWave = 0, gate = 1,
	f2Cut = 16000, f2Res = 0, atk = 45, rel = 10, subOscWave = 0, suboscshittiness = 0.1, flowLvl = 0.05;
	var lfo1, lfo2, lfo3, siggy, subosc, main, mainWaveArr,
	f1, f2, subOscArr, suboscshite, env, flow, final;

	env = EnvGen.ar(Env.asr(atk, sus, rel), gate, doneAction:2);
	lfo1 = (SinOsc.kr(lfo1Rate).exprange(pitch + 50, f1Cut));
	lfo2 = (SinOsc.kr(lfo2Rate).exprange(pitch + 50, f2Cut));
	lfo3 = SinOsc.kr(lfo3Rate).exprange(mainWave, 2);
	suboscshite = detune + SinOsc.kr(suboscshittiness).exprange(detune, 5);
	flow = PinkNoise.ar() * SinOsc.kr(lfo3Rate).exprange(0.0001, flowLvl);
	flow = LPF.ar(flow, flowCut);
	mainWaveArr = [
		SinOsc.ar(pitch),
		Saw.ar(pitch),
		Pulse.ar(pitch)
	];
	subOscArr = [
		SinOsc.ar(pitch + suboscshite),
		Saw.ar(pitch + suboscshite),
		Pulse.ar(pitch + suboscshite)
	];


	main = SelectX.ar(lfo3, mainWaveArr) * mOscVol;
	subosc = SelectX.ar(subOscWave, subOscArr) * SinOsc.kr(lfo3Rate).exprange(0.1, subOscVol);


	f1 = MoogLadder.ar(main + subosc, lfo1 + 50, f1Res);
	f2 = MoogLadder.ar(Decimator.ar(f1, alias, redux), lfo2 + 50, f2Res);
	final = NHHall.ar(Pan2.ar(f2), rt);
	siggy = ((final + flow) * amp);

	Out.ar(0, siggy * env);
}).add;
)

// An example config

(
x = Synth(\libraryGardens);
x.set(\amp, 0.7);
x.set(\detune, -pi);
x.set(\mOscVol, 0.6, \subOscVol, 0.5);
x.set(\lfo1Rate, 0.25);
x.set(\lfo2Rate, 0.017);
x.set(\lfo3Rate, 0.05);
x.set(\mainWave, 1);
x.set(\subOscWave, 0);
x.set(\suboscshittiness, 1);
x.set(\alias, 901);
x.set(\redux, 4);
x.set(\f1Res, 0);
x.set(\f1Cut, 400);
x.set(\f2Res, 0.7);
x.set(\pitch, 95);
x.set(\f2Cut, 1200);
x.set(\gate, 1);
x.set(\flowLvl, 0.01);
)
