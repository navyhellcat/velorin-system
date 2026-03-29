De-AI Writing Voice: Contrastive Negation, "Not X, But Y," and How to Prompt It Out
Executive summary
The highly recognizable "NOT THIS, BUT THAT" pattern is a real, named linguistic/rhetorical construction. In rhetoric it overlaps with antithesis (contrast framed in parallel structure) and related figures; in linguistics it overlaps with contrastive negation / corrective but constructions and, in some contexts, metalinguistic negation (negation used to object to a prior wording/implicature rather than to deny truth-conditions). [1]
LLMs overproduce this structure because it's a high-frequency template in training corpora; it is locally "safe" under next-token prediction; and post-training for helpfulness (e.g., RLHF) and safety tends to reward "balanced, clarifying, reframe-y" prose—exactly the rhetorical posture where "not X, but Y" thrives. Evidence from generation research shows that decoding choices can push model outputs toward blandness and repetition (a close cousin of "template reuse"), and alignment research shows preference optimization can bias toward persuasive/agreeable "convincing writing," which often favors tidy contrast frames. [2]
The broader "AI writing voice" is not just vibes: multiple peer‑reviewed studies find systematic linguistic/stylometric differences between human and LLM-generated text (including clustering by model, and measurable feature differences). Separately, people's heuristics for spotting AI text are unreliable, and can even be exploited—so mitigation is best treated as style control, not "beat the detector." [3]
Deliverable: this report ends with a paste-ready instruction document designed to suppress the "not X, but Y" pattern (and other common "AI voice" scaffolds) while preserving clarity and usefulness.
Assumption note: I searched your connected Google Drive (including internal style docs such as Trey.OutputStandards, Claude_Context_Profile_v1.2, BOT.README.FIRST.BOOTUP, Velorin.Company.Operating.Standards). None appeared to be a dedicated "de-AI voice" prompt; they do, however, strongly reinforce directness and no-filler, which is compatible with the mitigation approach below.
Defining the pattern
What the pattern is, structurally
The prototypical form is:
* not X, but Y (or not just X, but Y; not only X, but also Y)
Functionally, it is a contrastive / corrective move: the writer first negates an alternative construal (X) and then asserts a preferred construal (Y). In rhetoric, this is a classic contrast device, often treated as a subtype/realization of antithesis—juxtaposing strongly contrasting ideas in balanced structures. [4]
In linguistics, the family is often discussed under contrastive negation (negation paired with affirmation such that the affirmative element replaces the negated one) and corrective but sentences. [5]
Alternate names you will see (and how they relate)
Below are common labels across fields; they partly overlap but are not perfectly synonymous:
Antithesis (rhetoric). A figure of speech contrasting opposing ideas in parallel/balanced structure. Many "not X but Y" sentences are antithetical in form and effect. [4]
Contrastive negation (linguistics). A broader category where a negated element and an affirmed element are combined so the affirmed element replaces the negated one; "not X but Y" is often treated as archetypal. [6]
Corrective but / corrective coordination (syntax/semantics). Focuses on "but" as a corrective conjunction in sentences like "Max doesn't eat spinach but chard," analyzing how negation interacts with contrast and alternatives. [7]
Metalinguistic negation (pragmatics). Negation used to object to an earlier utterance on grounds like wording, implication, register, or presupposition—often illustrated with "not X but Y" patterns (e.g., correcting emphasis or connotation). [8]
Dirimens copulatio (classical rhetoric taxonomy). A named figure described as balancing a statement with a contrary/qualifying one, explicitly associated with "not x, but y" style constructions in rhetorical pedagogy. [9]
Negative parallelisms / negative parallelism (editorial diagnostics). Wikipedia's AI‑cleanup guidance explicitly flags parallel constructions with "not … but …" / "Not only … but …" / "It's not just about … it's …" as common in LLM writing because they create an easy "balanced and thoughtful" feel. [10]
A precise working definition for mitigation work
For prompt-engineering purposes, treat the target as:
Contrastive negation template: any sentence whose information structure is "negate an alternative framing (X) before asserting a preferred framing (Y), typically via not / not just / not only + but (also) / rather / instead."
This operational definition matches both the linguistic characterization (negated alternative + asserted replacement) [11] and the practical "AI tell" as documented by Wikipedia editors and writing analysts. [12]
Why LLMs overuse it
Training data frequency and template learning
LLMs inherit what's abundant. The "not X but Y / not only X but also Y" family is common in genres that dominate public web text—op-eds, speeches, marketing copy, explainers—because it reliably produces emphasis and a sense of sophistication. Wikipedia's AI-writing guidance and multiple practitioner analyses specifically note that LLMs reach for these parallel contrast templates to sound balanced. [13]
Next-token prediction makes "not → but" a low-risk continuation
Mechanistically, once a model emits a negator like "not," it has entered a high-probability corridor of continuations ("just," "only," "but," "rather," "instead"), because those continuations are statistically frequent completions in training data. This is a special case of a broader phenomenon: generation can collapse into "safe" high-likelihood continuations that read bland or repetitive even if each sentence is locally fluent. [14]
Decoding and "global voice" failures
The "AI voice" impression is often cumulative: any single "not X but Y" sentence is fine; repeated use across paragraphs becomes a stylistic fingerprint. Work on neural text generation shows that likelihood-driven decoding can produce text that is bland and exhibits distributional differences from human text; changing sampling methods can change these outcomes. This supports the idea that part of "AI voice" is a decoding-and-distribution artifact, not just a single bad phrase. [15]
Alignment and guardrails reward a "clarifying reframe" posture
Post-training methods explicitly optimize for human preference (instruction-following, helpfulness, and safety). The standard RLHF recipe is to train a reward model from preference judgments and optimize the policy to produce preferred responses. [16]
But preference signals can overweight "convincingness" and "tone alignment." Research on sycophancy shows RLHF-trained assistants can shift toward agreeing with or affirming user beliefs because such responses are more likely to be preferred, even when not most truthful. That same preference pressure also tends to reward prose that sounds reasonable, balanced, and helpful—an ecological niche where contrastive reframes ("not X but Y") are cheap and effective. [17]
A parallel line of alignment work (e.g., constitutional/self-critique approaches) explicitly trains critique–revision loops and "objections" to problematic content; that training can also normalize a rhetorical stance of "first disallow / negate, then reframe," which has structural similarity to contrastive negation (even when the surface pattern differs). [18]
How this becomes recognizable as "AI voice" in the wild
This is now explicit in editorial and cultural discourse: Wikipedia's AI writing field guide highlights negative parallelisms as a common LLM pattern. [10] Mainstream commentary likewise points to constructions like "It's not just X, it's also Y," alongside em-dash-heavy "punchiness" and triads, as AI tells. [19]
flowchart LR
  A[Training corpus: speeches, explainers, marketing, essays] --> B[Next-token learning stores high-frequency templates]
  B --> C[Decoding favors high-probability continuations]
  C --> D[RLHF/alignment rewards "helpful, balanced, persuasive" style]
  D --> E[Rhetorical posture: clarify by reframing + soft correction]
  E --> F[Template reuse: "not X but Y" / "not only X but also Y"]
  F --> G[Overuse accumulates into recognizable "AI voice"]
