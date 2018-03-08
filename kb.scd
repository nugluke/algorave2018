(
SynthDef("kickb", {arg out = 0, amp = 0.1, att = 0.1, rel = 0.4, freq1 = 50, freq2=55, pan = 0, gate=1;
	var env, snd;
	env = EnvGen.ar(Env.perc(att,rel),gate, doneAction:2);
	snd = SinOsc.ar(freq1) + SinOsc.ar(freq2) *0.2 * amp;
	Out.ar(out, Pan2.ar(snd, pan));
}).add;
)

(
~som = Pbind(
	\instrument, "kickb",
	\dur, 1/4,
	\amp, Pbjorklund(3,8)*1,
	\gate, Pdef(\gate,1),
).play;
)
Pdef(\gate,0)

~som.stop;