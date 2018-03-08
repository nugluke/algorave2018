(
SynthDef("marimba", {arg freq= 220, amp = 0.4, out= 0, pan = 0;
	var snd, env;
	env = EnvGen.kr(Env.linen(0.015, 1, 1.5), levelScale: amp, doneAction: 2);
	snd = BPF.ar(
		in: Saw.ar(0),
		freq: freq,
		rq: 0.02);
	snd = BLowShelf.ar(snd, 220, 0.81, 6);
	snd = FreeVerb.ar(snd, 0.1, 10,10) * amp * 3;
	Out.ar(out, Pan2.ar(snd,SinOsc.kr(pan)));
}).add;
)

(
~f_marimba2 = Pbind(
    \instrument, \marimba,
	\dur, 1/16,
	\amp, Pbjorklund(Pfunc({~pot4.linlin(0,1023,1,3)}),8)*0.2,
	\freq, Pseq([79.5.midicps, 78.5.midicps],inf),
	\pan, 0,
).play;
)
~f_marimba2.stop

(
~f_marimba3 = Pbind(
    \instrument, \marimba,
	\dur, 1/16,
	\amp, Pbjorklund(3,7)*0.09,
	\freq, Pseq([79.5.midicps, 79.5.midicps,78.midicps,78.midicps,77.midicps,77.midicps],inf),
	\pan, 9,
).play;
)
~f_marimba3.stop
