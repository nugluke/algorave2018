(
SynthDef(\panometer, {
	arg out = 0, midi = 60, amp = 0.2, cf = 1000, pan = 0, agu = 0, grav =0.5 ;
	var snd, env;
	snd = In.ar(4,1);

	Out.ar(0, Pan2.ar(snd,SinOsc.kr(pan)));
}).add;
)

~pano = Synth.new(\panometer);
~pano.set(\pan,100);