The broader "AI writing voice" and key research debates
Stylometric fingerprints and detectability
Several peer‑reviewed studies find measurable differences between human and LLM-generated text at scale, including stylometric clustering by model and greater uniformity within model-generated samples. [20] Cross‑linguistic stylometric work similarly reports distinguishable distributions between ChatGPT‑generated and human texts using features like function words and POS bigrams. [21]
This is relevant to "not X but Y" because the pattern is a surface marker of a deeper phenomenon: LLM outputs often show higher template reuse, more uniform rhetorical scaffolding, and more consistent "editor voice," which stylometry can pick up even when any single phrase is edited away. [22]
Human perception, anthropomorphism, and trust
People are not reliably good at spotting AI text—and their heuristics can be manipulated. A large PNAS study reports that participants could not detect AI-generated self-presentations beyond chance, and that their intuitive heuristics (e.g., contractions, first-person pronouns) were flawed and exploitable. [23]
Anthropomorphic cues matter: experiments on LLM interfaces show that modality (speech + text) and first-person phrasing ("I") can increase anthropomorphism and shift trust/accuracy perceptions. [24] A broader PNAS perspective argues that LLM-based conversational systems can mimic human communication compellingly, raising design, deployment, and policy questions around "anthropomorphic conversational agents." [25]
The detection-and-evasion arms race
Practically: "sound less like AI" should not be equated with "beat detectors." Reporting on AI detection highlights common detector strategies (e.g., perplexity/burstiness heuristics) and emphasizes frequent failure modes and the ongoing arms race. [26]
This matters to mitigation strategy: the goal is a controlled human editorial voice (clarity + specificity + natural rhythm), not random noise injection.
Curated sources
Most credible academic sources
The table is curated for (a) primary/official access points and (b) influence or centrality in their sub-areas (linguistics of negation; alignment shaping assistant style; stylometric distinctiveness/detection; anthropomorphism/trust). Core sources include top venues and official hosts (Oxford Academic, Springer Nature, PNAS/PMC, ACL/IBM, NeurIPS, PMLR, arXiv, and major labs). [27]
Title
	Authors (first author et al.)
	Year
	Venue / host
	Why it matters for "AI voice" + "not X but Y"
	Direct full URL
	Metalinguistic Negation (chapter)
	Ana Maria Martins[28]
	2020
	Oxford Academic[29]
	High-authority overview of metalinguistic vs descriptive negation; explicitly addresses contrastive/corrective negation distinctions.
	https://academic.oup.com/edited-volume/41364/chapter/352592990
	Metalinguistic negation from an informational perspective
	Pierre Larrivée[30]
	2017
	Glossa[31]
	Open-access analysis of metalinguistic negation/correction; useful for precise linguistic framing of "negate then repair."
	https://www.glossa-journal.org/article/doi/10.5334/gjgl.403/
	Contrastive negation and the theory of alternatives
	Chris Bruno[32]
	2017
	SALT[33]
	Formal semantics of contrastive negation; ties "not X but Y" to focus alternatives—helpful for a precise definition.
	https://journals.linguisticsociety.org/proceedings/index.php/SALT/article/view/27.59
	Syntax of negation in corrective but sentences
	Danfeng Wu[34]
	2025
	Springer Nature[35]
	Modern syntactic account of "corrective but"; helps distinguish everyday correction from rhetorical antithesis.
	https://link.springer.com/article/10.1007/s11049-025-09689-x
	Training language models to follow instructions with human feedback
	Long Ouyang[36] et al.
	2022
	NeurIPS[37]
	Canonical RLHF reference; explains the preference-optimization pipeline that can shape an "assistant voice."
	https://proceedings.neurips.cc/paper/2022/hash/b1efde53be364a73914f58805a001731-Abstract-Conference.html
	Constitutional AI: Harmlessness from AI Feedback
	Yuntao Bai[38] et al.
	2022
	Anthropic[39]
	Shows critique→revision training that can normalize "objection then reframe" rhetoric (a cousin of contrastive negation).
	https://www.anthropic.com/index/constitutional-ai-harmlessness-from-ai-feedback
	Towards Understanding Sycophancy in Language Models
	Mrinank Sharma[40] et al.
	2023
	Anthropic[39] / ICLR
	Empirically connects RLHF to preference for agreeable/convincing responses—relevant to why "balanced reframes" get rewarded.
	https://www.anthropic.com/news/towards-understanding-sycophancy-in-language-models
	A large-scale comparison of human-written versus ChatGPT-generated essays
	Steffen Herbold[41] et al.
	2023
	Nature[42] (Scientific Reports)
	Large-scale linguistic comparison showing systematic differences between human and model essays—evidence for an "AI voice."
	https://www.nature.com/articles/s41598-023-45644-9
	Stylometric comparisons of human versus AI-generated creative writing
	James O'Sullivan[43]
	2025
	Nature[42] (HSS Communications)
	Stylometry finds clustering and within-model uniformity—supports "voice fingerprint" framing beyond single phrases.
	https://www.nature.com/articles/s41599-025-05986-3
	Human heuristics for AI-generated language are flawed
	Maurice Jakesch[44] et al.
	2023
	Proceedings of the National Academy of Sciences[45]
	Shows humans can't reliably spot AI text and rely on manipulable heuristics—important for mitigation goals and evaluation.
	https://pmc.ncbi.nlm.nih.gov/articles/PMC10089155/
	Reputable non-academic sources explicitly naming the pattern
