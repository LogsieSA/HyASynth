s.boot;
/// #IHateMyDAW 20/04/26
// An evolving drone Synth with an adjustable ASR envelope, inspired by the Moffenzeef Stargazer, named after the Johannesburg Library Gardens park.







(
SynthDef(\libraryGardens, {
	arg pitch = 110, mOscVol = 1, detune = 0, amp = 1, subOscVol = 0, f1Cut = 16000, flowCut = 5500,
	f1Res = 0.0, lfo1Rate = 0.00001, alias = 18000, redux = 16,
	lfo2Rate = 0.00001,  lfo3Rate = 0.01, mainWave = 0, gate = 1,
	f2Cut = 16000, f2Res = 0, atk = 45, susLvl = 1, rel = 10, subOscWave = 0, suboscshittiness = 0.1,
	flowLvl = 0.05, bus = 0, flowType = 0, rt = 5;
	var lfo1, lfo2, lfo3, siggy, subosc, main, mainWaveArr,
	f1, f2, subOscArr, suboscshite, env, flow, flowArr, final;

	env = EnvGen.ar(Env.asr(atk, susLvl, rel), gate, doneAction:2);
	lfo1 = (SinOsc.kr(lfo1Rate).exprange(pitch + 50, f1Cut));
	lfo2 = (SinOsc.kr(lfo2Rate).exprange(pitch + 50, f2Cut));
	lfo3 = SinOsc.kr(lfo3Rate).exprange(mainWave, 2);
	suboscshite = detune + SinOsc.kr(suboscshittiness).exprange(detune, 5);
	
	
	mainWaveArr = [
		SinOsc.ar(pitch),
		Saw.ar(pitch),
		Pulse.ar(pitch)
	];
	subOscArr = [
		SinOsc.ar(pitch + suboscshite),
		Saw.ar(pitch + suboscshite),
		Pulse.ar(pitch + suboscshite),
	];
	flowArr = [
		WhiteNoise.ar(),
		PinkNoise.ar(),
		BrownNoise.ar(),
		GrayNoise.ar()
	];
	
	main = SelectX.ar(lfo3, mainWaveArr) * mOscVol;
	subosc = SelectX.ar(subOscWave, subOscArr) * SinOsc.kr(lfo3Rate).exprange(0.1, subOscVol);
	flow = SelectX.ar(flowType, flowArr) * SinOsc.kr(lfo3Rate).exprange(0.01, flowLvl);
	flow = LPF.ar(flow, flowCut);
	
	f1 = MoogLadder.ar(main + subosc, lfo1 + 50, f1Res);
	f2 = MoogLadder.ar(Decimator.ar(f1, alias, redux), lfo2 + 50, f2Res);
	final = Pan2.ar(f2);
	siggy = (NHHall.ar((final + flow), rt) * amp);

	Out.ar(bus, siggy * env);
}).add;
)


// An example config for a drone

(
x = Synth(\libraryGardens);
x.set(\amp, 0.7);
x.set(\detune, pi/3);
x.set(\mOscVol, 0.5, \subOscVol, 0.5);
x.set(\lfo1Rate, 0.15);
x.set(\lfo2Rate, 0.057);
x.set(\lfo3Rate, 0.15);
x.set(\mainWave, 1);
x.set(\subOscWave, 1);
x.set(\suboscshittiness, pi/2);
x.set(\alias, 12200);
x.set(\redux, 14);
x.set(\f1Res, 0.6);
x.set(\f1Cut, 400);
x.set(\f2Res, 0);
x.set(\pitch, 120);
x.set(\f2Cut, 900);
x.set(\gate, 1);
x.set(\flowLvl, 0.04);
x.set(\flowType, 1);
)
