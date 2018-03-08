(
SynthDef(\synthx, { arg atk = 0.001, dur = 0.15, freq = 50, amp=10, gate=1;
	var sig;
	sig = BPF.ar(LFSaw.ar(freq*2,3), 10, 1, mul: EnvGen.kr( Env.perc( atk, 0.1, 0.1, 20 ),gate, doneAction: 2 ));
	sig = sig *  amp;
	sig = FreeVerb.ar(sig, 0.003, 100, 20, 1);
	Out.ar(5,sig);
}).add;
)

(
SynthDef(\revsynthx,{
	arg pan = 0, amp = 0.7, mix = 0.3;
	var sig, env;
	sig = In.ar(5,1);
	sig = FreeVerb.ar(sig, mix,10);
	sig = RLPF.ar(sig,700,0.03);
	sig = sig * amp;
	Out.ar(0,Pan2.ar(sig,SinOsc.kr(pan)));

}).add;
)

s.record
l = Synth.new(\revsynthx);
l.set(\pan, 1000);
l.set(\mix, 0.4);
l.set(\amp, 2.2);

(
~synthx= Pbind(*[
		instrument: \synthx,
		delta: 1/1 0,
		dur: Pkey(\delta) * Pfunc({ thisThread.clock.beatDur }),
	freq: Prand([623,490,853,900,933,\r,\r], inf),
	\amp,  Prand([\r,9,8,7,6],inf),
	\gate, Pdef(\gate,1),
]).play;
)


Pdef(\gate,0);