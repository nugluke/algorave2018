
(
SynthDef(\kick3, {
    |out = 0, pan = 0, amp = 0.5|
    var body, bodyFreq, bodyAmp;
    var pop, popFreq, popAmp;
    var click, clickAmp;
    var snd;

    bodyFreq = EnvGen.ar(Env([261, 120, 51], [0.035, 0.08], curve: \exp));
    bodyAmp = EnvGen.ar(Env.linen(0.005, 0.1, 0.3), doneAction: 2);
    body = SinOsc.ar(bodyFreq) * bodyAmp;
    popFreq = XLine.kr(750, 261, 0.02);
    popAmp = EnvGen.ar(Env.linen(0.001, 0.02, 0.001)) * 0.15;
    pop = SinOsc.ar(popFreq) * popAmp;
    clickAmp = EnvGen.ar(Env.perc(0.001, 0.01)) * 0.15;
    click = LPF.ar(Formant.ar(910, 4760, 2110), 3140) * clickAmp;

    snd = body + pop + click;
    snd = snd.tanh;

	Out.ar(out, Pan2.ar(snd, SinOsc.kr(pan), 0.4));
}).add;
)

(
~f_kicky = Pbind(
	\instrument, "kick3",
	\dur, 1/2,
	\amp, 0.01,
	\tom, Pseq([51], inf),
	\pan, Pfunc({~pot2.linlin(0,1023,0,20.0)})
).play;
)

~f_kicky.play
~f_kicky.stop
~f_kicky.mute