These sources use either an explicit label ("contrastive negation") or explicitly call out the structure as a common AI tell ("It's not just X, it's Y"), which makes them useful for operational mitigation rules. [46]
Source
	What it calls it / how it describes it
	Direct full URL
	GC AI (Cecilia Ziniti)
	Names it "contrastive negation" and defines it as "not X but Y" / "not just … but …" overuse. [47]
	https://gc.ai/blog/ai-writing-pattern-to-know-contrastive-negation
	Wikipedia: Signs of AI writing
	Flags "Negative parallelisms" involving "not … but …" / "Not only … but …" as common in LLM writing. [10]
	https://archive.ph/2025.12.18-213332/https%3A/en.wikipedia.org/wiki/Wikipedia%3ASigns_of_AI_writing
	Blake Stockton ("Don't Write Like AI")
	Calls out "It's not X, it's Y" as an AI-favored negation structure. [48]
	https://www.blakestockton.com/dont-write-like-ai-1-101-negation/
	TIME[49]
	Describes "AI hallmarks," naming "It's not just X, it's also Y" among recognizable habits. [50]
	https://time.com/7371832/looks-like-ai-writing-online-insult/
	Forbes[51]
	Explicitly calls out "It's not just about X, it's about Y" as an AI-overused contrast-reframe. [52]
	https://www.forbes.com/sites/jodiecook/2025/09/08/the-10-giveaway-signs-of-ai-writing-wikipedia-reveals/
	FlowingData
	Quotes Wikipedia guidance and frames it as observed patterns; useful contextualization (and cautions against treating single tells as proof). [53]
	https://flowingdata.com/2025/10/20/signs-of-ai-writing-on-wikipedia/
	Examples of the pattern in AI-style outputs with linguistic annotations
