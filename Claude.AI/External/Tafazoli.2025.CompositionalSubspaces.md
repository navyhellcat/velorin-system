# Building compositional tasks with shared neural subspaces
**Source:** https://www.nature.com/articles/s41586-025-09805-2
**Authors (PDF metadata):** Sina Tafazoli
**Pages:** 36

---

## Page 1
Article
Building compositional tasks with shared
neural subspaces

https://doi.org/10.1038/s41586-025-09805-2   Sina Tafazoli1 ✉, Flora M. Bouchacourt1, Adel Ardalan1, Nikola T. Markov1, Motoaki Uchimura1,
                                        Marcelo G. Mattar2, Nathaniel D. Daw1,3 & Timothy J. Buschman1,3 ✉Received: 17 March 2024
Accepted: 24 October 2025
                                       Cognition is highly flexible—we perform many different tasks1 and continually adaptPublished online: 26 November 2025
                                     our behaviour to changing demands2,3. Artificial neural networks trained to perform
Open access                                         multiple tasks will reuse representations4 and computational components5 across
   Check for updates                         tasks. By composing tasks from these subcomponents, an agent can flexibly switch
                                   between tasks and rapidly learn new tasks6,7. Yet, whether such compositionality is
                                    found in the brain is unclear. Here we show the same subspaces of neural activity
                                        represent task-relevant information across multiple tasks, with each task flexibly
                                     engaging these subspaces in a task-specific manner. We trained monkeys to switch
                                   between three compositionally related tasks. In neural recordings, we found that task-
                                          relevant information about stimulus features and motor actions were represented in
                                      subspaces of neural activity that were shared across tasks. When monkeys performed
                                      a task, neural representations in the relevant shared sensory subspace were transformed
                                        to the relevant shared motor subspace. Monkeys adapted to changes in the task by
                                               iteratively updating their internal belief about the current task and then, based on this
                                                 belief, flexibly engaging the shared sensory and motor subspaces relevant to the task.
                                            In summary, our findings suggest that the brain can flexibly perform multiple tasks by
                                        compositionally combining task-relevant neural representations.

Humans and other animals can combine simple behaviours to create  was more similar to a ‘tee’, the monkey saccaded to the lower-right
more complex behaviours8–11. For example, learning to discriminate   (LR) target (Fig. 1c (top row)). The colour–axis 2 (C2) task required
whether a piece of fruit is ripe can be used as a component of a variety   the monkey to categorize the colour of the stimulus and respond on
of foraging, cooking and eating tasks. The ability to compositionally   axis 2: if the colour was ‘red’, they saccaded to upper-right (UR), and if
combine behaviours is thought to be central to generalized intelligence   ‘green’, they saccaded to lower-left (LL; Fig. 1c (bottom row)). Finally,
in humans12 and a necessary component for artificial neural networks   in the colour–axis 1 (C1) task, the monkeys categorized the colour of
to achieve human-level intelligence13–15. When artificial neural networks   the stimulus (as in the C2 task) and responded on axis 1 (as in the S1
are trained to perform multiple tasks, they reuse representations and   task; red = LR, green = UL; Fig. 1c (middle row)). In this way, the tasks
computational components in different tasks4–6. Whether the brain  were compositionally related—C1 can be considered as combining
similarly reuses sensory, cognitive and/or motor representations across   the colour categorization subtask of C2 with the motor response
tasks remains unclear. Furthermore, we do not yet understand how the   subtask of S1.
brain flexibly engages these representations to continually adapt to the    Both monkeys performed all three tasks well (Fig. 1e; monkey Si/Ch:
changing demands of the environment16. To address these questions,   S1, 81%/77%; C1, 83%/78%; C2, 92%/92%; all P < 0.001, binomial test,
we trained two monkeys to flexibly switch between three different   the performance of individuals is shown in Extended Data Fig. 1). The
compositionally related tasks.                                monkeys performed the same task for a block of trials (Fig. 1d). When
                                                              they reached a behavioural criterion (performance ≥ 70%), the task
                                                         would change (Methods). The monkeys were not instructed as to the
Composing tasks from subtasks                                identity of the new task. Thus, they had to learn which task was in effect
All three tasks followed the same general structure: the monkeys were  on each new block. Note that this learning was not de novo but reflected
presented with a visual stimulus and had to indicate its category with   a process of discovering the current task (also known as apparent learn-
an eye movement (Fig. 1a). The stimuli were parametric morphs, inde-   ing17 or task inference18). This was reflected in the monkey’s behaviour,
pendently varying in both shape and colour (Fig. 1b and Methods). The  which improved over the first 75 trials of the S1 and C1 tasks (Fig. 1f
monkeys performed three categorization tasks. In the shape–axis 1 (S1)    (left); S1/C1 increased from 0.47/0.62 at trial 15 to 0.71/0.77 at trial 75;
task, they categorized the shape of the stimulus and then responded   both P < 0.001, χ2 test). Despite performing both tasks well, the mon-
on axis 1: when the shape was more similar to a ‘bunny’, the monkey   keys were initially biased towards the C1 task (Extended Data Fig. 2e,f;
made a saccade to the upper-left (UL) target, and when the shape  performance difference for first 15 trials was 15.1%, P = 3.3 × 10−16,

1Princeton Neuroscience Institute, Princeton University, Princeton, NJ, USA. 2Department of Psychology, New York University, New York, NY, USA. 3Department of Psychology, Princeton University,
Princeton, NJ, USA. ✉e-mail: tafazoli@princeton.edu; tbuschma@princeton.edu

164  |  Nature  |  Vol 650  |  5 February 2026
## Page 2
         a                             b             50%                          50%

                                                   70%                 30%      70%                 30%

<!-- [figure panel text removed: 594 chars; see corresponding image] -->
                                                   100%       Tee      Bunny     0% 100%       Green      Red     0%
                       Fixation     Stimulus    Response
                 (500–800 ms)    onset                                                   70%                                Decision         30%      70%                                Decision         30%

         c                  Categorize shape       Axis 1                   50%                          50%

                                      Tee                    d
                 Task S1                                   C2      C1      C2      S1      C2      S1      C2      C1

                                                                                                       Block                                                                Bunny
                                       e                                  f
                                   Categorize colour      Axis 1
                                                                                                                   1.0                                   1.0
                                       Red                                       1.00
                 Task C1                                                                                         0.8                                   0.8
                                                                        0.75                                                                                                                                                                                                     choices                                         0.6                S1            0.6                                                                Green
<!-- [figure panel text removed: 1169 chars; see corresponding image] -->
                                                                           C1
                                                                        0.25                 C2         0.2                                   0.2                                       Red                                                                                                                                                Proportion
                 Task C2                                           0 0      30   50   70     100     0 0   20  40 60 60   40  20   0 0
                                                                Green                                              Stimulus morph level (%)                     Trials                Trials
                                                                                                              from switch         to switch

        g                             h                                            i
                                                                                                                0.04
                                                                         0.04
<!-- [figure panel text removed: 542 chars; see corresponding image] -->
                                                Parietal                         0.02                                                                         Striatum
                      Striatum                                                                                                    colour                                                                            shape                                        aIT
                                     aIT                          of                              of    0                        PAR
                                                                                       CPD    0                                       CPD
                                                                                                              –0.02
                                                                         0    0.2   0.4   0.6                 0    0.2   0.4   0.6
                                                                          Time relative to                      Time relative to
                                                                                      stimulus onset (s)                        stimulus onset (s)

                 j                    k                                     l            m
                   0.4                                 2.0                           4
<!-- [figure panel text removed: 1030 chars; see corresponding image] -->
<!-- [figure panel text removed: 638 chars; see corresponding image] -->
                                                                                                       CPD
                 0                             0                           0                             0
                        0    0.2   0.4   0.6            0    0.2   0.4   0.6           0    0.2   0.4   0.6             0    0.2   0.4   0.6
                        Time relative to                  Time relative to                Time relative to                  Time relative to
                           stimulus onset (s)                   stimulus onset (s)                 stimulus onset (s)                    stimulus onset (s)

Fig. 1 | The monkeys performed three compositional tasks. a, Schematic of the    for both animals for the 102, 102 and 51 trials before the switch for S1, C1 and C2
task timeline. After fixation, a visual stimulus and four response targets were        tasks, respectively. f, The performance before and after a switch in task. Data are
presented. The monkeys reported the stimulus category by saccading to one        mean ± s.e.m. The horizontal line indicates P < 0.001, as determined using a
of the targets. b, Stimuli were morphs in a two-dimensional feature space,          one-sided uncorrected binomial test. g, The locations of neural recordings. The
independently varying in shape (left) and colour (right). Categories are indicated   diagram was created using BioRender. h–l, Information about task-relevant
by dashed lines and labels. c, Schematic of the task design. Task S1 required          variables for all regions, estimated as the proportion of variance in each neuron’s
categorizing stimuli by shape and responding on axis 1. Task C2 required             activity uniquely explained by each variable (using the coefficient of partial
categorizing by colour and responding on axis 2. Task C1 required categorizing     determination, CPD; Methods). The CPD for colour (h), shape (i), task identity (j),
by colour and responding on axis 1. The coloured backgrounds highlight shared    reward (k) and response direction (l) is shown. The lines show the mean CPD
subtasks: colour categorization for C1 and C2 (blue) and response axis for S1 and     across neurons per region. The dashed lines indicate that a region did not have a
C1 (orange). d, Example sequence of tasks. The task switched when performance     significant number of neurons encoding that cognitive variable. m, Time course
was ≥70%. The monkeys were not cued to the upcoming task, although the          of the average CPD across all recorded neurons, normalized to the maximum
response axis always switched between blocks. Recordings included 94, 97 and     value to show temporal order. Data are mean ± s.e.m.
189 blocks of S1, C1 and C2. e,f, Behavioural performance. e, Psychometric curve

χ2 test). This suggests that the monkeys initially expected to perform    The monkeys performed the C2 task accurately immediately after the
the C1 task, possibly because they categorized colour on two out of   switch (Fig. 1f; 0.85 at trial 15; P < 0.001, binomial test). This was because
three tasks (C1 and C2).                                             the axis of response always changed between blocks and the C2 task was

                                                                                                Nature  |  Vol 650  |  5 February 2026  |  165
![Figure on page 2](images/page02_img00.png)

![Figure on page 2](images/page02_img01.jpeg)

![Figure on page 2](images/page02_img02.jpeg)

![Figure on page 2](images/page02_img03.jpeg)

![Figure on page 2](images/page02_img04.jpeg)

![Figure on page 2](images/page02_img05.jpeg)

![Figure on page 2](images/page02_img06.jpeg)

![Figure on page 2](images/page02_img07.jpeg)

![Figure on page 2](images/page02_img08.jpeg)

![Figure on page 2](images/page02_img09.jpeg)

![Figure on page 2](images/page02_img10.jpeg)

![Figure on page 2](images/page02_img11.jpeg)

![Figure on page 2](images/page02_img12.jpeg)

![Figure on page 2](images/page02_img13.jpeg)

![Figure on page 2](images/page02_img14.jpeg)

![Figure on page 2](images/page02_img15.jpeg)

![Figure on page 2](images/page02_img16.jpeg)

![Figure on page 2](images/page02_img17.jpeg)

![Figure on page 2](images/page02_img18.jpeg)

![Figure on page 2](images/page02_img19.jpeg)

![Figure on page 2](images/page02_img20.jpeg)

![Figure on page 2](images/page02_img21.jpeg)

![Figure on page 2](images/page02_img22.png)

![Figure on page 2](images/page02_img23.jpeg)

![Figure on page 2](images/page02_img24.jpeg)

![Figure on page 2](images/page02_img25.jpeg)

![Figure on page 2](images/page02_img26.jpeg)

![Figure on page 2](images/page02_img27.jpeg)

![Figure on page 2](images/page02_img28.jpeg)

![Figure on page 2](images/page02_img29.jpeg)

## Page 3
Article
a                     b                    c                    d  Generalized colour                             Generalized response
                                                                                                                                          category classiﬁer                                   direction classiﬁer
           P = 0.0169     P = 0.0029            P = 0.0009                                0.0009P =
<!-- [figure panel text removed: 1286 chars; see corresponding image] -->
<!-- [figure panel text removed: 3119 chars; see corresponding image] -->
                                                                                                                                                                 Train on C2              Test on C1                 Train on S1
               0    0.2   0.4                         0    0.2   0.4                        0    0.2   0.4                                     Classify                               Classify
               Time relative to                          Time relative to                        Time relative to                                      colour                           response
                stimulus onset (s)                             stimulus onset (s)                           stimulus onset (s)

<!-- [figure panel text removed: 14686 chars; see corresponding image] -->
                                                                                          –0.10
                                                                                                                             0    0.2    0.4    0.6                     0    0.2   0.4               0    0.2    0.4    0.6                    0    0.2   0.4                                     Differencewithin –0.15
                Time relative                                 to                                                      Time relative                                                                                to
                 stimulus                        onset                                            (s)                            stimulus                                                                   onset                                                                                                         (s)                 LPFC aIT FEF PAR                      stimulusTime relativeonsetto(s)                             stimulusTime relativeonsetto(s)
                       Test C1                                                                           Area                                      Test C1

Fig. 2 | Colour category and response representations were shared across     colour information is delayed in the aIT, FEF and PAR. The difference in the
tasks. a–c, The accuracy of classifierstrained to decode colour category (a),      time of onset of colour information during the C1 task when decoded from
shape category (b) and motor response (c) from LPFC neural activity. Classifiers    classifiers trained on the C1 task versus generalized from the C2 task (vertical
were trained and tested on withheld trials of the S1 task (orange), C2 task (blue)    dashed lines in a and f, respectively) is shown. Statistical analysis was
and C1 task (green). Data are mean ± s.e.m. over 250 classifiers, trained and tested   performed using two-sided uncorrected bootstrap tests; *P < 0.05, **P < 0.01
on n = 40 randomly sampled trials (Methods). The horizontal bars indicate above-   and ***P < 0.001; LPFC (P = 0.753), aIT (P = 0.0099), FEF (P = 0.0009), PAR
chance classification (P < 0.05, 0.01 and 0.001 for thin, medium and thick lines,    (P = 0.0009). The box limits represent the interquartile range (25th to 75th
respectively; two-sided permutation test, corrected for multiple comparisons     percentile), the red horizontal line indicates the median, and the whiskers
over time). d, Schematic of the classifiers used to test whether colour category    indicate the full extent of data. h, Cross-temporal cross-task classification
and response location information were shared across tasks (Methods). e, Cross-   accuracy of the response classifier trained to decode response direction from
temporal cross-task classification accuracy of the colour classifier trained to     LPFC neural activity during the S1 task and tested on the C1 task. i, Cross-task
decode the colour category from LPFC neural activity during the C2 task and       classification accuracy of response when the response classifier was trained on
tested on the C1 task. f, Cross-task classification accuracy of colour when the      the C1 task (orange) or S1 task (green) and then tested on the other task. Data
colour classifier was trained on the C1 task (blue) or C2 task (green) and then       are mean ± s.e.m. over 250 classifiers.
tested on the other task. Data are mean ± s.e.m. over 250 classifiers. g, Shared

the only one to use axis 2, reducing the monkeys’ uncertainty about the   ‘mixed selective’ in all regions, representing multiple task variables23,24
task (and leading to more C2 blocks than C1 or S1 blocks, although there   (Extended Data Fig. 3b–k).
were more trials of C1 or S1 than C2; Methods). While overall behavioural    To understand how each task variable was represented in the neu-
performance was higher on C2 than C1 trials (Fig. 1e), this difference   ral population, we trained classifiers to decode the stimulus colour,
was probably due to the increased uncertainty about the task on C1   shape and motor response from the pattern of neural activity in each
trials; there was no difference in performance for congruent trials or   region (neurons from all recording sessions were combined into a
when the shape was ambiguous (Extended Data Fig. 2a–d). Together,   pseudopopulation24; Methods). Classifiers trained on LPFC neural
the animals’ behaviour suggests that they rapidly identified the change   activity accurately decoded the category of the stimulus’ colour in the
in response axis but slowly integrated feedback to learn whether S1 or  C1 and C2 tasks (Fig. 2a; 79 ms, 87 ms after stimulus onset for C1 and
C1 was in effect19.                                                  C2, respectively; similar results were seen when controlling for motor
                                                                 response; Extended Data Fig. 4a, P < 0.001, permutation test). In this
                                                              way, the classifier defined a subspace within the high-dimensional
Representations were shared across tasks                space of neural activity that represented the colour category of the
To understand the neural representations used during each task,   stimulus input. Similarly, classifiers trained on LPFC activity decoded
we simultaneously recorded neural activity from five cortical and   the category of the stimulus’ shape during the S1 task (Fig. 2b; 100 ms
subcortical regions (Fig. 1g): the lateral prefrontal cortex (LPFC; 480   after the stimulus onset; P < 0.001, permutation test).
neurons), frontal eye fields (FEF; 149 neurons), parietal cortex (PAR;     Task-irrelevant stimulus information was attenuated. In the LPFC,
64 neurons), anterior inferior temporal cortex (aIT; 239 neurons)   classification accuracy about the shape of the stimulus was reduced
and striatum (caudate nucleus; 149 neurons). All five regions repre-   during the C1 and C2 tasks (Fig. 2b) and information about the colour
sented task-relevant cognitive variables20,21, including the identity of   of the stimulus was reduced during the S1 task (this was also true at the
the current task, the colour and shape of the stimulus, the response  end of the block, when the animal was more certain about the identity
direction and whether a reward was received (Fig. 1h–l). The identity   of the task; Fig. 2a and Extended Data Fig. 4c,d). Similar to LPFC, other
of the task was consistently represented throughout the trial (Fig. 1j).   regions represented task-relevant, but not task-irrelevant, information
After stimulus onset, information about the colour category22 (Fig. 1h)   (Extended Data Fig. 4e,f).
and shape category of the stimulus (Fig. 1i) was followed by informa-    The direction of the monkey’s response within each task’s res­
tion about the direction of the animal’s response (Fig. 1l), and then  ponse axis could be decoded from the LPFC (Fig. 2c and Methods).
the reward received (Fig. 1k; see Fig. 1m and Extended Data Fig. 3a   Information about the response occurred after the stimulus’ category
for the average time course for all regions). Individual neurons were   (115 ms, 133 ms after stimulus onset in S1 and C1 tasks, respectively;

166  |  Nature  |  Vol 650  |  5 February 2026
![Figure on page 3](images/page03_img00.png)

![Figure on page 3](images/page03_img01.png)

![Figure on page 3](images/page03_img02.png)

![Figure on page 3](images/page03_img03.png)

![Figure on page 3](images/page03_img04.png)

## Page 4
both P < 0.001, permutation test; see Extended Data Fig. 4b for the C2  was a negative correlation between the sensory and motor responses
task). Similar results were seen in other regions (Extended Data Fig. 4g).   early in the trial (Fig. 3c), which may reflect suppression of the motor
Together, these results show that the stimulus colour category, stimulus   response during fixation and initial integration of the stimulus input.
shape category and response direction are broadly represented at the     Importantly, the transformation of stimulus information into
population level in multiple recorded regions.                      response was specific to the task: during the C1 task, the shared colour
  To test whether representational subspaces were reused across tasks,   representation did not predict the associated response direction along
