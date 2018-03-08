(
SynthDef("hihat2", {arg out = 0, amp = 0.1, att = 0.01, rel = 0.1, ffreq = 15000, pan = 0;
	var env, snd;
	env = Env.perc(att, rel,  amp).kr(doneAction: 2);
	snd = WhiteNoise.ar;
	snd = HPF.ar(in: snd, freq: ffreq, mul: env);
	snd = FreeVerb.ar(snd, 0.1, 10, 10);
	Out.ar(out, Pan2.ar(snd, SinOsc.ar(2)));
}).add;
)

(
~hat = Pbind(
	\instrument, "hihat2",
	\dur, 1/8,
	\att, 0.01,
	\rel, Pfunc({~pot3.linlin(0,1023,0.001,1)}),
	\sinfreq,Bjorklund(2,8) * 100,
	\glissf, 2,
	\amp, 0.03,
	\pan,0
).play;
)
~hat.stop;

(
~hat2 = Pbind(
	\instrument, "hihat2",
	\dur, 1/16,
	\att, 0.01,
	\rel, 0.01,
	\sinfreq,100 ,
	\glissf, 2,
	\amp, Pbjorklund(3,8) *0.1,
	\pan,0.2
).play;
)

~hat2.stop;