These are representative (synthetic) examples that mirror the common LLM habit; they are not quotations from a specific system output.
1. "This isn't a feature update; it's a shift in how teams work."
Annotation: negative-first reframe ("not X, but Y" implicit), antithetical parallelism; persuasive stance.
2. "We're not just collecting data—we're building a model of behavior."
Annotation: negative parallelism ("not just X, Y"); emphatic "upgrade" of scope; common in marketing prose.
3. "The goal isn't speed, but clarity."
Annotation: contrastive but with ellipsis; focus alternatives (speed vs clarity); replacive reading.
4. "It's not about compliance; it's about trust."
Annotation: classic rhetorical contrast-reframe; presents a "deeper meaning" frame (often perceived as AI-y when repeated). [54]
5. "Not a bug. Not a quirk. A design choice."
Annotation: multi-sentence negative parallelism; accumulative negation + climactic affirmative; high salience when clustered.
6. "Don't think of it as a cost, but as an investment."
Annotation: corrective reclassification; pragmatic repositioning; common persuasive trope.
7. "This isn't merely better automation—it's a new operating model."
Annotation: scalar negation ("isn't merely"); emphatic "upgrade"; close cousin of "not just."
8. "Not because it's easy, but because it's necessary."
Annotation: classic antithetical cadence; legitimate rhetorically, but becomes an AI tell when overused.
Search terms and next steps for deeper literature search
For academic databases (Google Scholar, ACL Anthology, PubMed, ACM DL), combine one term from each column:
Negation/correction (linguistics)
"contrastive negation", "metalinguistic negation", "corrective but", "replacive coordination", "negation and alternatives", "focus alternatives"
LLM style / fingerprints
"stylometry ChatGPT", "LLM stylistic fingerprint", "machine-generated text detection", "Burrows' Delta LLM", "discourse marker overuse LLM", "rhetorical structure LLM"
Alignment & assistant voice
"RLHF style", "preference model persuasion", "sycophancy RLHF", "helpful harmless tone"
Editorial field guides
"negative parallelisms AI writing", "Wikipedia signs of AI writing negative parallelisms"
A practical next step that stays grounded: use the linguistics terms to precisely define what you're banning (so you don't accidentally ban all negation), and use the stylometry papers to design a checklist that targets clusters of tells (not single tells). [55]
Instruction document to mitigate "AI voice" in any chatbot
Below is a paste-ready instruction designed to suppress the "not X, but Y" family and the broader rhetorical scaffolding that tends to accompany AI voice. It is written to be model-agnostic and operational (scan → rewrite). It intentionally does not try to "beat detectors"; it tries to produce clean human editorial prose.
ANTI–AI-VOICE STYLE DIRECTIVE (SYSTEM INSTRUCTIONS)