we quantified how well a classifier trained to decode the stimulus’ col-   axis 2 (8 ms after saccade start; Fig. 3d,e (red line)). This is consistent
our category or the animals’ motor response in one task generalized   with the shared colour representation being selectively transformed
to the other tasks (Fig. 2d and Methods). Consistent with a shared   into a motor response along axis 1, and not axis 2, when the monkey
representation in the LPFC, a classifier trained to decode the colour  was performing the C1 task. By contrast, when the animals performed
category of a stimulus during the C2 task was able to significantly   the C2 task, the shared colour representation was transformed into a
decode the stimulus’ colour category during the C1 task (65 ms after  motor response along axis 2, and not axis 1 (Extended Data Fig. 7a–c).
stimulus onset in the LPFC; P < 0.001, permutation test; similar results  To visualize the dynamics of this transformation, we used targeted
were seen when using a nonlinear classifier; Fig. 2e,f and Extended Data   dimensionality reduction (TDR)21 to project neural activity onto
Fig. 5a). The reverse was also true: a classifier trained on C1 could decode   dimensions encoding the colour category (red versus green) and the
the stimulus’ colour category during the C2 task (Fig. 2f and Extended  motor response along both axis 1 and axis 2 (Fig. 3f and Extended Data
Data Fig. 5b, 84 ms after stimulus onset; P < 0.001, permutation test).   Fig. 7d–g). Consistent with the results from the classifiers, neural acti­
Importantly, the two tasks required different motor responses and   vity during the C1 and C2 tasks initially evolved along the colour axis
therefore the shared representation reflected the colour category of the   according to the stimulus’ category before transforming onto the axis
stimulus and not the motor response (further controls for movement   1 or axis 2 dimensions for the C1 and C2 tasks, respectively.
are shown in Extended Data Fig. 5c,d). Although colour information     Together, these results suggest tasks sequentially engaged shared
was reduced in the S1 task, the weak colour category representation   subspaces, selectively transforming stimulus representations into
that did exist also generalized between the C1 and S1 tasks (Extended  motor representations in a task-specific manner.
Data Fig. 5e).
  While colour category information was represented in a shared sub-
space in the LPFC, it was represented in task-specific subspaces in other  Task belief engaged shared subspaces
brain regions (Extended Data Fig. 6a). Generalization was weaker in   Theoretical modelling suggests that shared subspaces could facilitate
the FEF, PAR and aIT (Extended Data Fig. 6b,c) and was delayed with   cognitive flexibility by allowing the brain to engage previously learned,
respect to task-specific sensory information (Fig. 2g and Extended Data   task-appropriate representations and/or computations4,5. If true, then
Fig. 6d). There was no significant generalization in the STR (although   this predicts that task-appropriate shared subspaces should be engaged
the stimulus colour category could be decoded; Extended Data Fig. 4e).   as the animal discovers the task in effect.
  Motor response representations also generalized across tasks. A clas-    To begin to test this hypothesis, we first measured the monkey’s
sifier trained to decode response direction in the S1 task generalized   internal representation of the current S1 or C1 task (that is, their ‘belief’
to decode response direction in the C1 task (and vice versa; Fig. 2h,i,  about the task, as encoded by the neural population). To do so, we
128/128 ms after stimulus onset in the LPFC, when training on S1 or C1   trained a classifier to decode the identity of the S1 and C1 tasks using
tasks and testing on C1 or S1 tasks, respectively; P < 0.001, permutation   neural activity in the LPFC during the fixation period (before stimulus
test). In contrast to stimulus information, the motor representation   onset28). Training was restricted to the last 75 trials of each task block,
was shared in all regions (Extended Data Fig. 4h; perhaps reflecting a  when behavioural performance was high (Fig. 1f). We then applied
widely broadcasted motor signal25, but see ref. 26).                   the task classifier to the beginning of the C1 task blocks to measure
                                                               the animals’ internal belief about the task as they discovered which
                                                                    task was in effect (Fig. 4b (1) and Methods). As noted above, monkeys
Tasks sequentially used shared subspaces                   slowly discovered whether the S1 or C1 task was in effect19. Notably, the
If the representation of both the category of the stimulus and the   monkey’s rate of learning depended on the sequence of tasks. When
motor response were shared across tasks then performing a task   switching into a C1 task, animals learned more quickly when the previ-
requires selectively transforming representations from one subspace  ous axis 1 task was C1 compared to S1 (Fig. 4a (purple, C1–C2–C1 task
to another27. Consistent with this, there was a sequential representa-   sequence; black, S1–C2–C1 task sequence); ∆ = 10.26% change in per-
tion of the stimulus colour in the shared colour subspace followed by  formance over the first 20 trials, P < 0.001, χ2 test). A similar pattern
the motor response in the shared motor subspace during the C1 task  was seen for S1: performance on task sequence S1–C2–S1 was greater
(Fig. 3a; 63 ms difference in onset time of colour response using C2   than C1–C2–S1 (Extended Data Fig. 8a; ∆ = 4.99%, P = 0.032, χ2 test).
classifier and motor response using S1; P < 0.001, t-test).            As the C2 task had a unique response axis, it was not affected by the
  To directly test whether this reflected the transformation of infor-   preceding task (Extended Data Fig. 8b; ∆ = 1.42% between the S1–C2
mation between subspaces, we tested whether information about the  and C1–C2 sequences; P = 0.234, χ2 test).
stimulus colour in the shared colour subspace predicted the response    As the animals discovered the current task, the performance of the
in the shared response subspace on a trial-by-trial basis (Fig. 3b).   task classifier increased (Fig. 4c). During the S1–C2–C1 sequences, the
Figure 3c shows the correlation between the representation of the   classifier was slightly below chance initially, suggesting a slight encod-
stimulus’ colour category in the C1 task, decoded using the classifier   ing of the S1 task, before increasing as the monkeys learned (Fig. 4c,d;
from the C2 task, and the representation of the motor response in  from 42% to 54% from trial 40 to 110, P = 0.0079 permutation test). On
the C1 task, decoded using the response classifier from the S1 task   C1–C2–C1 task sequences, classifier performance was high immediately
(Methods). Correlation was measured across all possible pairs of   after the switch to C1 (67% classifier accuracy on trial 40; P < 0.001,
timepoints, quantifying whether colour or motor response repre-   permutation test) and increased with trials (Fig. 4d (purple line); 13%
sentations at one timepoint were correlated with representations at   increase from trial 40 to 110, P = 0.0079, permutation test). Moreover,
a future timepoint. The correlation was shifted upward with respect   the task classifier during the C1 task in S1–C2–C1 sequences was cor-
to the diagonal line (36 ms before saccade start; Fig. 3c,e (blue line)),   related with behavioural performance on the colour categorization
indicating that the encoding in the shared colour subspace predicted   task (Fig. 4e; P = 0.0239, permutation test) and anti-correlated with
the future encoding in the shared response subspace. Notably, there  how much behaviour depended on the shape category (Extended Data

                                                                                                Nature  |  Vol 650  |  5 February 2026  |  167
## Page 5
Article
         a                            b     Shared colour representation is       c        Shared colour category in C1 task
                                                                    transformed to the correct response axis               Shared response direction in S1 task

                   1.0                                              Shared colour subspace          Axis 1             (s)
                                                              between C1

<!-- [figure panel text removed: 5555 chars; see corresponding image] -->
                 0                                                                                                                                                                                                      Time           –0.1        0                        0     0.2    0.4                               50%
                 Time relative to stimulus onset (s)                                                                   Time relative to saccade start (s)
                                                                                                                                                       Train C2, test C1
                                                                   C2   C1                                   Colour category

                                                                                Task representation
        d                               e                                    f
                       Shared colour category in C1 task                         Colour C1     axis 2
                        Response direction in C2 task                           Colour C1     axis 1
                        (s)                                                                                      Colour morph level (%)
                                        start  0.05      P=           0.10           0.05                                 70     30     2                                                                                                 100        0                   Axis            0 ms              C1
                                                                                                    70     30                                                          0.05                                                       directiontest      0                   0.001                      0.04                                                                                                                      C1 task
                                                                         0.03                                                        saccade         P=
                     C2,to –0.05                 0.05                                                                               C2 task
                                                                                                             0 ms              –200 ms                                                                                                                                                                                                                                                                                                Correlation                    Correlation 0.02
                                                   0
                       –0.10                                                 Response                                   Trainrelative                                                                                                                                     0 ms                                                                         0.01                                    Colour            –200 ms–200 ms
                                                                   0                                Time           –0.1        0                                                                                –0.2  –0.1   0    0.1   0.2                                   Axis                                                          1
                       Time relative to saccade start (s)                  Time relative to saccade start (s)                  0 ms
                                      Train C2, test C1
                                 Colour category

Fig. 3 | Shared representations were transformed into shared motor          (trained on the C2 task, tested on the C1 task). Lines as in c. e, The average
representations during the task. a, Sequential processing of shared colour      cross-temporal correlation between colour category and response direction on
category information and shared response direction information in the LPFC.     axis 1 (blue line, anti-diagonal axis from c) and between colour category and
Classifier accuracy was normalized to the range from the baseline 200 ms before   response on axis 2 (red line, from d). The shift of the curve’s centre towards
stimulus to the maximum accuracy. b, Schematic showing the prediction that     negative time values reflects the extent to which encoding in the shared colour
shared colour representation is transformed to the axis 1 and axis 2 response     subspace predicts future encoding in the shared response subspace. The
axis during the C1 and C2 tasks, respectively. c, Cross-temporal, trial-by-trial      dotted lines show mean of the Gaussian fit to each curve. f, Dynamics of LPFC
correlation of shared colour category encoding (trained on the C2 task, tested    population activity projected onto dimensions of neural activity encoding
on the C1 task) and shared response location encoding (trained on the S1 task,     colour category, response on axis 1 and response on axis 2 for the C1 (dashed
tested on the C1 task). The thin and thick red lines indicate P ≤ 0.05 and P ≤ 0.001,    line) and C2 (solid line) tasks, showing task-dependent sensory–motor
respectively, as determined using uncorrected two-sided t-tests. d, Cross-       transformation. The line colours match the colour of the stimuli. Time stamps
temporal, trial-by-trial correlation of shared colour category encoding (trained   denote the time from saccade start.
on the C2 task, tested on the C1 task) and response direction encoding on axis 2

Fig. 8c, P = 0.00796, permutation test; similar results were seen during     Like task representations, colour representations depended on
the C1–C2–C1 sequence; Extended Data Fig. 8d,e).                   the task sequence (Fig. 4g). While shared representations increased
  So far, our results suggest the monkeys tracked whether the S1 or C1  when discovering C1 after a S1–C2–C1 sequence, they remained stable
task was in effect, and that this belief was maintained during the inter-   during C1–C2–C1 sequences (63% to 62%, ∆ = −1% from trial 40 to 110;
vening C2 task. Consistent with this, the task classifier trained during   P = 0.6852, permutation test). While this is consistent with better per-
the S1 and C1 tasks could decode the identity of the previous task during  formance at the beginning of the C1 task during C1–C2–C1 sequences,
the subsequent C2 task (Fig. 4b (2); 62%, P = 0.0009, permutation test)    it does not explain the improvement in behaviour over trials during
and into the start of the next S1 or C1 task (Fig. 4b (3); 64%, P = 0.0009,   the C1–C2–C1 sequence (Fig. 4a). This difference in performance was
permutation test). Similar results were seen in the FEF, but not in other   associated with an increase in colour information in the FEF during the
regions (Extended Data Fig. 8f).                                C1–C2–C1 sequence (Extended Data Fig. 8g; the difference in accuracy
 We next examined whether the animal’s internal representation of   between C1–C2–C1 and S1–C2–C1 was 12.7%; P = 0.004), possibly reflect-
the task predicted the engagement of the shared colour category and   ing the consolidation of colour category information from the LPFC
shared motor response subspaces. The strength of the representation   into FEF as the animal became more certain about the current task.
in the shared colour subspace increased as the monkeys discovered the    The animal’s behaviour and internal representation of the task sug-
C1 task during the S1–C2–C1 sequences (Fig. 4f,g and Methods; 64%   gest that they initially expected to perform the S1 task in the S1–C2–C1
to 69%, ∆ = 5% from trial 40 to 110; P = 0.0478, permutation test). This   task sequences. If true, and task representations modulate the strength
increase in the shared colour category representation of the stimulus   of shared subspace representations, then shape information should
was predicted by the strength of internal task representation in the LPFC   initially be strong and then decay as the animal learns the C1 task is
during fixation (Fig. 4h and Methods; P = 0.0478, permutation test).   in effect. To test this, we trained a classifier to decode the stimulus’
Furthermore, the colour category subspace in C1 became aligned with   shape category during the last 75 trials of the S1 task, and then tested
the colour category subspace in C2 as the animal discovered that the    it as the animal discovered the C1 task (Fig. 4i and Methods for details).
C1 task was in effect (Extended Data Fig. 9a–c). Together, these results   In contrast to colour, shape representation was significant immedi-
suggest that the shared colour subspace was dynamically engaged as   ately after the switch to the C1 task during S1–C2–C1 sequences (53%,
the monkey updated its belief about the current task.                    P = 0.02, permutation test) and then decreased, and delayed in time,

168  |  Nature  |  Vol 650  |  5 February 2026
![Figure on page 5](images/page05_img00.jpeg)

![Figure on page 5](images/page05_img01.jpeg)

![Figure on page 5](images/page05_img02.jpeg)

![Figure on page 5](images/page05_img03.png)

![Figure on page 5](images/page05_img04.jpeg)

![Figure on page 5](images/page05_img05.jpeg)

![Figure on page 5](images/page05_img06.jpeg)

![Figure on page 5](images/page05_img07.jpeg)

![Figure on page 5](images/page05_img08.jpeg)

![Figure on page 5](images/page05_img09.jpeg)

![Figure on page 5](images/page05_img10.jpeg)

## Page 6
a                   b                              c                             d
                                                                           Decode
                                                P = 0.0009               current task
                                              Train    Test        0.8    ***  P =   P =     S1                    P = 0.0079                      C1–C2–C1
        1.0                     Decode previous task           1 0.0009 0.0009      C2 C1                                              S1–C2–C1
                                    on axis 1           0.7            ***      ***      C1             0.60                      110         0.8
<!-- [figure panel text removed: 6737 chars; see corresponding image] -->
<!-- [figure panel text removed: 2164 chars; see corresponding image] -->
           Trials from switch                                Train BSTrainTestTrainAS                                                    Test       Test

e                                       f                                g                     h
                                                                                             C1–C2–C1
               P = 0.0239                                0.80        P = 0.0478     110         0.75     S1–C2–C1                P = 0.0478       1.6

<!-- [figure panel text removed: 1351 chars; see corresponding image] -->
<!-- [figure panel text removed: 2287 chars; see corresponding image] -->
       0                                                    0.50                                      0.45
              –0.3 –0.2 –0.1  0                                  –0.2   0    0.2   0.4                    40 50 60 70 80 90 100 110                 –0.2   0    0.2   0.4
     Time relative to stimulus onset (s)                     Time relative to stimulus onset (s)                                                Time relative to stimulus onset (s)
                                                                                                                                              Trials from switch
 i                                                                    j                    k                                                            l                        P = 0.0358                                                               0.65        C1–C2–C1                                                                  0.9      C1–C2–C1
                                                               S1–C2–C1                                                                                                                                    S1–C2–C1                                                                                                                        110                                                                                Decode      0.80                    0.60                      110
   Decode                                                                                          response                                                                                                                        100          0.8                                           100          0.60                                                                                                            0.75
<!-- [figure panel text removed: 1989 chars; see corresponding image] -->
<!-- [figure panel text removed: 811 chars; see corresponding image] -->
                                           40           0.40                                                              40
                       –0.2   0    0.2   0.4                    40 50 60 70 80 90 100 110                       –0.2   0    0.2   0.4                  40 50 60 70 80 90 100 110
                  Time relative to stimulus onset (s)                                                    Time relative to stimulus onset (s)
                                                                                         Trials from switch                                                                                          Trials from switch

Fig. 4 | Shared subspaces are dynamically engaged during task discovery.     the block (window of 40, shifted by 5 trials). The lines show the mean accuracy
a, Behavioural performance during the C1 task after C1–C2–C1 (purple) and       of 250 classifier iterations. The horizontal bars indicate an above chance trend
S1–C2–C1 (black) sequences of tasks. Data are mean ± s.e.m. over 44 and           in classifier accuracy across trials, as determined using two-sided permutation
53 blocks of C1–C2–C1 and S1–C2–C1 tasks. The horizontal bars indicate           tests, corrected for multiple comparisons. d, Accuracy in decoding C1 task
significant differences: P < 0.05, 0.01 and 0.001 for thin, medium and thick lines,     after switching into C1, during the C1–C2–C1 (purple) and S1–C2–C1 (black)
respectively, as determined using one-sided uncorrected χ2 tests. The dashed     sequences. Data are mean ± s.e.m. estimated from 250 classifier iterations.
lines mark chance: 25% overall, 50% within axis 1. b, The PFC encodes history of        e, Correlation of behavioural performance and decoded task belief during the
task identities. Left, schematic of the classifier decoding task. The classifier      S1–C2–C1 sequence. z-scored Kendall’s tau with two-sided permutation test,
was trained on 75trials of C1 or S1 before the switch at end of the block and was    corrected for multiple comparisons. f, Accuracy in decoding of colour category
tested on (1) withheld trials of C1 or S1 before the switch; (2) C2 trials to decode    over time, during the S1–C2–C1 sequence. Line colours as in c. g, Accuracy of the
the identity of the previous C1 or S1 block; (3) C1 or S1 trials after the switch to      colour category classifier over trials in the C1–C2–C1 (purple) and S1–C2–C1
decode the identity of the previous C1 or S1 block. Right, the numbered circles     (black) sequences. Data are mean ± s.e.m. estimated from 250 classifier
show the accuracy of classifiers, and the grey violin plot shows the null             iterations. h, Correlation of task belief and colour category during the S1–C2–C1
distribution. P values were calculated using two-sided permutation tests.         sequence. Lines and statistics as in e. i–j, As in f and g, respectively, but showing
AS, after the switch; BS, before the switch. c, Schematic of the classifier for the     accuracy in decoding of shape category. k,l, As in f and g, respectively, but
decoding task (left). Right, the accuracy in decoding identity of C1 task over       showing accuracy in decoding of response direction.
time, during the S1–C2–C1 sequence. The line colours show progression over

as the animal learned (Fig. 4i,j; 49%, ∆ = −4%, P = 0.0358, permutation     Together, these results suggest the animals maintained an internal
test). By contrast, shape information was reduced overall and remained   belief about whether they were performing the S1 or C1 task and then
stable during the C1–C2–C1 task sequences (Fig. 4j (purple); 51% on   used this internal belief to selectively engage the relevant shared colour
trial 40, ∆ = 1%, P = 0.1035, permutation test). Finally, consistent with  and shape subspaces during the C1 task. This information was then
task belief modulating engagement of shape representations, belief   transformed into the motor subspace to perform the task.
about the C1 task was inversely correlated with the representation of
shape (Extended Data Fig. 8h).
  In contrast to shared colour and shape subspaces, the animals’  Task belief scaled shared subspaces
motor response was stably decoded in a shared subspace through-   Previous research suggests tasks may modulate the gain of stimulus
out the block (Fig. 4k,l; ∆ = 3% (P = 0.2868) and ∆ = 3% (P = 0.6733) for   features, depending on their relevance for the current task23,29,30. Simi-
the S1–C2–C1 and C1–C2–C1 sequences, respectively; permutation    larly, we found stimulus information was attenuated when irrelevant
tests; Methods and Extended Data Fig. 9d). The representation in the   (Fig. 2a,b). Furthermore, this attenuation depended on the animals’
shared response subspace was not correlated with the strength of   internal belief about the task: as they discovered the C1 task was in
internal task representation in the LPFC (P = 0.546, permutation test;   effect, the representation of colour category was magnified (Fig. 5a),
Extended Data Fig. 8i). This makes sense, as both S1 and C1 tasks used   while shape representation was attenuated and delayed in time (Fig. 5b
the same motor response.                                    and Extended Data Fig. 8j).

                                                                                                Nature  |  Vol 650  |  5 February 2026  |  169
## Page 7
Article

a                        b                        c                        d
                                                                                                                                                                                                                                                                                  shape
             P = 0.0079                         P = 0.0278                       0.5              Compress shape                    P = 0.0039
    0.40                       120                                  120                                   representation                 0.8                       120
<!-- [figure panel text removed: 5625 chars; see corresponding image] -->
<!-- [figure panel text removed: 2516 chars; see corresponding image] -->
<!-- [figure panel text removed: 949 chars; see corresponding image] -->
<!-- [figure panel text removed: 632 chars; see corresponding image] -->

e                                    f                      g            Response on axis 1 (correct axis)       h
     0.8                                                                            Response on axis 2 (incorrect axis)                      P = 0.0119
