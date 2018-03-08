
(
SynthDef("ch", {arg out = 0, amp = 0.1, pan = 0, gate = 1;
	var env, snd;
	env = EnvGen.ar(Env.perc(Rand(0.001,0.002),Rand(0.02,0.04),4),gate, doneAction:2);
	snd = (WhiteNoise.ar(1) * 0.2) + (PinkNoise.ar(Rand(1,2)) *0.1) +(LFTri.ar(Rand(100,110)) *0.2)  +(SinOsc.ar(Rand(115,1000)) * 0.4)  *amp;
	snd = snd * env * Rand(0.005,0.006) * 20;
	Out.ar(6, snd);
}).add;
)

(
~ch = Pbind(
	\instrument, "ch",
	\dur, Prand([1, 2 , 0.1],inf),
	\amp, 0.5,
	\gate, Pdef(\gate, 1),
).play;
)

(
SynthDef(\revch,{
	arg pan = 0, mix = 0.3;
	var sig, env, wn = 0;
	sig = In.ar(6,1);
	sig = FreeVerb.ar(sig, mix,1);
	sig = sig * XLine.kr(0.1,2.5,10);
	//wn = WhiteNoise.ar * (SinOsc.ar(Rand(0.05,0.2)) +3) * XLine.kr(0.000001,0.0002,5);
	sig = sig + wn;
	Out.ar(0,Pan2.ar(sig,SinOsc.kr(pan)));

}).add;
)

Pdef(\gate, 0)
s.record
r = Synth.new(\revch);
r.set(\pan, 0.3);
r.set(\mix, 1);