Goal: Write like a competent human editor in plain English. Prioritize clarity, specificity, and clean rhythm. Do not sound like an assistant, a teacher, or marketing copy.

Hard bans (unless the user is explicitly correcting a misconception they stated):
- Do NOT use contrastive negation / negative parallelisms:
  - "not X but Y"
  - "it's not X, it's Y"
  - "not just X, (but) Y"
  - "not only X, but also Y"
  - "it's not about X; it's about Y"
If you drafted one, rewrite as a direct positive statement (say Y without negating X).

Also avoid common AI scaffolds:
- No "In today's world…", "Let's dive in…", "Here's what you need to know…", "It's important to note…", "In conclusion/Overall…"
- Avoid excessive transitions: "moreover/furthermore/in addition/on the other hand"
- Avoid em-dash punchiness and slogan cadence. Prefer straightforward clauses.
- Avoid neat triads as a habit ("X, Y, and Z") unless the content truly requires three.

Production method:
1) Draft the answer normally.
2) Run a "de-AI pass" before final output:
   - Remove/replace every banned contrastive-negation template.
   - Delete filler signposting and summary restatements.
   - Replace vague claims with concrete specifics (numbers, names, constraints, examples) where possible.
   - Vary sentence length naturally (mix short + medium; avoid a uniform rhythm).
3) Output only the revised text. No commentary about edits. No apologies. No "as an AI".

Default voice: concise, matter-of-fact, human. Use bullet points only when the user asks for a list or when structure is necessary.
Why this works (briefly): it targets the exact "negative parallelism" pattern documented as a common LLM tell [10] while also preventing the surrounding "assistant scaffolding" repeatedly flagged in editorial guides and mainstream commentary. [56]
Full URL list
Copyable list of URLs referenced above (papers, definitions, and major non-academic sources):
https://www.britannica.com/art/antithesis
https://www.merriam-webster.com/dictionary/antithesis

https://link.springer.com/article/10.1007/s11049-025-09689-x
https://journals.linguisticsociety.org/proceedings/index.php/SALT/article/view/27.59
https://www.degruyterbrill.com/document/doi/10.1515/9783110682588-008/html
https://varieng.helsinki.fi/series/volumes/19/silvennoinen/index.html
https://academic.oup.com/edited-volume/41364/chapter/352592990
https://plato.stanford.edu/archIves/sum2025/entries/negation/
https://www.glossa-journal.org/article/doi/10.5334/gjgl.403/
https://rhetoric.byu.edu/Figures/D/DIRIMENS%20COPULATIO-v.HTM

https://proceedings.neurips.cc/paper/2022/hash/b1efde53be364a73914f58805a001731-Abstract-Conference.html
https://www.anthropic.com/index/constitutional-ai-harmlessness-from-ai-feedback
https://www.anthropic.com/news/towards-understanding-sycophancy-in-language-models
https://openreview.net/forum?id=rygGQyrFvH

https://www.nature.com/articles/s41598-023-45644-9
https://www.nature.com/articles/s41599-025-05986-3
https://www.nature.com/articles/s41599-025-06341-2
https://pmc.ncbi.nlm.nih.gov/articles/PMC10089155/
https://pmc.ncbi.nlm.nih.gov/articles/PMC12146756/
https://research.google/pubs/believing-anthropomorphism-examining-the-role-of-anthropomorphic-cues-on-user-trust-in-large-language-models/

https://research.ibm.com/publications/gltr-statistical-detection-and-visualization-of-generated-text
https://huggingface.co/papers/1906.04043
https://huggingface.co/papers/2301.11305
https://proceedings.mlr.press/v202/kirchenbauer23a.html

https://gc.ai/blog/ai-writing-pattern-to-know-contrastive-negation
https://www.blakestockton.com/dont-write-like-ai-1-101-negation/
https://time.com/7371832/looks-like-ai-writing-online-insult/
https://www.forbes.com/sites/jodiecook/2025/09/08/the-10-giveaway-signs-of-ai-writing-wikipedia-reveals/
https://flowingdata.com/2025/10/20/signs-of-ai-writing-on-wikipedia/
https://archive.ph/2025.12.18-213332/https%3A/en.wikipedia.org/wiki/Wikipedia%3ASigns_of_AI_writing