<!-- [figure panel text removed: 1041 chars; see corresponding image] -->
<!-- [figure panel text removed: 6615 chars; see corresponding image] -->
                                             –0.1                                                                                                              10
       0.40   0.45   0.50   0.55                  0.58    0.62    0.66              –0.6  –0.4  –0.2   0       –0.6  –0.4  –0.2   0              –0.4       –0.2
          Task belief encoding                  Colour category encoding                   Time relative to stimulus onset (s)                 Time relative to stimulus onset (s)

              S1      C1
                             Task             Task

Fig. 5 | Irrelevant sensory and motor representations were suppressed during   average CPI during 100–300 ms after stimulus onset. Two-sided uncorrected
flexible behaviour. a, The distance between neural response to stimuli from     permutation test. f, Correlation between colour category encoding and
each colour category, projected onto shared colour category encoding axis       average CPI during 100–300 ms after stimulus onset. Two-sided uncorrected
(trained on C2, tested on C1, following the S1–C2–C1 sequence). Line colour shows   permutation test. g, The average firing rate (FR) for axis-1-selective (left) and
progression in block (window of 45 trials, shifted by 5 trials). Lines show the mean    axis-2-selective (right) neurons in the LPFC during the C1 task when animals
value for 250 iterations of classifiers. The horizontal bar indicates a significant    responded on axis 1 (correct axis, green) or axis 2 (incorrect axis, purple).
trend in distance over trials, as determined using two-sided permutation tests,    Irrelevant response axis information is suppressed during task discovery. Data
corrected for multiple comparisons. b, Distance between neural response to       are mean ± s.e.m. over time. P values were determined using two-sided paired
stimuli from each shape category, projected onto shape category encoding         t-tests, comparing the difference in FR measured over entire time period.
axis (trained on S1, balanced for response direction, tested on C1, following        h, Accuracy of the classifier decoding response axis across trials after the
the S1–C2–C1 sequence). Lines as in a. c, Suppression of irrelevant sensory        switch into C1 (window of 10 trials, shifted by 3 trials; following the S1–C2–C1
information in the LPFC. The CPI over time for all three tasks is shown. CPI is       sequence). The response axis representation is quickly updated after the
equal to the log of the ratio of the separability of stimuli in colour and shape       switch. Lines as in a. The horizontal bar indicates a significant increase in
subspaces. d, CPI over trials after the switch into C1 (following the S1–C2–C1        classifier accuracy from trial 10 to trial 16, as determined using a permutation
sequence). Irrelevant sensory information is gradually suppressed during task     test with cluster mass correction.
discovery. Lines as in a. e, Correlation between task belief encoding and the

  Amplitude modulation can be thought of as a geometric scaling   see Extended Data Fig. 10c–e for further controls and Extended Data
of stimulus representations in feature space23,29. To quantify this, we   Fig. 10f–i for other regions). However, in contrast to the gradual sup-
defined a compression index (CPI) as the log of the ratio between the   pression of sensory representations during task discovery, the incor-
separability of stimuli in (1) the colour subspace and (2) the shape sub-   rect response axis representation in the LPFC was quickly suppressed
space. Colour and shape representations were scaled in all three tasks.   after a change in task (within 3–6 trials; Fig. 5h; ∆(classifier perfor-
There was greater separation of colour representation during C1 and  mance in trial 10 and trial 16) = 6.88%, P = 0.0119, permutation test;
C2 tasks, and greater separation of shape representations during the S1   see Extended Data Fig. 10j,k for other regions). This reflected the rapid
task (similar results were found when controlling for motor response;   inference of response axis seen in the animals’ behaviour (Extended
Fig. 5c and Extended Data Fig. 9e,f). Stimulus representations were   Data Fig. 2g,h).
also scaled in the FEF and PAR, but not in the aIT, suggesting that the     Together, these results suggest the monkeys’ belief about the cur-
aIT maintains a veridical representation of the stimulus22,23 (Extended   rent task dynamically adjusted the magnitude of sensory and motor
Data Fig. 9e–g).                                                         representations31–33. Scaling neural representations was a common
  The scaling of representations changed as animals learned which  mechanism used in all the three tasks and could facilitate task-relevant
task was in effect (Fig. 5d). CPI was positively correlated with the   associations between stimulus category and motor response, while
strength of the task representation and colour category encoding in   preventing task-irrelevant associations.
the LPFC (Fig. 5e,f; z-scored Kendall’s τ = 2.328, P = 0.008, permuta-
tion test and z-scored Kendall’s τ = 2.163, P = 0.028, permutation test,
respectively).                                          Discussion
  In addition to selecting sensory information, the three tasks also  Our results suggest the brain can perform a task by compositionally
