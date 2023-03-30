const randomSentence = (output='full') => {

var verbs, nouns, adjectives, adverbs, preposition, rnd;

nouns = ["bird", "clock", "boy", "plastic", "duck", "teacher", "girl", "professor", "hamster", "dog"];
verbs = ["kicked", "ran", "flew", "dodged", "sliced", "rolled", "died", "breathed", "slept", "killed"];
adjectives = ["beautiful", "lazy", "professional", "lovely", "dumb", "rough", "soft", "hot", "vibrating", "slimy"];
adverbs = ["slowly", "elegantly", "precisely", "quickly", "sadly", "humbly", "proudly", "shockingly", "calmly", "passionately"];
preposition = ["down", "into", "up", "on", "upon", "below", "above", "through", "across", "towards"];

rnd = Math.floor(Math.random() * 10);

fullSentence = "The " + adjectives[rnd] + " " + nouns[rnd] + " " + adverbs[rnd] + " " + verbs[rnd] + " because some " + nouns[rnd] + " " + adverbs[rnd] + " " + verbs[rnd] + " " + preposition[rnd] + " a " + adjectives[rnd] + " " + nouns[rnd] + " which, became a " + adjectives[rnd] + ", " + adjectives[rnd] + " " + nouns[rnd] + ".";

adTitle = "The " + adjectives[rnd] + " " + nouns[rnd] + " " + adverbs[rnd] + " " + verbs[rnd];

return output=='full'?fullSentence:adTitle+' Ad';
}

console.log(randomSentence());