https://gptzero.me/news/perplexity-and-burstiness-what-is-it/
https://www.wired.com/story/ai-detection-chat-gpt-college-students
________________


[1] [4] [28] [30] [33] [36] https://www.britannica.com/art/antithesis
https://www.britannica.com/art/antithesis
[2] [14] [15] [38] https://arxiv.gg/abs/1904.09751
https://arxiv.gg/abs/1904.09751
[3] https://www.nature.com/articles/s41598-023-45644-9
https://www.nature.com/articles/s41598-023-45644-9
[5] [6] [11] [45] https://www.degruyterbrill.com/document/doi/10.1515/9783110682588-008/html
https://www.degruyterbrill.com/document/doi/10.1515/9783110682588-008/html
[7] [34] [43] [55] https://link.springer.com/article/10.1007/s11049-025-09689-x
https://link.springer.com/article/10.1007/s11049-025-09689-x
[8] [27] [35] [37] https://academic.oup.com/edited-volume/41364/chapter/352592990
https://academic.oup.com/edited-volume/41364/chapter/352592990
[9] https://rhetoric.byu.edu/Figures/D/DIRIMENS%20COPULATIO-v.HTM
https://rhetoric.byu.edu/Figures/D/DIRIMENS%20COPULATIO-v.HTM
[10] [12] [13] [31] [42] [54] https://archive.ph/2025.12.18-213332/https%3A/en.wikipedia.org/wiki/Wikipedia%3ASigns_of_AI_writing
https://archive.ph/2025.12.18-213332/https%3A/en.wikipedia.org/wiki/Wikipedia%3ASigns_of_AI_writing
[16] https://proceedings.neurips.cc/paper/2022/hash/b1efde53be364a73914f58805a001731-Abstract-Conference.html
https://proceedings.neurips.cc/paper/2022/hash/b1efde53be364a73914f58805a001731-Abstract-Conference.html
[17] [40] https://www.anthropic.com/news/towards-understanding-sycophancy-in-language-models
https://www.anthropic.com/news/towards-understanding-sycophancy-in-language-models
[18] [51] https://www.anthropic.com/index/constitutional-ai-harmlessness-from-ai-feedback
https://www.anthropic.com/index/constitutional-ai-harmlessness-from-ai-feedback
[19] [44] [50] https://time.com/7371832/looks-like-ai-writing-online-insult/
https://time.com/7371832/looks-like-ai-writing-online-insult/
[20] [22] https://www.nature.com/articles/s41599-025-05986-3
https://www.nature.com/articles/s41599-025-05986-3
[21] https://pmc.ncbi.nlm.nih.gov/articles/PMC10411719/
https://pmc.ncbi.nlm.nih.gov/articles/PMC10411719/
[23] https://pmc.ncbi.nlm.nih.gov/articles/PMC10089155/
https://pmc.ncbi.nlm.nih.gov/articles/PMC10089155/
[24] [41] [49] https://research.google/pubs/believing-anthropomorphism-examining-the-role-of-anthropomorphic-cues-on-user-trust-in-large-language-models/
https://research.google/pubs/believing-anthropomorphism-examining-the-role-of-anthropomorphic-cues-on-user-trust-in-large-language-models/
[25] [32] [39] https://pubmed.ncbi.nlm.nih.gov/40378006/
https://pubmed.ncbi.nlm.nih.gov/40378006/
[26] https://www.wired.com/story/ai-detection-chat-gpt-college-students
https://www.wired.com/story/ai-detection-chat-gpt-college-students
[29] [48] https://www.blakestockton.com/dont-write-like-ai-1-101-negation/
https://www.blakestockton.com/dont-write-like-ai-1-101-negation/
[46] [47] https://gc.ai/blog/ai-writing-pattern-to-know-contrastive-negation
https://gc.ai/blog/ai-writing-pattern-to-know-contrastive-negation
[52] [56] https://www.forbes.com/sites/jodiecook/2025/09/08/the-10-giveaway-signs-of-ai-writing-wikipedia-reveals/
https://www.forbes.com/sites/jodiecook/2025/09/08/the-10-giveaway-signs-of-ai-writing-wikipedia-reveals/
[53] https://flowingdata.com/2025/10/20/signs-of-ai-writing-on-wikipedia/
https://flowingdata.com/2025/10/20/signs-of-ai-writing-on-wikipedia/
[VELORIN.EOF]
