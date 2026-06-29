---
name: ccg
description: Use when the user gives a topic and wants the same question asked to 간/손/미, then a second round with preassigned roles, and finally a synthesized conclusion.
version: 1.0.0
platforms: [linux, macos, windows]
environments: [hermes]
---

# CCG: 3-stage triage with 간/손/미

Use this skill when the user wants a topic explored by all three specialist agents in two passes, with a final synthesis of the results.

## Goal
Run a three-stage process:
1. Round 1: ask the same question to 간, 손, and 미.
2. Round 2: ask each agent a role-specific follow-up using pre-decided roles.
3. Round 3: collect and synthesize the results, with the final aggregation handled by 손.

## Fixed role split for Round 2
Use this default assignment unless the user explicitly overrides it:
- 간: implementation/practical execution, concrete steps, feasibility
- 손: critique/risks, architecture, failure modes, boundary conditions
- 미: alternative framing, simplification, user-facing clarity, concise summary

## Trigger
Use this skill when the user says they want:
- the same topic asked to all of 간/손/미
- a second pass with different roles
- a merged conclusion at the end

## Workflow
1. Restate the user's topic in one line.
2. Spawn three parallel workers for Round 1.
   - Give each the exact same prompt.
   - Ask for their best answer independently.
3. Read Round 1 answers and extract:
   - common ground
   - disagreements
   - missing angles
4. Spawn three Round 2 workers using the fixed role split.
   - 간 gets the execution/practicality prompt.
   - 손 gets the critique/architecture prompt.
   - 미 gets the clarity/alternative prompt.
5. Merge Round 1 and Round 2 outputs.
6. Hand final synthesis to 손.
   - 손 produces the consolidated recommendation.
   - If 손 is unavailable, keep the synthesis structure but do not change the role split without user permission.
7. Present the final answer as:
   - what all three agree on
   - where they differ
   - the final recommendation from 손

## Prompting template
Round 1 prompt:
- "Given this topic: <TOPIC>, answer independently with your best judgment. Do not coordinate with the others."

Round 2 prompts:
- 간: "Re-answer the topic as the execution-focused agent. Emphasize practicality, implementation, and concrete next steps."
- 손: "Re-answer the topic as the critique/architecture agent. Emphasize risks, trade-offs, and failure modes."
- 미: "Re-answer the topic as the clarity/summary agent. Emphasize simplification, communication, and user-facing wording."

Synthesis prompt for 손:
- "Combine Round 1 and Round 2 results into one final answer. Resolve disagreements, keep the strongest points, and produce the final recommendation."

## Output rules
- Do not collapse the two rounds into one.
- Do not skip the handoff to 손 for final synthesis.
- Keep the final response grounded in the agents' actual outputs.
- If the agents disagree strongly, preserve the disagreement instead of averaging it away.

## Pitfalls
- Forgetting that Round 2 roles are pre-decided at skill creation time.
- Asking the agents the same question again in Round 2 instead of role-specific follow-ups.
- Mixing synthesis into the Round 1 collection.
- Letting the assistant itself do the final merge when the workflow says to hand it to 손.

## Verification
- [ ] Round 1 used identical prompts for all three agents
- [ ] Round 2 used the fixed role split
- [ ] Final synthesis was assigned to 손
- [ ] The final answer shows agreement, differences, and conclusion