require selecting the appropriate motor response: the animal must   engaging a series of representational subspaces. Subspaces of neural
suppress responses on axis 1 during the C2 task and axis 2 during the   activity within prefrontal cortex represented task-relevant information,
C1 task. Consistent with scaling acting as a general mechanism for   including the colour category and shape category of the stimulus21,34
modulating task-(ir)relevant information, neurons selective for each  and the motor action35. Consistent with computational models4–7, these
motor axis were suppressed when the animal performed a task requir-   subspaces were shared across multiple tasks (Fig. 2), suggesting they act
ing a response on the other axis (Fig. 5g and Extended Data Fig. 10a,b;   as task components21,36–38. Subspaces were sequentially engaged, such

170  |  Nature  |  Vol 650  |  5 February 2026
## Page 8
that information from the relevant sensory subspace was transformed  needed to understand how suppressing irrelevant features supports
into the appropriate motor response subspace39 (Fig. 3). In this way, a   continual learning and consider alternative mechanisms16, including
task can be constructed by sequencing together a series of task com-   replaying experiences across tasks57,58 and recalling context-specific
ponents. For example, performing the C1 task engaged the subspace   associations from long-term memory43.
representing the colour category of the stimulus (shared with the C2
task) and then transformed this information into the motor subspace
encoding response along axis 1 (shared with the S1 task).           Online content
  Although our study is limited to three tasks, the underlying mecha-  Any methods, additional references, Nature Portfolio reporting summa-
nism has the ability to be highly expressive—flexibly sequencing task    ries, source data, extended data, supplementary information, acknowl-
components together could implement a wide variety of behaviours   edgements, peer review information; details of author contributions
(a form of sequential compositionality4). In this framework, the repre-  and competing interests; and statements of data and code availability
sentation of the task acts as a control input that selects the appropriate   are available at https://doi.org/10.1038/s41586-025-09805-2.
representations and computations4,5,40 (Figs. 4 and 5). If, as suggested
by our results, the brain can reuse representations and computations      1.    Sakai, K. Task set and prefrontal cortex. Ann. Rev. Neurosci. 31, 219–245 (2008).
across tasks, then this could allow one to rapidly adapt to changes in the     2.   Hadsell, R., Rao, D., Rusu, A. A. & Pascanu, R. Embracing change: continual learning in
environment, either by learning the appropriate task representation       deep neural networks. Trends Cogn. Sci. 24, 1028–1040 (2020).
                                                                                                        3.   Holton, E., Braun, L., Thompson, J. A., Grohn, J. & Summerfield, C. Humans and neural
through reward feedback41,42 or by recalling it from long-term memory43.        networks show similar patterns of transfer and interference during continual learning.
  Performing multiple tasks can lead to either shared representations         Nat. Hum. Behav. https://doi.org/10.1038/s41562-025-02318-y (2025).
or task unique representations23,44. Several previous studies have found    4.   Yang, G. et al. Task representations in neural networks trained to perform many cognitive                                                                                                             tasks. Nat. Neurosci. 22, 297–306 (2019).
different tasks use representations of sensory and motor information     5.    Driscoll, L. N., Shenoy, K. & Sussillo, D. Flexible multitask computation in recurrent networks
that are specific to that task24,45. Such task-unique representations have           utilizes shared dynamical motifs. Nat. Neurosci. 27, 1349–1363 (2024).
the advantage of minimizing interference when learning and perform-    6.   Goudar, V., Peysakhovich, B., Freedman, D. J., Buffalo, E. A. & Wang, X.-J. Schema formation                                                                                                                in a neural population subspace underlies learning-to-learn in flexible sensorimotor
ing multiple tasks45,46, but limit the ability to generalize learning across         problem-solving. Nat. Neurosci. 26, 879–890 (2023).
tasks3,23. By contrast, shared subspaces increase interference but could      7.    Riveland, R. & Pouget, A. Natural language instructions induce compositional generalization
speed learning by allowing knowledge to generalize across tasks6. For          in networks of neurons. Nat. Neurosci. 27, 988–999 (2024).                                                                                                         8.    Ito, T. et al. Compositional generalization through abstract representations in human and
example, learning the C2 task shapes the neural computations needed            artificial neural networks. In Proc. 36th Conf. Neural Information Processing Systems
to categorize the colour of a stimulus, which could generalize to other         (NeurIPS, 2022).
tasks that involve categorizing colour, such as C1. Future computa-    9.   Makino, H. Arithmetic value representation for hierarchical behavior composition.                                                                                                    Nat. Neurosci. 26, 140–149 (2023).
tional and experimental work is needed to test whether such transfer    10.  Reverberi, C., Görgen, K. & Haynes, J.-D. Compositionality of rule representations in human
of knowledge facilitates learning new tasks.                                            prefrontal cortex. Cereb. Cortex 22, 1237–1246 (2012).
  Representations in the prefrontal cortex generalized across tasks38,47      11.  Tenenbaum, J. B., Kemp, C., Griffiths, T. L. & Goodman, N. D. How to grow a mind: statistics,                                                                                                          structure, and abstraction. Science 331, 1279–1285 (2011).
(Fig. 2), although other regions, such as the hippocampus, are prob-     12.  Frankland, S. M. & Greene, J. D. Concepts and compositionality: in search of the brain’s
ably involved34. Less generalization in the PAR, visual cortex and stri-        language of thought. Ann. Rev. Psychol. 71, 273–303 (2020).
atum suggests that neural representations are more task-unique in     13.   Botvinick, M. et al. Reinforcement learning, fast and slow. Trends Cogn. Sci. 23, 408–422                                                                                                          (2019).
these regions. Differences between regions may allow the brain to use     14.  Lake, B. M., Ullman, T. D., Tenenbaum, J. B. & Gershman, S. J. Building machines that learn
the complementary advantages of both sharing representations       and think like people. Behav. Brain Sci. 40, e253 (2017).
                                                                                                               15.  Lake, B. M. & Baroni, M. Human-like systematic generalization through a meta-learning(generalizing learning) and task-unique representations (avoiding                                                                                                 neural network. Nature 623, 115–121 (2023).
interference)23,48.                                                                                16.  van de Ven, G. M., Tuytelaars, T. & Tolias, A. S. Three types of incremental learning.
  Whether a network uses a shared or task-unique representation         Nat. Mach. Intell. 4, 1185–1197 (2022).
                                                                                                                            17.   Heald, J. B., Lengyel, M. & Wolpert, D. M. Contextual inference underlies the learning of
depends on training curricula32, initial conditions48 and biological        sensorimotor repertoires. Nature 600, 489–493 (2021).
factors. Given that the animals were trained for months on the tasks,    18.  Vaidya, A. R. & Badre, D. Abstract task representations for inference and control.
one might expect the brain to form independent task representations        Trends Cogn. Sci. 26, 484–498 (2022).
                                                                                                             19.  Bouchacourt, F., Tafazoli, S., Mattar, M. G., Buschman, T. J. & Daw, N. D. Fast rule
to reduce interference4,44,45. Instead, we found the brain reduced inter-         switching and slow rule updating in a perceptual categorization task. eLife 11, e82531
ference by dynamically amplifying task-relevant sensory and motor         (2022).
representations and suppressing task-irrelevant dimensions31,37,49    20.  Siegel, M., Buschman, T. J. & Miller, E. K. Cortical information flow during flexible
                                                                                          sensorimotor decisions. Science 348, 1352–1355 (2015).
(Figs. 4 and 5).                                                                                          21.  Mante, V., Sussillo, D., Shenoy, K. V. & Newsome, W. T. Context-dependent computation
  One reason we found shared representations (rather than task-unique        by recurrent dynamics in prefrontal cortex. Nature 503, 78–84 (2013).
ones) may be because our task required the animal to continuously    22.  Freedman, D. J., Riesenhuber, M., Poggio, T. & Miller, E. K. A comparison of primate
                                                                                                    prefrontal and inferior temporal cortices during visual categorization. J. Neurosci. 23,
learn. Across trials, the monkeys used feedback to infer the task con-        5235–5246 (2003).
text, updating their internal belief about the task, and flexibly mapping    23.  Flesch, T. et al. Orthogonal representations for robust context-dependent task performance
stimuli onto motor responses (Figs. 4 and 5; a form of class-incremental          in brains and neural networks. Neuron 110, 1258–1270 (2022).
                                                                                                 24.  Rigotti, M. et al. The importance of mixed selectivity in complex cognitive tasks. Nature
continual learning16). This may enable the brain to flexibly interpolate        497, 585–590 (2013).
through a range of behaviours: updating its representation of the cur-    25.  Musall, S., Kaufman, M. T., Juavinett, A. L., Gluf, S. & Churchland, A. K. Single-trial neural
rent task along a task manifold41 to parametrically modulate how colour        dynamics are dominated by richly varied movements. Nat. Neurosci. 22, 1677–1686
                                                                                                       (2019).
category and shape category influence decision-making and to ensure    26.  Talluri, B. C. et al. Activity in primate visual cortex is minimally driven by spontaneous
the animal performed the appropriate response (for example, respond-       movements. Nat. Neurosci. 26, 1953–1959 (2023).
ing on axis 1, not axis 2, during C1 and vice versa for C2).                        27.  MacDowell, C. J. et al. Multiplexed subspaces route neural activity across brain-wide
                                                                                            networks. Nat. Commun. 16, 3359 (2025).
  As noted above, shared representations facilitate continual learning    28.  Wallis, J. D., Anderson, K. C. & Miller, E. K. Single neurons in prefrontal cortex encode
by allowing knowledge to generalize between tasks50. In addition to         abstract rules. Nature 411, 953–956 (2001).
reducing interference, the scaling of neural representations may also    29.  Barbosa, J. et al. Early selection of task-relevant features through population gating.
                                                                                                    Nat. Commun. 14, 6837 (2023).
facilitate continual learning by constraining learning to those repre-    30.  Langdon, C. & Engel, T. A. Latent circuit inference from heterogeneous neural responses
sentations that are currently task relevant51–53. Neural learning rules are        during cognitive tasks. Nat. Neurosci. 28, 665–675 (2025).
activity dependent54 and gated by reward55 and therefore suppressing     31.  Mack, M. L., Preston, A. R. & Love, B. C. Ventromedial prefrontal cortex compression                                                                                             during concept learning. Nat. Commun. 11, 46 (2020).
irrelevant representations may limit learning to task-relevant represen-    32.  Wójcik, M. J. et al. Learning shapes neural geometry in the prefrontal cortex. Preprint at
tations (addressing the credit assignment problem56). Future work is         bioRxiv https://doi.org/10.1101/2023.04.24.538054 (2023).

                                                                                                 Nature  |  Vol 650  |  5 February 2026  |  171
## Page 9
Article

33.  Xue, C., Kramer, L. E. & Cohen, M. R. Dynamic task-belief is an integral part of decision-       50.  Turner, E. & Barak, O. The simplicity bias in multi-task RNNs: shared attractors, reuse of
     making. Neuron 110, 2503–2511 (2022).                                                    dynamics, and geometric representation. Adv. Neur. Inf. Process. Syst. 36, 25495–25507
34.  Bernardi, S. et al. The geometry of abstraction in the hippocampus and prefrontal cortex.          (2023).
     Cell 183, 954–967 (2020).                                                                           51.   Kirkpatrick, J. et al. Overcoming catastrophic forgetting in neural networks. Proc. Natl
35.  Charlton, J. A. & Goris, R. L. T. Abstract deliberation by visuomotor neurons in prefrontal          Acad. Sci. USA 114, 3521–3526 (2019).
     cortex. Nat. Neurosci. 27, 1167–1175 (2024).                                                  52.   Li, Z. & Hoiem, D. Learning without Forgetting. IEEE Trans. Pattern Anal. Mach. Intell. 40,
36.  Samborska, V., Butler, J. L., Walton, M. E., Behrens, T. E. J. & Akam, T. Complementary task        2935–2947 (2018).
     representations in hippocampus and prefrontal cortex for generalizing the structure of       53.  Zenke, F., Poole, B. & Ganguli, S. Continual learning through synaptic intelligence.
     problems. Nat. Neurosci. 25, 1314–1326 (2022).                                                       In Proc. 34 International Conference on Machine Learning 3987–3995 (PMLR, 2017).
37.  Pagan, M. et al. Individual variability of neural computations underlying flexible decisions.    54.  Legenstein, R. & Maass, W. Branch-specific plasticity enables self-organization of nonlinear
     Nature 639, 421–429 (2025).                                                           computation in single neurons. J. Neurosci. 31, 10787–10802 (2011).
38.  Panichello, M. F. & Buschman, T. J. Shared mechanisms underlie the control of working       55.  Pereira-Obilinovic, U., Hou, H., Svoboda, K. & Wang, X.-J. Brain mechanism of foraging:
    memory and attention. Nature 592, 601–605 (2021).                                        reward-dependent synaptic plasticity versus neural integration of values. Proc. Natl Acad.
39.  Elsayed, G. F., Lara, A. H., Kaufman, M. T., Churchland, M. M. & Cunningham, J. P.                Sci. USA 121, e2318521121 (2024).
     Reorganization between preparatory and movement population responses in motor       56.  Asaad, W. F., Lauro, P. M., Perge, J. A. & Eskandar, E. N. Prefrontal neurons encode a solution
     cortex. Nat. Commun. 7, 13239 (2016).                                                          to the credit-assignment problem. J. Neurosci. 37, 6995–7007 (2017).
40. Hummos, A. Thalamus: a brain-inspired algorithm for biologically-plausible continual         57.   Rolnick, D., Ahuja, A., Schwarz, J., Lillicrap, T. P. & Wayne, G. Experience replay for
     learning and disentangled representations. In Proc. 11th International Conference on              continual learning. In Proc. 33rd Conference on Neural Information Processing Systems
     Learning Representations (ICLR, 2023).                                                         (NeurIPS, 2019).
41.  Jahn, C. I. et al. Learning attentional templates for value-based decision-making. Cell 187,    58.  van de Ven, G. M., Siegelmann, H. T. & Tolias, A. S. Brain-inspired replay for continual
     1476–1489 (2024).                                                                          learning with artificial neural networks. Nat. Commun. 11, 4069 (2020).
42.  Niv, Y. Reinforcement learning in the brain. J. Math. Psychol. 53, 139–154 (2009).
43.  Singh, D., Norman, K. A. & Schapiro, A. C. A model of autonomous interactions between      Publisher’s note Springer Nature remains neutral with regard to jurisdictional claims in
    hippocampus and neocortex driving sleep-dependent memory consolidation. Proc. Natl     published maps and institutional affiliations.
     Acad. Sci. USA 119, e2123432119 (2022).
44.  Gurnani, H. & Cayco Gajic, N. A. Signatures of task learning in neural representations.               Open Access This article is licensed under a Creative Commons Attribution
     Curr. Opin. Neurobiol. 83, 102759 (2023).                                                             4.0 International License, which permits use, sharing, adaptation, distribution
45.  Kim, J.-H., Daie, K. & Li, N. A combinatorial neural code for long-term motor memory.                  and reproduction in any medium or format, as long as you give appropriate
     Nature 637, 663–672 (2025).                                                                 credit to the original author(s) and the source, provide a link to the Creative Commons licence,
46.  Barak, O., Rigotti, M. & Fusi, S. The sparseness of mixed selectivity neurons controls the     and indicate if changes were made. The images or other third party material in this article are
     generalization–discrimination trade-off. J. Neurosci. 33, 3844–3856 (2013).                 included in the article’s Creative Commons licence, unless indicated otherwise in a credit line
47.  Cole, M. W., Etzel, J. A. & Braver, T. S. Rapid transfer of abstract rules to novel contexts in      to the material. If material is not included in the article’s Creative Commons licence and your
    human lateral prefrontal cortex. Front. Hum. Neurosci. 5, 142 (2011).                       intended use is not permitted by statutory regulation or exceeds the permitted use, you will
48.  Chizat, L., Oyallon, E. & Bach, F. On lazy training in differentiable programming. In Proc. 33rd   need to obtain permission directly from the copyright holder. To view a copy of this licence,
     Conf. Neural Information Processing Systems (NeurIPS, 2019).                                        visit http://creativecommons.org/licenses/by/4.0/.
49.  Muhle-Karbe, P. S. et al. Goal-seeking compresses neural codes for space in the human
    hippocampus and orbitofrontal cortex. Neuron 111, 3885–3899 (2023).           © The Author(s) 2025

172  |  Nature  |  Vol 650  |  5 February 2026
## Page 10
Methods                                                 but responded to the UR location for red stimuli and the LL location
                                                                      for green stimuli. Together, the UR and LL targets formed axis 2. This
Monkeys                                                              set of three tasks was designed to be related to one another: the C1 and
Two adult male rhesus macaques (Macaca mulatta) participated in  C2 tasks both required categorizing the colour of the stimulus while
the experiment. The number of monkeys (2) follows previous work   the C1 and S1 tasks both required responding on axis 1.
using similar approaches21. Monkeys Si and Ch were between 8 and    The monkeys were not explicitly cued as to which task was in effect.
11 years old and weighed approximately 12.7 and 10.7 kg, respectively.  However, they did perform the same task for a block of trials allow-
All of the experimental procedures were approved by the Princeton   ing the animal to infer the task based on the combination of stimulus,
University Institutional Animal Care and Use Committee (protocol,   response and reward feedback. Tasks switched when the monkeys’
3055) and were in accordance with the policies and procedures of the   performance reached or exceeded 70% on the last 102 trials of task S1
National Institutes of Health.                                  and task C1 or the last 51 trials of task C2. For monkey Si, block switches
                                                               occurred when their performance reached or exceeded the 70% thresh-
Behavioural task                                                  old for all morphed and prototype stimuli in the relevant task dimension
Each trial began with the monkeys fixating on a dot at the centre of   independently. For monkey Ch, block switches occurred when their
the screen. During a fixation period lasting 500 ms–800 ms, the mon-   average performance at each morph level in the relevant task dimension
keys were required to keep their gaze within a circle with a radius of   exceeded the 70% threshold (that is, average of all 30% morphs, average
3.25 degrees of visual angle around the fixation dot. After the fixation   of all 70% morphs, and 0% and 100% prototypes in colour dimension
period, the stimulus and all four response locations were simultane-  were all equal or greater than 70% accuracy in the C1 and C2 tasks).
ously displayed.                                                Moreover, on a subset of recording days, to prevent monkey Ch from
  Stimuli were morphs consisting of both a colour and shape (Fig. 1a).   perseverating on one task for an extended period of time, the threshold
The stimuli were rendered as three-dimensional models using POV-Ray  was reduced to 65% over the last 75 trials for S1 and C1 tasks after the
and MATLAB (MathWorks) and displayed using Psychtoolbox on a Dell  monkey had already done 200 or 300 trials on that block.
U2413 LCD monitor positioned 58 cm from the animal. Stimuli were    When the animal hit the performance threshold, the task switched.
morphed along circular continua in both colour and shape (that is, drawn   This was indicated by a flashing yellow screen, a few drops of reward
from a four-dimensional ‘Clifford’ torus; Fig. 1b). Colours were drawn  and a delay of 50 s.
from a photometrically isoluminant circle in the CIELAB colour space,    To ensure even sampling of tasks despite the limited number of trials
connecting the red and green prototype colours. Shapes were created   each day, the axis of response always changed following a block switch.
by circularly interpolating the parameters defining the lobes of the   During axis 1 blocks, either S1 task or C1 task was pseudorandomly
‘bunny’ prototype to the parameters defining the corresponding lobes   selected, interleaved with C2 task blocks. Pseudorandom selection
of the ‘tee’ prototype. The mathematical representation of the morph   within axis 1 blocks avoided three consecutive blocks of the same task,
levels adhered to the equation X12 + X22 + X32 = P 2 where X represents   ensuring the animal performed at least one block of each task during
the parameter value in a feature dimension (for example, L, a, b   each session. On average, animals performed of 560, 558 and 301 tri-
values in CIELAB colour space). We chose the radius (P) to ensure suf-   als and 2.68, 2.77 and 5.4 blocks per day for the S1, C1 and C2 tasks,
ficient visual discriminability between morph levels. The deviation of   respectively. Task orders and trial conditions were randomized across
each morph level from prototypes (0% and 100%) was quantified using    trials within each session.
percentage, corresponding to positions on the circular space from −π    Monkeys Si and Ch underwent training for 36 and 60 months, respec-
to 0 and 0 to π. Morph levels were generated at eight levels: 0%, 30%,   tively. Both animals were trained in the same order of tasks: S1, C2 and
50%, 70%, 100%, 70%, 50%, 30%, corresponding to 0, π/6, π/2, 5π/6, π,   then C1. Each animal underwent exposure to every task manipulation.
−5π/6, −π/2 and −π/6, respectively. 50% morph levels for one feature  As all of the animals were allocated to a single experimental group,
were only generated for prototypes of the other feature (that is, 50%   blinding was neither necessary nor feasible during behavioural training.
colours were only used with 0% or 100% shape stimuli and vice versa).   Electrophysiological recordings began when the monkeys consistently
Stimuli were presented at fixation and had a diameter of 2.5 degrees   executed five or more blocks daily. Further details on the behavioural
of visual angle.                                            methods and results have been previously reported19.
  The monkeys indicated the colour or shape category of the stimulus
by saccading to one of the four response locations, positioned 6 degrees  Congruent and incongruent stimuli
of visual angle from the fixation point at 45, 135, 225 and 315 degrees,  During the S1 and C1 tasks red-tee stimuli and green-bunny stimuli
relative to the vertical line. The reaction time was taken as the moment   were ‘congruent’ as they required a saccade to the LR and UL locations,
of leaving the fixation window relative to the time of stimulus onset.   respectively, in both tasks. By contrast, stimuli in the red-bunny and
Trials with a reaction time below 150 ms were terminated, followed   green-tee portion of stimulus space were ‘incongruent’, as they required
by a brief timeout (200 ms). Correct responses were rewarded with   different responses during the two tasks (UL and LR in S1 task; LR and UL
juice, while incorrect responses resulted in short timeouts lasting 1 s   in C1 task, respectively). To ensure the animals performed the task well,
for monkey Ch and 5 s for monkey Si. After the trial finished, there was  80% of the trials included incongruent stimuli. Note that, as the C2 task
an intertrial interval lasting 2–2.5 s before the next trial began.        was the only one to use axis 2, there were no congruent or incongruent
  The animals performed three category-response tasks (Fig. 1c). The   stimuli on those blocks.
S1 task required the monkeys to categorize the stimulus by its shape.
For a stimulus with a shape that was closer to the ‘bunny’ prototype, the   Analysis of behavioural data
animals had to make a saccade to the UL location to get rewarded. For a   Psychometric curves plot the fraction of trials in which the animals
stimulus with a shape closer to the ‘tee’ prototype, the animals had to   classified a stimulus with a specific morph level as being a member
make a saccade to the LR location to be rewarded. For ease of notation,   of the ‘green’ category for the C1 and C2 tasks or the ‘tee’ category for
we refer to the combination of the UL and LR target locations as axis   the S1 task. The fraction of responses for a given morph level of the
1. The C1 task required the monkeys to categorize the stimulus by its   task-relevant stimulus dimension was averaged across all morph levels
colour. When a stimulus’ colour was closer to ‘red’, the animals made   of the task-irrelevant dimension during the last 102/102/51 trials of the
an eye movement to the LR location and when it was closer to ‘green’   S1/C1/C2 task (for example, for the C1 task, the fraction of responses for
the animals made an eye movement to the UL location. Finally, in the  70% green stimuli were averaged across all shape morph levels). As the
C2 task, the monkeys again categorized stimuli based on their colour   stimulus space was circular, we averaged the behavioural response for
## Page 11
Article

the two stimuli at each morph level on each side of the circle (Fig. 1b).   or selectivity. Experimenters were blinded to experimental conditions
Psychometric curves were quantified by fitting the mean datapoints   while recording neurons. We did not simultaneously record from all
with a modified Gauss error function (erf):                              five regions in all recording sessions. We began recording from the
                                                       LPFC and FEF for the first 5–10 days and then added PAR, STR and aIT                                   
                 F = θ + λ ×                                erf                                        x − μ  + 1  2,                 on successive days.                                                                          σ                                                                      Broadband neural activity was recorded at 40 kHz using a 128-channel
where erf is the error function, θ is a vertical bias parameter, λ is a  OmniPlex recording system (Plexon). We performed 15 recording ses-
squeeze factor, μ is a threshold, and σ is a slope parameter. Fitting was   sions with monkey Ch and 19 recording sessions with monkey Si. After
done in MATLAB with the maximum likelihood method (fminsearch.m    all recordings were complete, we used electrical microstimulation in
function).                                            monkey Si, and structural MRI and microstimulation in monkey Ch,
  To calculate performance during task discovery (Fig. 1f), we used   to identify the FEF. Electrical stimulation was delivered as a train of
a sliding window of 15 trials, stepped 1 trial, to calculate a running   anodal-leading biphasic pulses with a width of 400 µs and an interpulse
average of performance immediately after a switch or right before a   frequency of 330 Hz. A site was identified as the FEF when electrical
switch. Performance was estimated using trials from all blocks of the   microstimulation of around 50 µA evoked a stereotyped eye-movement
same task, regardless of the identity of the stimulus. To test whether  on at least 50% of the stimulation attempts. In monkey Ch, untested
behavioural performance differed significantly between the C1–C2–C1   electrode locations were classified as FEF if they fell between two FEF
and S1–C2–C1 sequences during task discovery (Fig. 4a; S1–C2–S1 or   sites (as confirmed with electrical stimulation) in a region that was
C1–C2–S1 in Extended Data Fig. 8a and C1–C2 or S1–C2 in Extended   confirmed as being FEF using MRI.
Data Fig. 8b), we applied χ2 test using the chi2test.m function as imple-    Eye position was recorded at 1 kHz using an Eyelink 1000 Plus
mented previously59.                                                eye-tracking system (SR Research). Sample onset was recorded using
  To compare distribution of task performance after switch and before   a photodiode attached to the screen. Eye position, photodiode signal
switch for C1 and S1 tasks (Extended Data Fig. 2e,f), we computed behav-  and behavioural events generated during the task were all recorded
ioural performance in first 15 trials after switch and last 15 trials before   alongside neural activity in the OmniPlex system.
switch for each block, respectively.
  To compare colour categorization performance based on the stimu-   Signal preprocessing
lus shape morph level in C1 and C2 tasks (Extended Data Fig. 2c), for   Electrophysiological signals were filtered using a 4-pole high pass
each colour morph level, we computed colour categorization psycho-  300 Hz Butterworth filter. To reduce common noise, the median of
metric curves using combination of each colour morph level and three   the signals recorded from all single electrodes in each chamber was
sets of shape morph levels: ambiguous, 50% and 150% (that is, −π/2);   subtracted from the activity of all single electrodes. For V-Probe record-
intermediate, 30%, 70%, 130% (that is, −5π/6) and 170% (that is, −π/6);   ings, we subtracted the median activity for all channels along the probe
and prototype, 0% and 100%.                                   from each channel. To detect spike waveforms, a 4σn threshold was used
                                                           where σn is an estimate of s.d. of noise distribution of signal x defined as:
Surgical procedures and electrophysiological recordings
Monkeys were implanted with a titanium headpost to stabilize their                                                  |x|   
                                                                            σn = medianhead during recordings and two titanium chambers (19 mm diameter)                                                                                           0.6745 
placed over frontal and parietal cortices that provided access to the
brain. Chamber positions were determined using 3D model reconstruc-    Timepoints at which the electrophysiological signal (x) crossed
tion of the skull and brain using structural MRI scans. We recorded   this threshold with a negative slope were identified as putative spik-
neurons from the LPFC (Brodmann area 46 d and 46 v, 480 neurons),   ing events. Spike waveforms were saved (total length was 44 samples,
aIT (area TEa, 239 neurons), PAR (Brodmann area 7, 64 neurons), the   1.1 ms, of which 16 samples, 0.4 ms, were pre-threshold). Repeated
FEF (Brodmann area 8, 149 neurons) and the striatum (STR, caudate   threshold crossing within 48 samples (1.2 ms) was excluded. All wave-
nucleus, 149 neurons). The number of monkeys and the number of   forms recorded from a single channel were manually sorted into single
neurons recorded per region were chosen to follow previous work   units, multiunit activity or noise using Plexon Offline Sorter (Plexon).
using similar approaches38.                                         Units that were partially detected during a recording session were also
  Two types of electrodes were used during recordings. To record from   excluded. Experimenters were blinded to the experimental conditions
the LPFC and FEF we used epoxy-coated tungsten single electrodes   while sorting waveforms into individual neurons. All analyses reported
(FHC). Pairs of single electrodes were placed in a custom-built grid   in this Article were performed on single units.
with manual micromanipulators that lowered electrode pairs using a     For all reported electrophysiology analysis, saccade time was cal-
                                                                   culated as the moment at which the instantaneous eye speed exceededscrew. This enabled us to record 20–30 neurons simultaneously from
                                                              a threshold of 720 degrees of visual angle per second. Instantaneouscortical areas near the surface. To record from deeper regions (PAR,
                                                                                                                                2        2
<!-- [figure panel text removed: 764 chars; see corresponding image] -->
tubes. During lowering, we used both structural MRI scans and the
characteristics of the electrophysiological signal to track the position   Statistics and reproducibility
of the electrode. A custom-made MATLAB GUI tracked electrode depth   Independent experiments were performed on two monkeys and the
during the recording session and marked important landmarks until   data were combined for subsequent analyses. As described below, sta-
we found the brain region of interest.                                         tistical tests were corrected for multiple comparisons using two-tailed
  Recordings were acute; up to 50 single electrodes and three V-Probes   cluster correction unless stated otherwise. Unless otherwise noted,
were inserted into the brain each day (in some recording sessions one   nonparametric tests were performed using 1,000 iterations; therefore,
additional V-Probe was also inserted in the LPFC). Single electrodes   exact P values are specified when P > 0.001. Unless stated otherwise, all
and V-probes were lowered though the intact dura at the beginning   data were smoothed with a 150 ms boxcar. To compare the onset timing
of recording session and allowed to settle for 2–3 h before recording,   differences between within and shared-colour representations across
improving the stability of recordings. Neurons were recorded without   brain regions (Fig. 2g and Extended Data Fig. 6d), classifier accuracy
bias. Electrodes were positioned to optimize the signal-to-noise ratio   for each region was smoothed using a 50 ms boxcar filter.
of the electrophysiological signal without consideration of neural type      All analyses were performed in MATLAB 2021b (MathWorks).
## Page 12
                                                                   regularization coefficients (lambda) values of [0, 0.0003, 0.0006,
Using cluster mass to correct for multiple comparisons           0.0009, 0.0015, 0.0025, 0.0041, 0.0067, 0.0111, 0.0183]. In a separate
To assess the significance of observed clusters in the time series data,   set of runs, we fit the GLM models to 80% of data and tested on the
we used a two-tailed cluster mass correction method60. This approach is   remaining 20%. The lambda value with maximum R2 on the withheld
particularly useful when dealing with multiple comparisons and helps   data was used when estimating the CPD.
identify clusters of contiguous timepoints that exhibit statistically
significant deviations from the null distribution.               CPD calculation
 We first generated a null distribution (NullDist) by shuffling the  To quantify the unique contribution of each predictor to a neuron’s
observed data, breaking the relationship between the neural signal   activity, we used the CPD. This metric quantifies the percent of
and the task parameter of interest (details of how data were shuffled are   explained variance that is lost when a specific factor is removed from
included with each test below). The observed data were also included as   the full model. The CPD was computed by initially fitting the GLM with
a ‘shuffle’ in the null distribution and the z-score of the null distribution    all the factors (full model) as described above. Each factor was then
for each timepoint was calculated. To define significant moments in   sequentially removed to create a set of reduced models, each of which
time, we computed the upper and lower thresholds based on the null  were fit to the data. The CPD for each predictor X(t) was calculated as:
distribution. The thresholds were determined non-parametrically
                                                                               SSE reduced −SSE full model                                                                                              × 100using percentiles. The resulting thresholds, denoted as Pthreshold upper            CPD( X ( t )) =
                                                                                    SSE reducedand Pthreshold lower, serve as critical values for identifying significant devia-
tions in both tails.
  Timepoints of significant signal were identified by finding the  where SSEreduced is the sum of square error due to predictor X,
moments when the value in each shuffle within the null distribution    SSEfull model is the sum of square error of the full model with all predic-
or the observed data exceeded the computed thresholds. These time-   tors61. Note that, because the CPD statistic estimates the additional
points were then clustered in time, such that contiguous values above   explained variance captured by each term, it controls for potential
the threshold were summed together. The sum was calculated on the   covariation between terms. Nevertheless, it is important to note that, as
z-transformed values of each time series. This resulted in a mass of each   with all neurophysiological studies, it is difficult to distinguish between
contiguous cluster in the data. To correct for multiple comparisons, we   the encoding of a specific cognitive variable (for example, task) and its
took the maximum absolute value of the cluster mass across time for   effect on the representation of other cognitive variables (for example,
each shuffle. This resulted in a distribution of maximum cluster masses.   the observed suppression of sensory and/or motor representations).
Finally, the two-tailed P value of each cluster in the observed data was   We used a permutation test to assess whether CPDs for each predic-
determined by comparing its mass to the distribution of maximum   tor, at each timepoint, and for each neuron, was significantly larger than
cluster masses in the null distribution.                            expected by chance. To compute a null distribution for CPD for each
                                                                     predictor, we generated 1,000 permuted datasets by randomly per-
FR calculation                                              muting the predictor values relative to the neural activity and refitting
In all analyses, we estimated the FR of each neuron by averaging the   the full and reduced models (as above). The likelihood of the observed
number of action potentials within a 100 ms window, stepping the  CPD was then estimated by computing the proportion of permuted
window every 10 ms. Changing the width of the smoothing window   datasets that yielded a CPD greater than or equal to that of the observed
did not qualitatively change our results. The time labels in the figures   dataset. To account for multiple comparisons across timepoints, we
denote the trailing edge of this moving window (that is, 0 ms would be   used cluster correction (detailed above) to estimate corrected P values
a window from 0 ms to 100 ms).                                      for each predictor. Neurons that had at least one significant cluster
                                                                          (P < 0.05) were considered to significantly carry information about
GLM                                                          a task variable. To assess whether an area had a significant number of
To estimate how individual neurons represented task variables, we used   neurons for a given task variable, we used a binomial test against the
a generalized linear model (GLM) to relate the activity of each neuron   alpha-level 0.05.
(y) to the task variables at each moment of time. The full model was:      For Fig. 1h–l, we compensated for a baseline CPD by subtracting the
                                                               average permuted CPD from the observed CPD. For Fig. 1m, we aver-
  y = β0 + β 1 × stimulus colour category                          aged the CPD for each factor across all recorded neurons, subtracted
     + β2 × stimulus shape category + β 3 × time + β4 × task identity    the average baseline in −200–0 ms as the stimulus onset period and
                                                            then normalized the resulting CPD curve to its maximum value. For
     + β5 × motor response direction + β6 × reward                Extended Data Fig. 3a, we averaged the CPD for task identity factor
                                                                  across all recorded neurons then normalized the resulting CPD curve
where y is the FR of each neuron, normalized to the maximum FR across   to its maximum value. This highlighted the timing of different factors
all trials, and β0, β1, …, β6 are the regression coefficients corresponding   during the trial.
to each predictor. Predictors were: stimulus colour category, indicat-
ing the colour category of the stimulus (categorical variable); stimulus   Quantifying population overlap for encoding of task variables
shape category, indicating the shape category of the stimulus (categori-  To determine whether task variables were encoded by overlapping
cal variable); time, indicating the temporal progression within a record-   neural populations (Extended Data Fig. 3b–k), we examined neurons
ing session, normalized between 0 and 1 (continuous variable); task   for each task variable pair (for example, task identity and reward) to
identity, indicating the identity of the task (categorical variable); motor   identify those that significantly encoded either or both variables using
response direction, indicating the direction of the motor response   the GLM model explained above. Using a permutation test, we calcu-
(categorical variable; UL, UR, LL or LR); reward, indicating whether   lated the P value for neurons encoding both variables. For a neural
a reward was received following the response (binary variable; 1 for   population of size NTotal, with NTaskVar1 neurons encoding the first task
reward, 0 for no reward).                                                variable, NTaskVar2 neurons encoding the second, and NTaskVar1&TaskVar2 neu-
  The GLM coefficients (β) were estimated using maximum-likelihood   rons encoding both, we iterated 10,000 random samples of NTaskVar1
estimation as implemented by MATLAB’s lassoglm.m function. Inde-  and NTaskVar2 neurons from NTotal. In each iteration, we counted neurons
pendent models were fit for each timepoint. To address potential over-   encoding both variables. The likelihood of the observed NTaskVar1&TaskVar2
fitting, we applied Lasso (L1) regularization to the GLM weights with  was estimated by calculating the proportion of permutations
## Page 13
Article

yielding an equal or greater count of neurons encoding both task       trials for four stimulus types: green-bunny, green-tee, red-bunny
variables.                                                   and red-tee.
                                                                            (2) Balanced reward: classifiers were trained on an equal number of
Classifiers                                                    rewarded and unrewarded trials, balancing the stimulus identity
To understand how task variables were represented in the neural pop-      of the relevant dimension on each side of the classifier.
ulation, we trained a set of binary classifiers to discriminate the vector   (3) Balanced response direction: classifiers were trained on an equal
of FRs across the neural population for two different categories of task     number of trials from each response direction on the task’s response
variables (depending on the variable of interest). Classifiers were      axis (for example, trials with response on axis 1 for the C1 task). This
trained with the logistic regression algorithm (as implemented in      necessarily included error trials but balanced the number of each
MATLAB, fitclinear.m function). In brief, the linear classifier relates x     response direction on each side of the classifier.
(vector of neural responses) to y (task labels, either +1 or −1) through
a linear equation, with weights (w) and intercept (b):                  Classifying the colour category and shape category of stimuli
                                                               Colour and shape classifiers were trained to decode the stimulus colour
                                     f ( x ) = wT x + b                           category or shape category from the vector of activity across the pseu-
                                                              dopopulation of neurons (Fig. 2a,b). A balanced number of congruent
where w and b are optimized to minimize the logistic loss function:  and incongruent stimuli were included in the training data to ensure
L [y , f ( x )] = −1N ∑iN=1 [yi log( f ( xi )) + (1 − yi )log(1 − f ( xi ))], where N is the   colour and shape information could be decoded independently. Clas-
number of samples. Ridge (L2) regularization with a regularization   sifiers were trained for each task independently.
coefficient λ = 1/60 was used to minimize over-fitting. The classifier    Most classifiers were trained on correct trials alone. This maximized
was trained with the Broyden–Fletcher–Goldfarb–Shanno algorithm.   the number of trials included in the analysis and ensured the animals
                                                           were engaged in the task. As many of our analyses were tested across
Construction of pseudopopulations                                  tasks, this mitigates concerns that motor response information might
All classifiers were trained on pseudopopulation of responses con-   confound stimulus category information. However, to ensure response
structed from neurons across all recording sessions. A separate pseu-   direction did not affect our analyses, we controlled for motor response
dopopulation was constructed for each classifier analysis based on  by balancing response direction in a separate set of analysis (Extended
the trial types of interest (described below). To be included in the   Data Figs. 4a and 5c,d). Although this significantly reduced the number
pseudopopulation, each neuron had to be recorded for a minimum   of trials, and required us to include error trials, qualitatively similar
number of trials (Ntrain + Ntest) of each type of trial. The FR of neurons   results were often observed. The total number of LPFC, STR, aIT, PAR
were concatenated to form a vector of neuron FRs (the pseudopopula-  and FEF neurons used for colour category classification was 403, 110,
tion). Neural activity was aligned in time relative to either the sample   195, 54 and 116, respectively. The total numbers of LPFC, STR, aIT, PAR
onset or saccade onset, depending on the analysis.                 and FEF neurons used for shape category classification were 480, 149,
  To combine neurons across recording sessions into a single ‘trial’ of   239, 64 and 149, respectively.
the pseudopopulation, we drew trials for each neuron with matching
experimental conditions (that is, matched in terms of reward, colour   Classifying response direction
and shape morph level, task identity and response direction). For exam-  A separate set of response classifiers were trained to decode the motor
ple, when constructing a pseudopopulation for classifying the colour   response from the vector of activity across the pseudopopulation of
category, the first trial was constructed by concatenating the neural   neurons. Response direction was decoded within each axis (for exam-
responses of neurons on trials that were rewarded, had a colour morph   ple, UL versus LR for axis 1). When training and testing on the same
level of 100 and a shape morph level of 30. If a neuron did not have a   task (Fig. 2c), we included only trials that the animal responded on the
trial with an exactly matching stimulus, then a trial that matched the   correct axis (for example, axis 1 for the S1 and C1 tasks).
colour category and reward would be randomly chosen.                For testing whether response direction could be decoded across
                                                                axes (Extended Data Fig. 5d), we trained the classifier using trials from
Cross-validation of classifiers                                     task C1, where the animal responded on axis 1, and then tested this
A separate logistic regression classifier was trained and tested on with-   classifier using trials from task C2, where the animal responded on
held trials for each timepoint. To estimate variability, the entire analysis   axis 2, and vice versa. To control for stimulus-related information, we
was repeated 250 times, with each iteration involving a different par-   balanced rewarded and unrewarded trials for each condition and only
tition of trials into training and testing sets. This new set of trials was   included incongruent trials. This ensured that trials from the same
randomly sampled with replacement (always ensuring test trials were   stimulus category were present in both response locations. Similar
separate from the train trials).                                          results were seen when balancing for congruency and reward simul-
  When testing the performance of a classifier trained on the same set   taneously, although the low number of incorrect trials for congruent
of conditions (for example, training and testing colour categorization    trials resulted in a small set of neurons with the minimum number of
on the C2 task), the performance of the classifier was taken as the aver-   train and test trials. The total number of LPFC, STR, aIT, PAR and FEF
age performance across tenfold cross-validation. However, as detailed   neurons used for response direction classification was 403, 110, 195,
in the main text, many of the classifiers were trained and tested across  54 and 116, respectively. Owing to limited number of trials, the total
conditions (for example, across different tasks or across trials during  number of LPFC neurons for Extended Data Figs. 4b and 5d was 95
learning of the task). In this case, the test trials were randomly resam-   (only from animal Si).
pled ten times for each training set, and the classifier’s performance
was averaged across folds.                                    Using permutation tests to estimate the likelihood of classifier
                                                           accuracy
Balancing classifier conditions                        We used permutation tests to estimate the likelihood the observed
To avoid bias in the classifier, we balanced trial conditions to ensure the   classifier accuracy occurred by chance. To create a null distribution of
observed results were not due to other experimental factors. Condi-   classifier performance, we randomly permuted the labels of training
tions were balanced in three ways:                                 data 1,000 times. Importantly, only the task-variable of interest was
(1) Balanced congruency: classifiers were trained on an equal number  permuted—permutations were performed within the set of trials with
   of congruent and incongruent trials, resulting in equal number of   the same identity of other (balanced) task variables. For example, if
## Page 14
trials were balanced for reward, we shuffled labels within correct trials   categories: in ‘Low Initial Performance’ blocks, the animal’s behavioural
and within incorrect trials, separately. This ensured that the shuffling   performance during the first 25 trials of the block was less than 50%,
broke only the relationship between the task-variable of interest and   while on the ‘high initial performance’ blocks, the performance was
the activity of neurons. Shuffling of the labels was performed inde-   greater than 50%.
pendently for each neuron before building the pseudopopulation and    Owing to constrains on number of neurons, different but overlapping
training classifiers. Neurons that were recorded in the same session   population of neurons were used to quantify neural representations
had identical shuffled labels. To stabilize the estimate of the classi-   in C1–C2–C1 and S1–C2–C1 tasks sequences.
fier performance, the performance of the classifier on the observed
and each instance of the permuted data were averaged over 10-folds  Task belief representation during task discovery
and 20 to 50 novel iterations of each classifier. The null distribution  To measure the animal’s internal representation of the task (that is,
was the combination of the permuted and observed values (total   their ‘belief’ about the task, as represented by the neural population),
n = 1,001). The likelihood of the observed classifier performance  we trained a task classifier to decode whether the current task was C1
was then estimated as its percentile within the null distribution. As   or S1. The classifier was trained on neural data from the last 75 trials of
described above, we used cluster correction to control for multiple   each task block, when the animal’s performance was high (reflecting
comparisons across time.                                         the fact that the animals were accurately estimating the task at the end
                                                                   of the block). The number of congruent and incongruent trials were
Testing classification across tasks                               balanced in the training dataset (32 trials: 4 trials for each of the four
To quantify whether the representation of colour, shape, or response   stimulus types, in each task). We included all C1 blocks regardless of
direction generalized across tasks (Fig. 2e,f,h,i), we trained classifiers   their task sequence in training set. Only correct trials were used to
on trials from one task and then tested the classifier on trials from   train and test the classifier. To minimize the effect of neural response
another task. For example, to test cross-generalization of colour infor-   to visual stimulus, the classifier was trained on neural activity from the
mation across the C1 and C2 tasks, a colour classifier was trained on   fixation period (that is, before stimulus onset). As we were interested
trials from the C2 task was tested on trials from the C1 task (Fig. 2f).   in measuring differences between tasks, we did not subtract the mean
To remove any bias due to differences in baseline FR across tasks, we   firing rate before training the classifier.
subtracted the mean FR during each task from all trials of that task    The task classifier was tested on trials from the beginning of blocks of
(at each timepoint). Similar results were observed when we did not   the C1 task. Test trials were drawn from windows of 40 trials, slid every
subtract the mean FR.                                            5 trials, during learning (starting from trial 1–40 to trial 71–110). Over-
                                                                 lapping test and train trials from the same task were removed. In con-
Cross-temporal classification                                         trast to training set, testing was done separately for S1–C2–C1 and
To measure how classifiers generalized across time, we trained classi-  C1–C2–C1 task sequences (Fig. 4d). As we were interested in focusing
fiers to discriminate colour category (Fig. 2e and Extended Data Fig. 5b)  on the learning of the C1 task, we only used S1–C2–C1 task sequences
or response direction (Fig. 2h) using 100 ms time bins of FR data, sliding   with low initial performance (see above). Classifiers were tested on
by 10 ms. Classifiers trained on each time bin were then tested on all   pseudo­populations built from trials within each trial window, with a
time bins of the test trials.                                minimum of four test trials (one trial for each of the four stimulus con-
                                                             gruency types from task C1). Neurons that did not include the required
Projection onto the encoding axis of classifier                 number of test trials for all trial windows were dropped. Note that, as
To visualize the high-dimensional representation of task variables, we  we were using a small moving window of trials during task discovery,
used the MATLAB predict.m function to project the FR response on  we had to trade-off the number of included neurons and the number
test trials onto the one-dimensional encoding space defined by the   of train/test trials for this analysis. Moreover, although the number
vector orthogonal to the classification hyperplane. In other words,   of correct trials increased as the animal discovered the task in effect,
the projection measures the distance of the neural response vector  we kept a constant number of train and test trials in each of the sliding
to the classifier hyperplane. For example, to measure the encoding    trial windows.
of each colour category in the C1 task, we projected the trial-by-trial    To quantify the animal’s belief above the current task, we measured
FR onto the axis orthogonal to the hyperplane of the colour classifier   the distance to the hyperplane of the C1/S1 task classifier (task belief
trained during the C1 task.                                         encoding). For Fig. 4d, we averaged the performance of the classifier
                                                                         in pre-stimulus processing window (−400ms to 0 ms).
Quantifying the impact of task sequence on task discovery
The task-discovery period was defined as the first 110–120 trials after   Correlation between task belief encoding and behavioural
a switch in the task. The monkey’s performance increased during this  performance
period, as they learned which task was in effect (Fig. 1f). As described  To calculate the correlation between the animal’s task belief during
in the main text, the animal’s behavioural performance depended   task discovery and their behavioural performance (Fig. 4e), we used
on the sequence of tasks (Fig. 4a) and we therefore analysed neural   Kendall’s τ statistic with a permutation test to correct for autocorrela-
representations separately for two different sequences of tasks:       tion in the signal (detailed below). This measurement was performed
(1) C1–C2–C1 and S1–C2–S1 block sequence (same task transition):   using data from each window of trials and the belief encoding, as esti-
   the task on axis 1 (C1 or S1) repeated across blocks. As shown in the  mated from the task classifier, on that same window of trials. As we
  main text, monkeys tended to perform better during these task   are working with pseudopopulations of neurons, we estimated the
   sequences, as if they were remembering the previous axis 1 task.    behavioural performance for each window of trials during learning
(2) S1–C2–C1 and C1–C2–S1 block sequence (different task transition):   as the average of behavioural performance across all the trials in the
   the task on axis 1 changed across blocks. As shown in the main  window. The behavioural performance for each trial was taken as the
   text (Fig. 4a), monkeys tended to perform worse on these task   average of the animal’s behavioural performance during the previ-
   sequences.                                               ous 10 trials. This yielded one average performance for each of the 16
                                                                                      trial windows. The task belief was measured for the same trials, using
  As we were interested in understanding how changes in neural rep-   the average distance to the task classifier hyperplane, averaged over
resentations corresponded to the animals’ behavioural performance,   the time period from 400 ms to 0 ms before the onset of the stimulus
we divided the ‘different task transition’ sequences into two further   (note that, as described above, all of these trials are withheld from the
## Page 15
Article
training data). Task belief was then taken as the average distance across   Classifier statistical test to detect trends during task discovery
all trials in a window of trials.                                   period
                                                       To quantify the statistical significance of trends in representations
Evolution of colour category representation during task          during task discovery (Figs. 4 and 5), we used trend-free prewhitening
discovery                                                                 (TFPW)62,63, as implemented in MATLAB64. This method helps to reduce
We were interested in quantifying how the shared colour representa-   serial correlation in time-series data to obtain robust statistical infer-
tion was engaged as the animal discovered the C1 task (Fig. 4f,g). To this   ence in the presence of trends. TFPW first detrends the time series by
end, we trained a classifier to categorize colour using the last 75 trials  removing Sen’s slope. It then prewhitens the time series by modelling
of the C2 task, when the animal’s behavioural performance was high,   autocorrelation with an autoregressive (AR) model (typically AR(1))
and then tested it during discovery of the C1 task. The classifier was   to produce residuals free of temporal dependencies. Finally, it adds
trained on only correct trials and the training data were balanced for  back the original trend to generate processed time series. Both the
congruent and incongruent stimuli (16 trials: 4 trials for each of the four  Mann–Kendall statistics and Sen’s slope were used to estimate the
stimulus congruency types). This ensured an equal number of correct   significance of trends in the data.
trials for each congruency type across all trial windows, controlling for    To ensure that our reported statistics are fully unbiased, we used the
motor response activity during the task discovery period. As cross-axis   estimated Sen’s slope on prewhitened data using TFPW to estimate the
response decoding between the C1 and C2 tasks was weak (Extended  P value of the observed data. To do so, we used permutation tests to
Data Fig. 5d), cross-task classifiers are capturing the representation of   estimate the likelihood the observed trend slope occurred by chance.
the colour category that is shared between tasks.                  To create a null distribution of classifier performance, we randomly
  Similar to the task classifier described above, the shared colour clas-  permuted the labels of test data 250 times across all trial windows (tri-
sifier was tested using trials from the C1 task in a sliding window of 40   als 1–110 for Fig. 4 and 1–120 for Fig. 5). To stabilize the estimate of the
trials stepped 5 trials, in both the S1–C2–C1 and C1–C2–C1 sequences   classifier performance, we tested classifiers using the same set trained
of tasks (Fig. 4f; as above, only low initial performance blocks were   classifiers (for example, use same set of classifiers trained to decode
used for the S1–C2–C1 task sequences). We used four trials to test the   colour category in C2 task to test colour category decoding in C1 task
classifier (one trial for each of the four stimulus congruency types from   during task discovery). Furthermore, the performance of the classifier
task C1). For Fig. 4g, we averaged the performance of the classifier in  on the observed and each instance of the permuted data were averaged
stimulus processing window (100 ms to 300 ms).                    over 10-folds and 50 novel iterations of each classifier. The slope was
                                                                     calculated for each timepoint across all time trial windows to estimate
Evolution of shape category representation during task           the trend for observed and permuted classifier performances. The null
discovery                                                             distribution was the combination of the permuted and observed slope
We were interested in measuring the change in the representation of   values (total n = 251). The likelihood of the observed slope was then
the stimulus’ shape category as the animal learned the C1 task (Fig. 4i).   estimated as its percentile within the null distribution. As described
Our approach followed that of the colour category representation   above, we used cluster correction to control for multiple comparisons
described above, and so we only note differences here. We trained   across time.
a classifier to categorize stimulus shape based on neural responses    To measure rank correlation between two random variables (for
during the S1 task (limited to the last 75 trials of each block). To ensure  example, correlation between task belief and behavioural perfor-
the classifier was only responding to shape (and not motor response),  mance, Fig. 4e), we used Kendall’s τ. As TFPW requires a monotonic
we trained the classifier on a balanced set of correct (rewarded) and   time variable and cannot be applied here, we computed Kendall’s τ
incorrect (unrewarded) trials (16 trials: 4 trials for each reward con-   for both observed and permuted datasets. z-score values of observed
dition and for each shape category). The classifier was tested using   data against permuted values were reported to account for autocor-
trials from the C1 task (Fig. 4i). Note that we used the same C1 trials to   relation inflation.
quantify the representation of shared colour category, shape category
and task belief for S1–C2–C1 task sequences. For Fig. 4j, we averaged   Transfer of information between subspaces
the performance of the classifier in the window of time when stimuli  As described in the main text, we were interested in testing the hypo­
were processed (100 ms to 300 ms after stimulus onset). The total   thesis that the representation of the stimulus colour in the shared
numbers of LPFC neurons included for S1–C2–C1 and C1–C2–C1 task   colour subspace predicted the response in the shared response sub-
sequences to quantify the representation of shared colour category,   space on a trial-by-trial basis (Fig. 3c–e and Extended Data Fig. 7a–c).
shape category and task belief were 136 and 154, respectively.        To this end, we correlated trial-by-trial variability in the strength
                                                                  of encoding of colour and response along four different classifiers
Evolution of response direction representation during task        (using Pearson’s correlation as implemented in MATLAB’s corr.m
discovery                                                           function).
To measure the change in response direction representation as the      First, as described above, a shared colour classifier was trained to
monkey’s learned the C1 task, we trained a classifier to categorize the  decode colour category from the C2 task and tested on trials from
response direction based on the neural response during the S1 task   the C1 task. Training data were balanced for correct and incorrect tri-
(Fig. 4k; last 75 trials of the block). As above, we used a balanced num-   als (rewarded and unrewarded trials, 16 trials: 4 trials for each reward
ber of correct and incorrect trials to control for information about the   condition and each colour category). Test trials were all correct trials
stimulus (12 trials: 3 trials for each reward condition and each response   (2 trials: 1 trial for each colour category). Both train and test trials were
location). The classifier was then tested on correct trials from the C1  drawn from the last 50 trials from the block (to ensure the animals were
task during task learning (Fig. 4k; as above: sliding windows of 40 trials,   performing the task well). The total number of LPFC neurons included
stepped 5 trials, in S1–C2–C1 and C1–C2–C1; tested on 4 trials: 1 for each   for this classifier was 63 (only from monkey Si, owing to constraints on
reward condition and each response location). For Fig. 4l, we averaged   the number of trials).
the performance of the classifier in the window of time when response      Similarly, a second shared response classifier was trained on trials
location was processed (200 ms to 400 ms after stimulus onset). The  from the S1 task and then tested on the same set of test trials as the
total numbers of LPFC neurons included for S1–C2–C1 and C1–C2–C1   shared colour classifier.
task sequences to quantify the representation of shared response direc-    A third classifier was trained to decode the response direction on
tion were 120 and 155, respectively.                                     axis 2, using a balance of correct and incorrect trials from the C2 task.
## Page 16
This classifier was tested on the same set of test trials as the shared                              avg(Colour encoding distance) 
                                                                       CPI = logcolour classifier.                                                                                                                                                                                   avg(Shape encoding distance)  
  Finally, a fourth classifier was trained to decode the shared colour
representation but was now trained on correct trials from the C1 task
(12 trials: 3 trials for each of the four stimulus congruency types) and    To calculate the CPI for each task (Fig. 5c), we computed the shape
tested on correct trials from C2 task (2 trials: 1 trial for each colour  and colour encoding distance using all trials of a given task. To measure
category). The total number of LPFC neurons included for this classi-   the shape distance for all three tasks, we trained a classifier to cat-
fier was 101 (only from animal Si, owing to constraints on the number   egorize stimulus shape based on neural responses during the S1 task
of trials).                                                              (limited to the last 75 trials of each block). To ensure that the classifier
  To account for the arbitrary nature of positive and negative labels,  was responding only to shape (and not motor response), we trained the
we calculated the magnitude of encoding by flipping the encoding for   classifier on a balanced set of correct (rewarded) and incorrect (unre-
negative labels. All four classifiers were trained on 2,000 iterations of   warded) trials (20 trials: 5 trials for each reward condition and for each
training set trials. Note, that the first three classifiers were tested on the   shape category). Shape encoding for each task was calculated using
same test trials, allowing for trial-by-trial correlations to be measured.   four trials to test the classifier (one trial for each of the four stimulus
Furthermore, all four classifiers were trained over time, enabling us to   congruency types).
measure the cross-temporal correlation between any pairs of classifiers.    To measure colour distance in the S1–C2–C1 task, we trained colour
  Together, these four classifiers allowed us to test three hypothesized   category classifier on correct trials of the C1–C1–C2 task, balancing for
correlations that reflect the transfer of task-relevant stimulus informa-   congruent and incongruent stimuli (20 trials: 5 trials for each of the
tion into representations of behavioural responses. First, one might   four stimulus congruency types). Colour encoding for each task was
expect that, on any given trial before the start of saccade, the strength   calculated using four trials of that task to test the classifier (one trial
and direction of the shared colour representation, as estimated by   for each of the four stimulus congruency types).
the distance to the hyperplane of the first classifier, should be cor-    To track changes in the relative strength of colour and shape informa-
related with the shared response, as estimated by the distance to the   tion during task discovery, we calculated CPI in a sliding window of 45
hyperplane of the second classifier. This correlation is seen in Fig. 3c.    trials (slid every 5 trials starting from trial 1–45 to trial 76–120) after the
  Second, during the performance of the C1 task, one would expect   monkey’s switched into the C1 task (during the S1–C2–C1 sequences of
that before the start of saccade the shared colour representation should   tasks, with low initial performance). Note, as we controlled for motor
not be correlated with the response on the Axes 2 predicted by the C2   response when calculating shape and colour distance, the CPI is not
task. This is quantified by correlating the distance to the hyperplane   affected by motor response information65.
of the first classifier and the distance to the hyperplane of the third
classifier, as seen in Fig. 3d.                                       Correlation between task belief encoding and CPI
  However, one would expect these representations to be correlated  To correlate the CPI with task belief encoding, we used the same set of
when the animal is performing the C2 task. This is quantified by cor-  C1 test trials to calculate both CPI and estimate the task identity using
relating the distance to the hyperplane of the fourth classifier and the   the task classifier described above. CPI values in 100 ms–300 ms after
distance to the hyperplane of the third classifier, as seen in Extended   stimulus onset and belief encoding values in 400 ms to 0 ms before
Data Fig. 7a.                                                     stimulus onset were averaged for all trials in each trial window and
                                                                the Mann–Kendall correlation between the resulting two vectors was
Distance along colour and shape encoding axes during the         calculated (Fig. 5e).
discovery of the task
To understand how the geometry of the neural representation of the   Quantifying suppression of axis representation
colour and shape of the stimulus evolved during task discovery (Fig. 5),  We trained a response axis classifier to decode whether the current
we measured the distance in neural space between the two prototype   task axis was axis 1 or axis 2. The classifier was trained on neural data
colours (red and green) and the two prototype shapes (tee and bunny).  from all trials of C1 and C2 tasks with an equal number of trials from
Distance was measured along the encoding axis for each stimulus   each response direction on task specific axis (for example, equal trials
dimension (that is, the axis that is orthogonal to the colour and shape   for UL and LR response on axis 1 for C1 task, 36 trials: 9 trials for each
classifiers, described above). So, for each test trial, the distance along   response direction, in each task). All correct and incorrect trials were
the colour encoding axis was:                                  used to train and test the classifier. To capture the response period,
                                                                the classifiers were trained on the number of spikes between 200 ms
    colourencoding distance                                                        and 450 ms after stimulus onset. As we were interested in measuring
              abs(encoding(red bunny) −encoding(greenbunny)),          the difference in neural activity between axis of responses, we did not
<!-- [figure panel text removed: 542 chars; see corresponding image] -->
                                                                            Fig. 10d,f–i, the classifier was trained to decode response axis using
  This approach enabled us to calculate the distance along red/green   S1 and C2 trials.
colours while controlling for differences across shapes. The colour    To create a null distribution for classifier weights, we randomly per-
encoding distance was estimated for 250 iterations of the classifiers,  muted the response axis labels for a given response direction (1,000
enabling us to estimate the mean and standard error of the distance.   iterations).
A similar process was followed for estimating the shape encoding
distance.                                                            Selectivity for axis of response
  To calculate the colour and shape encoding distance during task  We used the classifier β weights to group neurons according to their
discovery (Fig. 5a,b), we calculated the distance above in the sliding   axis selectivity. Neurons with significantly negative β weights were
window of 45 trials, stepped 5 trials, after the switch into the C1 task   categorized as selectively responding to axis 1. Neurons with signifi-
during the S1–C2–C1 sequences of tasks with low initial performance.   cantly positive β weights were categorized as selectively responding
                                                                 to axis 2. Neurons without significant β weights were categorized as
CPI                                                                 non-selective (Extended Data Fig. 10a). To determine the significance
CPI was defined as the log of the ratio of average colour encoding dis-   of a neuron’s classifier weight, we compared the observed β weight to
tance and average shape encoding distance described above:         a null distribution (two-tailed permutation test).
## Page 17
Article

  To quantify the suppression of neural activity for each category of    To measure the angle between the colour category classifier in the
neurons, we averaged FRs of neurons in each category during trials   C1 task and the C2 task, we trained the classifier on last 50 trials of task
of the C1 task when the animal responded on axis 1 or axis 2 (Fig. 5g;  C1 and task C2.
Extended Data Fig. 10e shows the same analysis for the S1 task). This
meant including all trials when the animal responded on axis 1 (both  TDR analysis
correct and error) and all trials when the animal responded on axis 2 (all  The TDR analysis requires multiple steps21. Here, we describe each
errors). As the monkeys rarely responded on incorrect axis (Extended   step in turn.
Data Fig. 2g), the number of trials was limited and so neurons without
any error trials on axis 2 were excluded.                             Linear regression. We used a GLM to relate the activity of each neu­
  Note that, although neurons were sorted by their activity during the   ron (y) to the task variables at each moment of time. The full model
animal’s response (200–450 ms after stimulus onset), we observed sup-   was:
pression across the entire trial (Fig. 5g). Furthermore, similar results
                                                                            y = β0 + β 1 × stimulus colour morph level + β2were seen when a neuron’s axis selectivity was quantified on withheld
trials (for example, in Extended Data Fig. 10d–i, axis selectivity was         × stimulus shape morph level + β 3 × time + β4 × task S1 + β5
defined on S1 and C2 tasks and applied to C1 trials).                        × task C1 + β6 × task C2 + β 7
                                                                  × motor response direction on axis 1 + β 7Decoding response axis during the discovery of the task
We trained a response axis classifier to decode whether the current         × motor response direction on axis 2 + β9 × reward
task axis was axis 1 or axis 2. The classifier was trained on neural data
from the last 75 trials of the C1 and C2 tasks, when the monkey’s perfor-  where y is the FR of each neuron, z scored by subtracting the mean
mance was high (reflecting the fact that the animals were accurately   response from the FR at each timepoint and dividing it by the s.d. The
responding to the correct axis at the end of the block). The classifier  mean and s.d. were computed across all trials and timepoints for each
was trained on an equal number of trials from each direction on the   neuron.
response axis (for example, equal trials for UL and LR response on      β0, β1, …, β9 are the regression coefficients corresponding to each
axis 1 for C1 task; 36 trials: 9 trials for each response direction, in each   predictor. Predictors were: stimulus colour morph level, coded as −1
task). Correct and incorrect trials were used to train and test the clas-   for 0% morph level, −0.5 for 30% and 170% morph levels, +0.5 for 70%
sifier. To remove the effect of stimulus processing, the classifier was  and 130% morph levels, and +1 for 100% morph level; stimulus shape
trained on neural activity from the fixation period (that is, −400 to  morph level, coded as −1 for 0% morph level, −0.5 for 30% and 170%
0 ms before stimulus onset). As we were interested in measuring dif-  morph levels, +0.5 for 70% and 130% morph levels and +1 for 100%
ferences between axis of responses, we did not subtract the mean FR  morph level; time, indicating the temporal progression within a record-
before training the classifier.                                       ing session, normalized between 0 and 1 (continuous variable); task
  The task classifier was tested on trials from the beginning of blocks of   identity, indicating the identity of the task (categorical variable: S1,
the C1 task. Test trials were drawn from windows of 10 trials, slid every   C1, C2); motor response direction on axis 1, indicating the direction of
3 trials, during task discovery (starting from trial 1–10 to trial 66–75).   the motor response (categorical variable; −1 for UL, +1 for LR); motor
Overlapping test and train trials from the same task were removed.   response direction on axis 2, indicating the direction of the motor
Classifiers were tested on pseudopopulations built from trials within   response (categorical variable; −1 for LL, +1 for UR); reward, indicating
each trial window (two trials: one trial for each response direction on   whether a reward was received following the response (binary variable;
axis one from task C1).                                                     1 for reward, 0 for no reward).
                                                          The GLM coefficients (β) were estimated using maximum-likelihood
Quantifying the angle between classifier hyperplanes             estimation as implemented by MATLAB’s lassoglm.m function. Inde-
To quantify the similarity between the decision boundaries of classi-  pendent models were fit for each timepoint. To address potential
fiers trained on different tasks, we calculated the angle between the   overfitting, we applied Lasso (L1) regularization to the GLM weights
hyperplanes defined by their weight vectors. Each classifier produced   with regularization coefficients (lambda) values of 0.0015. Correct
a weight vector wi corresponding to the hyperplane that separates the  and incorrect trials were used in fitting the model.
data points according to the respective task. We averaged the resulting
hyperplane across resampling repetitions of trials (250 iterations).    Population average responses. We estimated the average response
  The angle θ between two average hyperplanes, defined by weight   of the neural population to each task variable. To calculate the average
vectors wi and wj, was calculated using the cosine similarity, which is   neural response to each colour and shape morph level, we separately
given by:                                                       averaged trials for within each morph level (0, 30, 70, 100, 130, 170) for
                                                            each task. To calculate the average neural response for each response
                    wi ⋅ wj                       cos( θ) =                                    direction, we separately averaged trials for within each response
                    wi wj                            direction (UL, UR, LL or LR) for each task. For all task variables, we
                                                       smoothed the resulting response in time with a 150 ms Boxcar. Finally,
  The angle θ was then obtained by taking the inverse cosine of the  we z-scored the smoothed average for a given unit by subtracting the
cosine similarity. Angles close to 0° indicate that the classifiers’ hyper-  mean across times and conditions, and by dividing the result by the
planes are nearly parallel, implying similar decision boundaries across   corresponding s.d.
the tasks. Conversely, angles close to 90° suggest orthogonal hyper-
planes, indicating distinct decision boundaries.                  PCA. We used principal component analysis (PCA) (as implemented in
  To measure the angle within the C1 task, we calculated the angle  MATLAB, pca.m function) to find the dimensions in the state space that
between classifiers trained to classify colour category on the last 50 tri-   captured most of the variance of the population average response and
als of C1 task in both the C1–C2–C1 task sequence and the S1–C2–C1 task   to mitigate the effect of noise. We concatenated the average response
sequence. This ensured that there were no overlapping trials between   across conditions to build matrix X of size (Ncondition × T) × Nunit, where
training samples. Only correct trials were used in this analysis and train-    Ncondition is the total number of conditions and T is the number of time
ing and test trials were balanced for congruent and incongruent stimuli   samples. We used the first NPCA that captured 90% of the explained
(20 trials: 5 trials for each of the four stimulus congruency types).      variance to define a de-noising matrix D of size Nunit × Nunit.
## Page 18
Regression subspace. We used the regression coefficients described                              avg(colour encoding distance) 
                                                                       CPI = logabove to identify dimensions in the state space containing task related                                                           avg(shape encoding distance)  
variance. We used four task variables to define this space: colour morph
level, shape morph level, response direction on axis 1 and response    Extended Data Fig. 9f reports the average CPI for 100 ms to 300 ms
direction on axis 2. For each of these task variables, we built coefficient   since stimulus onset.
vectors βv t, i( ) corresponding to regression coefficient for task vari­
able v, time t and unit i. We then denoised each variable vector by pro-   Quantifying the angle between colour category and response
jecting it to the subspace spanned by NPCA principal components from   direction subspace across tasks using TDR
the population average defined above.                         To quantify the angle between colour category subspace we used
                                                            orthogonal task variable vectors defined by TDR. Similar to fitting
                      βvPCA, t = Dβv , t                           a regression model for TDR, we first fit a regression model that
                                                               included separate colour, shape and response axis weights for each
 We computed tvmax for each task variable where norm of βvPCAt,  mat­   task.
rix had its maximum value. This defined the time-independent,
denoised regression vectors.                                       y = β0 + β 1 × C1 task stimulus colour morph level
                             max    PCA                            + β2 × C2 task stimulus colour morph level
                                            max                     βv  = βv , t v
                                                           + β 3 × S1 task stimulus colour morph level
  With tvmax = argmax t ∥βvPCA, t ∥. To compute orthogonal axes of colour,     + β4 × C1 task stimulus shape morph level
shape and response direction on axis 1 and response direction
                                                           + β5 × C2 task stimulus shape morph levelon axis 2, we orthogonalized the regression vectors βvmax using QR
decomposition.                                              + β6 × S1 task stimulus shape morph level
                                                           + β 8 × S1 task motor response direction on axis 1                     B max = QR
                                                           + β9 × C1 task motor response direction on axis 1
  Where the first four columns of Q are orthogonalized regression
                                                           + β 10 × C2 task motor response direction on axis 2 + β 11 × time
vectors βv of four task variables that comprise the regression subspace.
  To then estimate the representation of task-related variables in the     + β 12 × task S1 + β 13 × task C1 + β 14 × task C2 + β 15 × reward.
neural population, we projected the average population response
(described above) for each colour morph level, shape morph level,    Models were fit on 200 resamples, each randomly drawing 75% of
and response direction onto these orthogonal axes.                         all trials for each individual task. For ‘from switch’ conditions, the first
                                                       50 trials after switch to each task were used and, for ‘to switch’ condi-
                                        T
                      pv , c = βv Xc                                 tions, the last 50 trials in the blocks were used. Similar to TDR method
                                                               described above, we used QR decomposition to find the orthogonal
  Where pv,c is the time series with length T for each morph level in a   axes encoding each task variable, but now specific to each task (colour
specific task.                                          morph level, shape morph level, task identity, reward and task specific
  Note that because TDR orthogonalizes task features, it can control   axis of response):
for motor response when estimating the neural response to colour
and shape.                                                B max,C1task = Q C1RC1, B max,C2 task = Q C2 RC2 , B max,S1task = Q S1RS1

CPI using TDR. To measure the distance between the two prototype     For each resampling, the angle between orthogonal axis of colour of
colours (red and green) and the two prototype shapes (tee and bunny).   pairs of tasks (C1–C2, C1–S1 and C2–S1) was measured as
We first projected the average PSTH for each protype object onto the
orthogonal encoding axes of colour and shape.                                    βcolour,task i ⋅ βcolour,task j
                                                                                 cos( θ) =
                                           T                                        βcolour,task i βcolour,task j              pcolour,protoype = βcolour Xprototype

                                           T                        Where i and j are task identity of the tasks. Within-task angles
               pshape,protoype = βshape Xprototype                   (Extended Data Fig. 9c,d) were computed by randomly taking 200
                                                                       pairs of resampling regression coefficient repetitions, and finding the
  Distance was measured along the orthogonal encoding axis of shape   orthogonal axes explained above. All angles were wrapped to 90 deg.
and colour using projected responses:                               This was because the process of orthogonalization with QR decompo-
                                                                          sition might result in vectors that are mathematically equivalent but
 colour encoding distance                                                                with a flipped sign compared to the input vectors owing to numerical
                                                                                       choices or conventions.         abs                                                                             ,                                                                               (            pcolour,red bunny − pcolour,green bunny )   = Avg                                                             We used a permutation test to assess whether the angle between pairs
                                                                     of tasks was significantly larger than expected by chance. The observed                                                                              abs               (              pcolour,red tee − pcolour,green tee )                                                                                                                                     angle was estimated by fitting the regression model explained above to
<!-- [figure panel text removed: 599 chars; see corresponding image] -->
<!-- [figure panel text removed: 677 chars; see corresponding image] -->
                                                        The likelihood of the observed angle was then estimated by computing
  CPI was defined as the log of the ratio of the average colour encoding   the proportion of permuted datasets that yielded an angle smaller than
distance and average shape encoding distance as described above:     or equal to that of the observed angle.
## Page 19
Article

                                                                                              59.  Axensten, P. chi2test (MATLAB Central File Exchange, 2007); www.mathworks.com/
Quantifying whether task representations transfer across blocks         matlabcentral/fileexchange/16177-chi2test.                                                                                       60.  Maris, E. & Oostenveld, R. Nonparametric statistical testing of EEG- and MEG-data.
To test whether the task representation was maintained across blocks             J. Neurosci. Methods 164, 177–190 (2007).
(Fig. 4b), we trained a classifier to discriminate between C1 and S1 tri-     61.  Chiang, F.-K. & Wallis, J. D. Neuronal encoding in prefrontal cortex during hierarchical
                                                                                              reinforcement learning. J. Cogn. Neurosci. 30, 1197–1208 (2018).
als using the last 50 trials of the block. We then tested this classifier in    62.  Yue, S., Pilon, P., Phinney, B. & Cavadias, G. The influence of autocorrelation on the
three ways. First, to quantify the information about the identity of C1          ability to detect trend in hydrological series. Hydrol. Process. 16, 1807–1829 (2002).
versus S1 task, we tested this classifier on withheld trials from last 50    63.  Yue, S. & Wang, C. Y. Applicability of prewhitening to eliminate the influence of serial
                                                                                                       correlation on the Mann-Kendall test. Water Resour. Res. 38, 4-1–4-7 (2002).
trials of C1 and S1 tasks (Fig. 4b (1)). Second, to quantify how much the    64.  Collaud Coen, M. et al. Effects of the prewhitening method, the time granularity, and the
representation of C1 and S1 tasks transferred to the C2 task, we tested        time segmentation on the Mann–Kendall trend detection and the associated Sen’s slope.
whether the classifier could discriminate between C1 and S1 tasks dur-        Atmos. Meas. Tech. 13, 6945–6964 (2020).
                                                                                              65.  Flesch, T. et al. Are task representations gated in macaque prefrontal cortex? Preprint at
ing the first 50 trials of the C2 task (that is, comparing C1–C2 versus         https://doi.org/10.48550/arXiv.2306.16733 (2023).
S1–C2). Third, to quantify how much the representation of C1 and S1    66.  Tafazoli, S. et al. Data for ‘Building compositional tasks with shared neural subspaces’.
tasks was transferred to C1 or S1 in the next block, we tested the classi-         Figshare https://doi.org/10.6084/m9.figshare.30276238.v1 (2025).
                                                                                                        67.   Tafazoli, S. et al. Code for ‘Building compositional tasks with shared neural subspaces’.
fier on the first 50 trials after the switch in C1 and S1 tasks.                    Zenodo https://doi.org/10.5281/zenodo.17274345 (2025).
  For all training and testing, the total number of spikes in the period    68.  Buschman, T. J., Denovellis, E. L., Diogo, C., Bullock, D. & Miller, E. K. Synchronous
−400 to 0 ms from stimulus onset for each trial were used to build          oscillatory neural ensembles for rules in the prefrontal cortex. Neuron 76, 838–846 (2012).
                                                                                             69.  Miller, E. K. & Cohen, J. D. An integrative theory of prefrontal cortex function. Ann. Rev.
a pseudopopulation. Only correct trials were included in this analy-         Neurosci. 24, 167–202 (2001).
sis, and the training and test trials were balanced for congruent and
incongruent stimuli (36 trials: 9 trials for each of the four stimulus
                                                                           Acknowledgements We thank B. Morea and N. Rajagopalan for assistance with monkeys;
congruency types). To compute a null distribution, we generated 1,000    S. Ostojic, C. Brody, T. Engel, C. M. Langdon and H. Maleki for discussions; I. Wahle and T. Engel
permuted datasets by randomly permuting all task identity values     for help with revision; T. Engel, C. Jahn, Q. He, P. Iamshchinina, I. Wahle, S. Akers-Campbel and
relative to the neural activity and refitting the classifier.                               J. Park for feedback on the manuscript; and the Princeton Primate Research Resources staff for
                                                                                            support. This work was supported by National Institutes of Health (NIH) grants R01MH129492
                                                                                                          (to T.J.B.) and NIH 5T32MH065214 (to A.A.).
Reporting summary
Further information on research design is available in the Nature Port-   Author contributions T.J.B. and S.T. conceived the project. S.T. collected experimental data
folio Reporting Summary linked to this article.                                with assistance from N.T.M., M.U. and T.J.B.; S.T. analysed the data with input from T.J.B., A.A.,
                                                                                                         F.M.B., M.G.M. and N.D.D.; S.T. wrote first draft of the paper. S.T., T.J.B., F.M.B., M.G.M., A.A.,
                                                                                                      N.D.D., N.T.M. and M.U. edited the paper. T.J.B. acquired funding. T.J.B. supervised the project.
Data availability                                                      Competing interests The authors declare no competing interests.
Processed data are publicly available at FigShare66 (https://doi.org/
10.6084/m9.figshare.30276238.v1).                                              Additional information
                                                                               Supplementary information The online version contains supplementary material available at
                                                                                              https://doi.org/10.1038/s41586-025-09805-2.
                                                                              Correspondence and requests for materials should be addressed to Sina Tafazoli or
Code availability                                                           Timothy J. Buschman.
                                                                                   Peer review information Nature thanks the anonymous reviewers for their contribution to the
Custom MATLAB analysis functions are publicly available at Zenodo67    peer review of this work. Peer reviewer reports are available.
(https://doi.org/10.5281/zenodo.17274345).                                   Reprints and permissions information is available at http://www.nature.com/reprints.
## Page 20
Extended Data Fig. 1 | Both monkeys perform all three tasks accurately.       C1 tasks and last 51 trials of blocks of C2 task. N indicates the number of blocks
Follows Fig. 1e. Average psychometric curve for (a) monkey Ch and (b) monkey    per task. Error bars show mean ± s.e.m.
Si. Behavioural performance is shown for the last 102 trials of blocks of S1 and
![Figure on page 20](images/page20_img00.png)

## Page 21
Article

Extended Data Fig. 2 | Behaviour varied for congruent and incongruent       colour categorization performance when the shape morph level of the stimulus
stimuli. Follows Fig. 1e. a, Psychometric curve for S1 (left), C2 (middle), and C1    was ambiguous (50%/150%, left), intermediate (30%/70%/130%/170%, middle)
(right) tasks for incongruent (dashed) and congruent (solid) stimuli. *, **, and     and prototypical (0%/100%, right). Error bars show mean ± s.e.m. n = 94/97/189
*** indicate p < 0.05, 0.01, and 0.001, respectively, one-sided binomial test.       blocks of S1/C1/C2 tasks, respectively. d, Psychometric curve for C1 and C2
p < 10−16 for all data points. Since congruency is undefined for the 50% morph      tasks when proportion of choices was computed based on responses according
line, there are no corresponding data points available. Error bars show mean ±     to irrelevant feature (shape). Shape affects behavioural responses during the
s.e.m. n = 94/97/189 blocks of S1/C1/C2 tasks, respectively. b, Psychometric      C1 task but not the C2 task. This is again consistent with the idea that the decrease
curve for congruent trials for C1 and C2 tasks using all trials in the block. Since      in behavioural performance during the C1 task is due to interference from the
congruency is undefined for the 50% morph line, there are no corresponding      S1 task. e-f, Comparison of behavioural performance of S1 (orange) and C1
data points available. Behavioural performance on congruent stimuli, where      (green) tasks e, in the first 15 trials of the block (after switch) and f, for the last
there is no conflict between the C1 and S1 tasks, is similar between the C2 and C1   15 trials of the block (before switch). Red and green dotted line show mean
tasks. This is consistent with the idea that the relatively lower behavioural        behavioural performance for S1 and C1 tasks, respectively. g, Proportion of
performance during the C1 task is due to interference from the S1 task (possibly   responses on incorrect axis for C1, C2 and S1 tasks. h, Proportion of responses
due to uncertainty over which task to perform). Error bars show mean ± s.e.m.    on incorrect axis during the S1 task (left), C2 task (middle) and C1 task (right)
n = 94/97/189 blocks of S1/C1/C2 tasks, respectively. c, Psychometric curve for    did not depend on the sequence of tasks (S1-C2 in orange and C1-C2 in green).
![Figure on page 21](images/page21_img00.png)

## Page 22
Extended Data Fig. 3 | Task variables are widely distributed in neurons        regions. Each panel shows the proportion of neurons that significantly encode
across multiple brain regions. a, Follows Fig. 1m. Normalized CPD for task      two task variables (left and middle columns) and encode both (right column).
identity averaged for all regions. Lines and shading show mean± s.e.m. Task      For all panels, *, **, and *** indicate p < 0.05, 0.01, and 0.001, respectively, all
identity representation increased by 51.5% from baseline during the stimulus     one-sided permutation tests. b-e, Response direction and b, reward, c, task
processing period. Previous research has reported similar dynamics in task        identity, d, colour category, and e, shape category. f-h, reward and f, task identity,
representations, suggesting that as an animal prepares to process and respond    g, colour category, and h, shape category. i-k, task identity and i, colour category
to a visual stimulus, task-relevant information increases to facilitate task        and j, shape category. k, colour category and shape category.
execution68. b-k, Individual neurons represent multiple task variables across
![Figure on page 22](images/page22_img00.png)

## Page 23
Article

Extended Data Fig. 4 | See next page for caption.
![Figure on page 23](images/page23_img00.png)

## Page 24
Extended Data Fig. 4 | Colour category, shape category and response direction   Time course of accuracy of classifier trained to decode the colour category of
were encoded in all regions. a, Follows Fig. 2a. Time course of accuracy of        the stimulus. Classifiers were trained for each task and tested on withheld trials
classifier trained to decode the colour category of the stimulus during the C1      of the same task (coloured lines). Classifiers were trained separately for each
task based on neural activity in LPFC. To control for movement, the number of     brain region: Striatum, aIT, FEF, and PAR in each column, moving left to right.
trials with each response direction were balanced within each colour category.    Lines and shading show mean ± s.e.m. classification accuracy after stimulus
Only trials with responses on the correct response axis were included (e.g., Axis   onset. Distribution reflects 250 iterations of classifiers. Horizontal bars along
1 for task C1). Lines and shading show mean ± s.e.m. classification accuracy after   top indicate above-chance classification (p < 0.05, 0.01, and 0.001 for thin,
stimulus onset. Distribution reflects 250 iterations of classifiers. Horizontal     medium, and thick lines, respectively; two-sided permutation test with cluster
bars along top indicate above-chance classification (p < 0.05, 0.01, and 0.001     mass correction for multiple comparisons). f, Follows Fig. 2b. As in panel e, but
for thin, medium, and thick lines, respectively, two-sided permutation test with    for shape category information. g, Follows Fig. 2c. Time course of accuracy of
cluster mass correction for multiple comparisons). b, Follows Fig. 2c. Time course    classifier trained to decode response direction for S1 and C1 tasks. Classifiers
of accuracy of classifier trained to decode response direction during the C2 task   were trained separately for each brain region: Striatum, aIT, FEF, and PAR in
from neural activity in LPFC. Classifier was trained on a balance of rewarded      each column, moving left to right. Classifiers were trained on a balance of
and unrewarded trials. Lines and shading show mean ± s.e.m. classification      rewarded and unrewarded trials. Lines and shading show mean ± s.e.m.
accuracy after stimulus onset. Distribution reflects 250 iterations of classifiers.    classification accuracy after stimulus onset. Distribution reflects 250 iterations
Horizontal bars along top indicate above-chance classification (p < 0.05, 0.01,     of classifiers. Horizontal bars along top indicate above-chance classification
and 0.001 for thin, medium, and thick lines, respectively; two-sided permutation    (p < 0.05, 0.01, and 0.001 for thin, medium, and thick lines, respectively; two-
test with cluster mass correction for multiple comparisons). c, As in panel a, but   sided permutation test with cluster mass correction for multiple comparisons).
showing time course of accuracy of classifier trained to decode colour category   h, Follows Fig. 2i. As in panel g, but showing time course of accuracy of
within C1 task. Trials were drawn from the last 100 trials in the block and balanced    classifier trained on S1 task (green) or C1 task (orange) and then tested on the
for reward. d, As in panel c, but for shape category within S1 task. e, Follows Fig. 2a.   other task (C1 and S1, respectively).
## Page 25
Article

Extended Data Fig. 5 | Colour category was cross decoded between tasks in    correction for multiple comparisons). d, Classifiers are unable to decode response
LPFC. a, Accuracy of classifier trained to decode colour category from LPFC       direction between axes. Classifiers were trained to decode response direction
neural activity when trained on C2 task and tested C1 task (left); trained on C1     from LPFC neural activity during the C1 task (left) or C2 task (right) and then
task and tested on C2 task (middle); and trained on C1 task and tested on C1 task    tested on accuracy to decode the matched hemifield location during the C2
(right). Top row shows accuracy when using a linear kernel for classifier and       task (left) or C1 task (right). Lines and shading show mean ± s.e.m. classification
bottom row shows accuracy when using radial basis function (RBF) kernel for     accuracy after stimulus onset. Distribution reflects 250 iterations of classifiers.
classifier. Lines and shading show mean ± s.e.m. over time. Distribution reflects   Horizontal bars indicate above-chance classification (p < 0.05, 0.01, and 0.001
250 resampled classifiers (see Methods for details). b, As in Fig. 2e, but showing    for thin, medium, and thick lines, respectively; two-sided permutation test with
the cross-temporal cross-task classification accuracy in decoding shared colour    cluster mass correction for multiple comparisons). e, As in Fig. 2f, but showing
category in LPFC when training on C1 task trials and testing on C2 task trials.       the accuracy of classifiers trained to decode colour category from LPFC neural
c, Time course of accuracy of classifier trained to decode colour category on       activity during the C1 task (orange) and S1 task (green) and then tested on the
trials of the C1 task, while balancing motor response (as in Extended Data Fig. 4a).   other task (S1 and C1, respectively). Classifiers were trained only on correct trials.
Classifier is then tested on the C2 task. Note, reduction in decoding accuracy     Lines and shading show mean ± s.e.m. classification accuracy after stimulus
reflects the reduced number of trials and introduction of error trials. Lines       onset. Distribution reflects 250 iterations of classifiers. Horizontal bars indicate
and shading show mean ± s.e.m. classification accuracy after stimulus onset.     above-chance classification (p < 0.05, 0.01, and 0.001 for thin, medium, and thick
Distribution reflects 250 iterations of classifiers. Horizontal bars along top        lines, respectively; two-sided permutation test with cluster mass correction for
indicate above-chance classification (p < 0.05, 0.01, and 0.001 for thin, medium,   multiple comparisons).
and thick lines, respectively; two-sided permutation test with cluster mass
![Figure on page 25](images/page25_img00.png)

## Page 26
Extended Data Fig. 6 | Colour category was shared across tasks in a subset     of classifiers. Horizontal bars along top indicate above-chance classification
of regions. a, top, Follows Fig. 2f. Time course of accuracy of classifier trained      (p < 0.05, 0.01, and 0.001 for thin, medium, and thick lines, respectively; one-
to decode the colour category during the C1 task (blue) and C2 task (green), and    tailed t-test with no correction). c, Comparison of strength of shared colour
then tested on the other task (C2 and C1, respectively). Independent classifiers    category responses in LPFC to other regions. All classifiers were trained to
were trained for each brain region: Striatum, aIT, FEF and PAR (from left to right,   decode colour category in C2 task and then tested on C1 task. LPFC neurons
across columns). Classifiers were trained on correct trials alone. Lines and shading   were down sampled to match the number of neurons included for this analysis
show mean ± s.e.m. classification accuracy after stimulus onset. Distribution      in each other brain region (110 neurons for Striatum, 195 neurons for aIT, 116
reflects 250 iterations of classifiers. Horizontal bars indicate above-chance     neurons for FEF and 54 neurons for PAR). Accuracy was averaged from 50 ms to
classification (p < 0.05, 0.01, and 0.001 for thin, medium, and thick lines,        150 ms after stimulus onset. Lines and shading show mean ± s.e.m. (p < 0.05,
respectively; two-sided permutation test with cluster mass correction for multiple   0.01 and 0.001 for *, **, ***, respectively; one-sided bootstrap test). d, Follows
comparisons). bottom, Same as top, but using balanced response direction        Fig. 2g. Difference in the onset of colour information during C1 task when
trials in each colour category. b, Time course of accuracy of classifier trained to   decoded from classifiers trained on C1 task versus generalized from C2 task
decode colour category within C1 task and across C1 and C2 tasks. Classifiers       (vertical dashed lines panels a and f, respectively. p < 0.05, 0.01 and 0.001 for
were trained separately for each brain region (Striatum, aIT, FEF, and PAR in            *, **, ***, respectively; two-sided permutation test. LPFC P = 0.5164, aIT
each column, moving left to right). Lines and shading show mean ± s.e.m.         P = 0.3406, FEF P = 0.0009, PAR P = 0.0009). Boxes represent interquartile range
classification accuracy after stimulus onset. Distribution reflects 1000 iterations    (25th–75th percentile), and the red horizontal line inside each box is the median.
![Figure on page 26](images/page26_img00.png)

## Page 27
Article

Extended Data Fig. 7 | Shared colour category in C2 task was transformed      indicate p ≤ 0.05 and p ≤ 0.001, respectively, two-sided uncorrected t-test.
into response on Axis 2 and not Axis 1. As in Fig. 3c, but shows cross-temporal    d, The time course of LPFC neural activity projected on axis encoding colour
correlation across trials of shared colour category encoding (trained on C1 task,   category and axis encoding response on Axis 1 for C1 (left), C2 (middle) and S1
tested on C2 task) and response direction encoding on Axis 2 (trained on C2        (right) tasks. Line colours match the actual colour of the stimuli on the colour
task, tested on C2 task). Thin and thick red lines indicate p ≤ 0.05 and p ≤ 0.001,    wheel. Neural activity is aligned to saccade onset time. There is no movement
respectively, uncorrected two-sided t-test. b, As in Fig. 3d, but correlating shared   along the axis encoding the response on Axis 1 for S1 because there are equal
colour category encoding (trained on C1 task, tested on C2 task) and response    number of stimuli for each colour morph level that are projected in either
direction encoding on Axis 1 (trained on S1 task, tested on C2 task). Thin and thick   direction in Axis 1. e, As in panel d, but for LPFC neural activity during S1 task,
red lines indicate p ≤ 0.05 and p ≤ 0.001, respectively, uncorrected two-sided     projected on axis encoding shape and axis encoding response on Axis 1 f, As in
t-test. c, As in Fig. 3e, but average cross-temporal correlation along anti-diagonal   panel d, but for LPFC neural activity projected on axis encoding colour and axis
axis in panel a (shared colour encoding in C2 task predicts response direction    encoding response on Axis 2. g, As in panel e, but for LPFC neural activity in task
in C2 task, blue line) and panel b (shared colour encoding in C2 task predicts       S1 projected on axis encoding shape and axis encoding response on Axis 2.
response direction in S1 task, red line). Thin and thick red lines in panels b, c
![Figure on page 27](images/page27_img00.png)

## Page 28
Extended Data Fig. 8 | See next page for caption.
![Figure on page 28](images/page28_img00.png)

## Page 29
Article

Extended Data Fig. 8 | Task sequence affected behavioural performance in    switch C1 and S1, test before switch C1 and S1: 56%, p = 0.087; Train before switch
S1 and C1 tasks but not in C2 task. a, Follows Fig. 4a. Comparison of average     C1 and S1, test after switch C2: 54%, p = 0.032; Train before switch C1 and S1, test
behavioural performance of both monkeys on S1 task when at the end of a sequence    after switch C1 and S1: 56%, p = 0.002). There was no significant information
of S1-C2-S1 tasks or C1-C2-S1 tasks. Horizontal bars indicate significant difference   about the previous task in PAR or Striatum, although this likely reflects a limited
between performance in two sequences, p < 0.05, 0.01, and 0.001 for thin,      number of neurons recorded in each region. g, Comparison of progression of
medium, and thick lines, respectively, one-sided chi-squared test, uncorrected    colour category classifier accuracy in C1-C2-C1 task sequence (purple) and S1-
for multiple comparisons across trials. Number of included blocks for S1-C2-S1/   C2-C1 task sequence (black) for FEF. Average accuracy was computed using
C1-C2-S1 sequences were 40/54, respectively. Error bars show mean ± s.e.m.        classifier performance in 200 ms to 400 ms after stimulus onset period. Lines
b, As in panel a, but comparing average behavioural performance of both monkeys   and shading show mean ± s.e.m. classification accuracy after stimulus onset.
for S1-C2 and C1-C2 task sequences. Number of included blocks for S1-C2/C1-C2    Distribution reflects 250 iterations of classifiers. ∆(average accuracy S1-C2-C1
sequences were 82/87, respectively. Lines and shadings show mean ± s.e.m.      and C1-C2-C1 sequences)=12.7%, p = 0.004, two-sided uncorrected bootstrap
c-e, During task discovery, task belief encoding was inversely correlated with       test. On C1-C2-C1 blocks, behavioural performance starts high and only improves
behavioural performance for shape category and positively correlated with          slightly during the block (68% on trial 15 to 78% on trial 75 in C1-C2-C1 blocks,
behavioural performance for colour category. c, Follows Fig. 4e. Correlation       compared to 58% on trial 15 to 76% on trial 75 in S1-C2-C1 blocks). Given this,
between the neurally-estimated task belief (based on task classifier, see         there may not need to be a change in the strength of colour representation
Methods) and shape category behavioural performance in C1 task for S1-C2-C1     during the block. Indeed, the competition from the shape category is low
task sequences. Negative correlation reflects an increase in the behavioural        throughout C1-C2-C1 blocks, reflected in the fact that shape information is at or
performance in C1 task (thus a decrease in shape performance) when task belief is   below chance levels (Fig. 4j). In other words, performance may already be ‘optimized’
closer to the C1 task. p < 0.05, 0.01, and 0.001 for thin, medium, and thick lines.    and therefore a change may not be needed. If true, one might expect LPFC to
Z-scored Kendall’s tau with permutation test and cluster mass correction for     become less engaged as the task becomes more certain. Previous work has
multiple comparisons across time. d, As in panel c, but for correlation between   suggested that LPFC is most strongly engaged when cognitive control is
the neurally-estimated task belief and colour category behavioural performance   needed – that is, when the task is uncertain69. Therefore, the decrease in task
in C1 task for C1-C2-C1 task sequences e, As in panel c, but for correlation         representations could reflect the engagement of other neural circuits, such as
between the neurally-estimated task belief and shape category behavioural        FEF, as shown here, to represent the colour category during the C1-C2-C1 sequence
performance in C1 task for C1-C2-C1 task sequences. f, Follows Fig. 4b. Classifier    in comparison to the S1-C2-C1 sequence. h, Follows Fig. 4h, correlation between
accuracy for decoding the identity of C1 and S1 tasks in FEF using last 50 trials      neurally estimated task belief encoding and shape category encoding
of the C1 and S1 tasks (left), trials of C2 task (middle), and 50 trials after switch     performance in C1 task for S1-C2-C1 task sequences. Two-sided uncorrected
of C1 and S1 tasks (right). Numbers inside coloured circles denote corresponding     permutation test. i, Follows Fig. 4k. Correlation between neurally-estimated
classification task in Fig. 4b. Coloured circles denoted observed values and violins   task belief and decoded response direction during the C1 task for S1-C2-C1 task
show shuffle distribution. p < 0.05, 0.01, and 0.001 for *, **, and ***, respectively,   sequences. There was a weak correlation between stronger belief encoding and
two-sided permutation test. Similar to LPFC, information about the previous     an increase in response direction encoding, but it was not significant. Two-
task was present in FEF, both throughout the C2 block and the beginning of the    sided uncorrected permutation test. j, Follows Fig. 5b. Both the timing (blue)
next block (60 neurons, Train before switch C1 and S1, test before switch C1 and   and amplitude (black) of the maximum distance along the shape encoding axis
S1: 64%, p = 0.0009; Train before switch C1 and S1, test after switch C2: 60%,      changed over trials as the animals discovered the task. The maximum distance
p = 0.0009; Train before switch C1 and S1, test after switch C1 and S1: 54%,       was estimated by fitting a Gaussian CDF function to classifier accuracy in each
p = 0.0009). The effect was trending in aIT (not shown; 98 neurons, Train before     trial window.
## Page 30
Extended Data Fig. 9 | See next page for caption.
![Figure on page 30](images/page30_img00.png)

## Page 31
Article

Extended Data Fig. 9 | Colour classifiers were aligned in the C1 and C2 tasks.    S1 tasks and C2 task the angle between the C2 response axis and the C1 or S1
a, Angle between classifier hyperplanes trained on C1 and C2 tasks (blue) and     response axes were not significantly different from chance (θ(S1-C2 after
between classifier hyperplanes trained on split halves of the C1 task (black).       switch)=86.44°, p = 0.612, θ(S1-C2 before switch)=86.023°, p = 0.715, θ(C1-C2
Classifiers were trained on n = 24 randomly sampled trials for 250 iterations.       after switch)=86.28°, p = 0.594, θ(C1-C2 before switch)=83.1203°, p = 0.363).
Grey shaded region shows mean ± s.e.m. of angles for randomly permuted data.   Dashed lines show noise floor estimated by computing the angle between
Horizontal bars along top indicate significant angles with respect to chance      response direction axes of repetitions of C1 (blue) and C2 (green) tasks using all
(two-tailed permutation test, cluster corrected for multiple comparisons).         trials during the block (θ(within C1) = 12.05°, p = 0.0009, θ(within C2) = 16.76°,
b, As in a, but average angle during sensory response period (100 ms - 300 ms      p = 0.0009). Box and whisker plots show distribution of 200 resamples of
after stimulus onset, blue shaded region in panel a). Error bars show mean ±      75% trials used to fit the GLM model. Grey box and whisker plots show null
s.e.m. of angles for randomly permuted data. *, **, and *** indicate p < 0.05, 0.01,   distribution of 1000 random permutations of 75% of trials used to fit the GLM
and 0.001, respectively, one-sided permutation test. c, Angle between the axis    model. All boxes represent interquartile range, red and grey horizontal lines
encoding the colour category in pairs of tasks. Axes were estimated using targeted   indicate median, whiskers indicate full extent of data. *, **, and ***, indicate
dimensionality reduction (TDR) using n = 480 LPFC neurons (see Methods)        p < 0.05, 0.01, and 0.001, respectively, all one-sided permutation tests e-g,
at the beginning of the block (‘from switch’, orange) and end of the block (‘to      Colour and shape representations were scaled by task belief in all regions, except
switch’, black). The angle between the colour representation during the C1 task     aIT. e, Normalized distance on colour and shape axes for LPFC, FEF, PAR and aIT
and C2 task was not significantly different from chance at the beginning of the    (from left to right). Axes were estimated using TDR to remove motor responses21
block (θ(C1-C2 after switch)=82.27°, p = 0.234) but was significantly lower than    (see Methods). Figure axes show distance of neural response representing
chance at the end of the block (θ(C1-C2 before switch)=71.23°, p = 0.0029). This    different stimuli, projected onto the shape (y-axis) and colour axes (x-axis).
is consistent with the classifier results in Fig. 4f and suggests the C1 colour       Neural activity from 100ms−400ms after stimulus onset. Points above [below]
representation became aligned with the C2 colour representation as the animals   the diagonal indicate a greater distance along the shape [colour] axis compared
discovered the C1 task. In contrast, the angle between the colour representation   to the colour [shape] axis (i.e., greater encoding of shape [colour]). As in Fig. 5c,
in S1 and the C1 or C2 tasks was not significantly different from chance at any      colour representations in LPFC, FEF and PAR were more separated during C1
point (θ(S1-C1 after switch)=83.75°, p = 0.101, θ(S1-C1 before switch)=86.067°,    and C2 tasks while shape representations were more separated during S1 task.
p = 0.588, θ(S1-C2 after switch)=85.34°, p = 0.358, θ(S1-C2 before switch)=       Encoding in aIT was not affected by task (colour representation was always
86.106°, p = 0.780). This suggests colour representations are less shared between   greater and did not scale by task in the predicted way). f, Compression Index
the S1 task and C1 or C2 tasks, although this may reflect the reduced colour          (CPI) of stimulus representations in LPFC, FEF, PAR and aIT, for all three tasks.
response during S1. Dashed lines show noise floor estimated by computing       CPI was taken as the log of the ratio of the separability of stimuli when projected
the angle between response direction axes of repetitions of C1 (blue) and C2      onto the colour and shape axes from TDR (averaged in the period 100 ms to
(green) tasks using all trials during the block (θ(within C1) = 29.78°, p = 0.0009,    400 ms after stimulus onset). CPI greater than [less than] zero reflects stronger
θ(within C2) = 19.43°, p = 0.0009). Box and whisker plots show distribution of       relative encoding of colour [shape]. g, Follows Fig. 5c. CPI of neural responses in
200 resamples of 75% trials used to fit the GLM model in TDR. Grey plots show      FEF, aIT and PAR over time, for all three tasks. Here, CPI is taken as the log of the
null distribution of 1000 random permutations of 75% of trials used to fit the       ratio of the separability of stimuli in colour and shape subspaces using classifier
GLM model. All boxes represent interquartile range, red and grey horizontal      encoding axis. CPI in FEF is similar to LPFC, with greater separation of colour
lines indicate median, whiskers indicate full extent of data. *, **, and ***, indicate   representations during C1 and C2 tasks and greater separation of shape
p < 0.05, 0.01, and 0.001, respectively, all one-sided permutation tests. d, As in    representations during S1 task. CPI was reduced in PAR overall but showed a
panel c, but showing the angle between the axis encoding the response location    similar pattern with greater separation of colour in the C2 task and shape in the
in pairs of tasks. Consistent with a shared response representation between the   S1 task (C1 was less clear). CPI in aIT was close to zero for all tasks. This is consistent
C1 and S1 tasks, the angle between the response axes was significantly lower      with previous findings23 that task-dependent compression of features is
than chance both at the beginning and end of the block of the task (θ (S1-C1       limited in sensory regions. Striatum did not show significant colour or shape
after switch) =40.92°, p = 0.0009; θ(S1-C1 before switch) =33.35°, p = 0.0009).    information and so CPI is not reliable.
In contrast, consistent with orthogonal response representations in the C1 or
## Page 32
Extended Data Fig. 10 | See next page for caption.
![Figure on page 32](images/page32_img00.png)

## Page 33
Article

Extended Data Fig. 10 | Neurons encoding response on Axis 1 and Axis 2 are      t-test), whereas lines and shading show mean response across neurons, ± s.e.m,
suppressed when irrelevant to the task. a, Classifier weights for classifying     over time. e, As in panel d, but axis selectivity was defined by training a classifier
axis of response for Fig. 5g. Classifier was trained to decode response axis using   to decode response axis using trials from C1 and C2 trials and then firing rate was
C1 and C2 task trials. Neurons with significant weights for Axis 1 and Axis 2 are     estimated on withheld S1 trials. Inset shows p-value for of difference between
denoted with green and orange dots, respectively. Non-selective neurons are      firing rate in response on Axis 1 and response on Axis 2 trials in time periods
denoted with grey dots. b, Follows Fig. 5g, time course of average firing rate for   −600ms-0ms (lower bracket) and −600ms-600ms (upper bracket) after stimulus
non-selective neurons in LPFC. Inset shows p-value of difference in firing rate     onset (two-sided paired t-test). Lines and shading show mean ± s.e.m, over time.
when animal responded on Axis 1 compared to responding on Axis 2 (two-sided      f-i, As in Fig. 5g, but shown for f, FEF; g, aIT; h, PAR and i, Striatum. Similar to
paired t-test). Lines and shading show mean ± s.e.m. c, Follows Fig. 5g, time course   LPFC, Axis 1 and Axis 2 selective neurons in FEF, aIT and PAR were suppressed
of average firing rate of neurons when the animal responded on Axis 1 (dashed)    during response on opposite axis. Lines and shading show mean ± s.e.m. firing
or Axis 2 (solid). Neurons were grouped by their preferred response on Axis 1       rate across individual neurons for each region. Inset shows p-value for of difference
(left) or Axis 2(right). Shaded blue box indicates the time period used to define    between firing rate in response on Axis 1 and response on Axis 2 trials in time
the neurons preferred response axis (200ms–450ms after stimulus onset). Lines   periods −600ms-0ms (lower bracket) and −600ms-600ms (upper bracket)
and shading show mean ± s.e.m, over time. d, Follows Fig. 5g. Average firing rate    after stimulus onset (two-sided paired t-test). j, As in Fig. 5h, but shows classifier
of LPFC neurons during trials when the animal responded on Axis 1 (green) and    accuracy in decoding the response axis for all brain regions. Darker to lighter
Axis 2 (pink). Three panels show responses of three categories of neurons: those   colour show progression in trial blocks of 10 shifted by 3 trials from switch trial
that responded most strongly on Axis 1 (left), Axis 2 (middle), and were not       in C1 task. Lines show mean classification accuracy after stimulus onset for
selective (right) in LPFC. To characterize axis selectivity, classifier was trained    250 iterations of classifiers. Arrows indicate the time course of example trials.
to decode response axis using trials from S1 and C2 trials and then firing rate was    k, Classifier accuracy in decoding the response axis for all brain regions. Decoding
estimated on withheld C1 trials. Inset shows p-value for of difference between     using neural activity in −400ms to 0 ms before stimulus onset period. Lines and
firing rate in response on Axis 1 and response on Axis 2 trials in time periods       shading show mean ± s.e.m. classification accuracy across 250 iterations of
−600ms-0ms (lower bracket) and −600ms-600ms (upper bracket) after stimulus    classifiers.
onset. Note, tests are performed pairwise within each neuron (two-sided paired
## Page 34
                                                                                                   Double-anonymous peer review submissions:                                                                                                                     write DAPR and your manuscript number here            nature
                                                                      Corresponding author(s):  instead of author names.

<!-- [figure panel text removed: 578 chars; see corresponding image] -->

                                                  |

Reporting Summary                                                                                                                                                                                                                                                                                                                                                                                                                                                                     reporting
Nature Portfolio wishes to improve the reproducibility of the work that we publish. This form provides structure for consistency and transparency
in reporting. For further information on Nature Portfolio policies, see our Editorial Policies and the Editorial Policy Checklist.
                                                                                                                                                                                                                                                                                                                                                                summary

Statistics

For all statistical analyses, confirm that the following items are present in the figure legend, table legend, main text, or Methods section.

n/a  Confirmed

        The exact sample size (n) for each experimental group/condition, given as a discrete number and unit of measurement

       A statement on whether measurements were taken from distinct samples or whether the same sample was measured repeatedly

        The statistical test(s) used AND whether they are one- or two-sided
          Only common tests should be described solely by name; describe more complex techniques in the Methods section.

       A description of all covariates tested

       A description of any assumptions or corrections, such as tests of normality and adjustment for multiple comparisons

       A full description of the statistical parameters including central tendency (e.g. means) or other basic estimates (e.g. regression coefficient)
      AND variation (e.g. standard deviation) or associated estimates of uncertainty (e.g. confidence intervals)

         For null hypothesis testing, the test statistic (e.g. F, t, r) with confidence intervals, effect sizes, degrees of freedom and P value noted
          Give P values as exact values whenever suitable.

         For Bayesian analysis, information on the choice of priors and Markov chain Monte Carlo settings

         For hierarchical and complex designs, identification of the appropriate level for tests and full reporting of outcomes

         Estimates of effect sizes (e.g. Cohen's d, Pearson's r), indicating how they were calculated

                                        Our web collection on statistics for biologists contains articles on many of the points above.

Software and code

Policy information about availability of computer code

  Data collection  We presented stimuli and recorded behavioral responses using Psychtoolbox (version 3) and MATLAB (version 2015a). The behavioral
                        training code can be provided upon request. Electrophysiological data was acquired using Plexon Omniplex recording system (Plexon Inc.,
                         Dallas, TX.) Eye tracking data was gathered with an EyeLink 1000 (SR Research, software version 5.09). Neuron waveforms were sorted using
                       Plexon's Offline Sorter (version 4).

  Data analysis     The data underwent analysis utilizing both built-in functions and custom code developed in MATLAB (version 2024b & version 2021b). Built-in
                      functions include fitclinear for logistic regression, lassoglm for fitting GLM models, pca for dimensionality reduction, corr for Pearson's
                        correlation, and fminsearch for fitting psychometric curves. These are highlighted in the corresponding methods section. To quantify the
                           statistical significance of trends, we used Trend-Free PreWhitening (TFPW) as implemented in MK_tempAggr.m function (mannkendall
                     Version 1.1.0 ,https://mannkendall.github.io/Matlab) and referenced in Coen et al. 2020. The stimuli were rendered as three-dimensional
                   models using POV-Ray (version 3.7). To compute chi-squared test we used chi2test.m function implemented in MATLAB and referenced in
                    Axensten P, chi2test (https://www.mathworks.com/matlabcentral/fileexchange/16177-chi2test), MATLAB Central File Exchange (2007).
                    Procedures for non-standard statistical procedures are detailed in the methods. Code for custom functions are either referenced in the
                     manuscript with a pointer to the original source or are included in an online public repository (https://github.com/buschman-lab/
                      CompositionalTasks) and on Zenodo (https://doi.org/10.5281/zenodo.17274345).
For manuscripts utilizing custom algorithms or software that are central to the research but not yet described in published literature, software must be made available to editors and                        Aprilreviewers. We strongly encourage code deposition in a community repository (e.g. GitHub). See the Nature Portfolio guidelines for submitting code & software for further information.
                                                                                                                                                                                                                                                                                      2023

                                                                                                                  1
![Figure on page 34](images/page34_img00.png)

## Page 35
Data
Policy information about availability of data                                                                                                                                                                                                                       nature
  All manuscripts must include a data availability statement. This statement should provide the following information, where applicable:
      - Accession codes, unique identifiers, or web links for publicly available datasets
<!-- [figure panel text removed: 524 chars; see corresponding image] -->
      - For clinical datasets or third party data, please ensure that the statement adheres to our policy                     |

 Processed data have been deposited on the FigShare archive and can be accessed at https://figshare.com/articles/dataset/
<!-- [figure panel text removed: 558 chars; see corresponding image] -->

Research involving human participants, their data, or biological materialPolicy information about studies with human participants or human data. See also policy information about sex, gender (identity/presentation),                      summary
and sexual orientation and race, ethnicity and racism.

  Reporting on sex and gender    N/A

  Reporting on race, ethnicity, or  N/A
  other socially relevant
  groupings

  Population characteristics      N/A

  Recruitment                  N/A

  Ethics oversight               N/A

Note that full information on the approval of the study protocol must also be provided in the manuscript.

Field-specific reporting

Please select the one below that is the best fit for your research. If you are not sure, read the appropriate sections before making your selection.

    Life sciences               Behavioural & social sciences         Ecological, evolutionary & environmental sciences

For a reference copy of the document with all sections, see nature.com/documents/nr-reporting-summary-flat.pdf

Life sciences study design

All studies must disclose on these points even when the disclosure is negative.

  Sample size      As detailed in the manuscript, a total of 1,081 neurons were recorded from 5 brain regions across 2 animal subjects. The number of subjects
                         (2) and the number of neurons recorded per region (64-480) follows previous work using similar approaches (e.g., Panichello and Buschman
                       et al, 2021, Buschman and Miller, 2007; Mante et al, 2013; Siegel et al, 2015).

  Data exclusions   To ensure statistical power, neurons were omitted from specific analyses if they did not meet a predetermined number of trials in any
                      condition of interest. This exclusion criterion was predetermined and is delineated for each analysis in the methods section. Additionally, units
                       that were only partially detected during recording sessions were excluded. All analyses presented in this manuscript were conducted on
                        individual neurons, isolated based on their waveform.

  Replication       Independent experiments were performed in 2 animals, with 1,081 neurons recorded across 34 days. All data was included (except for
                       exclusions noted above). There were no failed replication attempts (i.e., no animals failed to learn the task). Neural recordings were
                     excluded only if the animals did not perform predetermined number of blocks during a recording session.

  Randomization   Each animal underwent exposure to every task manipulation. Task orders and trial conditions were randomized across trials within each
                        session. Neurons were recorded without bias. Electrodes were positioned to optimize the signal-to-noise ratio of the electrophysiological
                        signal without consideration of neural type or selectivity.

  Blinding           Since all animals were allocated to a single experimental group, blinding was neither necessary nor feasible during behavioral training.
                     Experimenters were blinded to experimental conditions while recording neurons and sorting waveforms into individual neurons.

                                                                                                                                                                                                                                                                                                                                                            April
Reporting for specific materials, systems and methods                                                             2023

                                                                                                                  2
## Page 36
We require information from authors about some types of materials, experimental systems and methods used in many studies. Here, indicate whether each material,
system or method listed is relevant to your study. If you are not sure if a list item applies to your research, read the appropriate section before selecting a response.              nature Materials & experimental systems       Methods

n/a  Involved in the study                        n/a  Involved in the study

<!-- [figure panel text removed: 534 chars; see corresponding image] -->
          Eukaryotic cell lines                                  Flow cytometry                         |

          Palaeontology and archaeology                        MRI-based neuroimaging

         Animals and other organisms

            Clinical data                                                                                                                                                                                                                                                                                                                                                                                                                                                                    reporting
         Dual use research of concern

          Plants                                                                                                                                                                                                                                                                                                                                                               summary
Animals and other research organisms

Policy information about studies involving animals; ARRIVE guidelines recommended for reporting animal research, and Sex and Gender in
Research

  Laboratory animals      Two adult male rhesus macaques (Macaca mulatta) participated in the experiment. Monkeys Si and Ch were between 8 and 11 years
                              old and weighed approximately 12.7 and 10.7 kg, respectively.

  Wild animals          No wild animals were used in this study.

  Reporting on sex         Both animals were male.

  Field-collected samples  No field-collected samples were used in this study.

  Ethics oversight              All experimental procedures were approved by the Princeton University Institutional Animal Care and Use Committee (protocol
                           #3055) and were in accordance with the policies and procedures of the National Institutes of Health.

Note that full information on the approval of the study protocol must also be provided in the manuscript.

Plants

  Seed stocks             N/A

  Novel plant genotypes   N/A

  Authentication          N/A

                                                                                                                                                                                                                                                                                                                                                           April
                                                                                                                                                                                                                                                                                      2023

                                                                                                                  3