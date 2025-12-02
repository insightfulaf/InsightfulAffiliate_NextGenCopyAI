import re, sys
from pathlib import Path

root = Path("docs/ai_outputs/_snippets")
out  = Path("docs/checklists/funnel_map.md")

keywords = {
  "hero": r"hero|headline|above[-_]?the[-_]?fold",
  "thank-you": r"thank[-_]?you|confirmation|success",
  "cta": r"\bcta\b|call[-_]?to[-_]?action|button",
  "faq": r"\bfaq\b|accordion",
  "badge": r"badge|guarantee|trust",
  "pricing|order": r"pricing|order[-_]?bump|checkout",
  "section": r"section|feature|benefit|testimonial",
}
funnels = {
  "ia-affiliate-launchpad": r"(ai[_-]?)?affiliate[_-]launchpad|ia[_-]aff(iliate)?[_-]launchpad",
  "ngcai-prompts-to-profit": r"prompts?[-_]?to[-_]?profit|ptp[-_]?playbook|nextgencopyai[-_]?playbook",
  "ngcai-copywriting-starter": r"copywriting[-_]?starter[-_]?kit|starter[-_]?kit[-_]?copy",
  "ia-inbox-convert": r"inbox[-_]?and[-_]?convert|inbox[-_]?convert",
}

def bucket(name:str)->str:
    n = name.lower()
    for k, pat in keywords.items():
        if re.search(pat, n):
            return k
    return "other"

def funnel_for(name:str)->str:
    n = name.lower()
    for label, pat in funnels.items():
        if re.search(pat, n):
            return label
    stem = re.sub(r"\.out\.md$", "", name, flags=re.I)
    toks = [t for t in re.split(r"[-_]", stem) if len(t) > 2 and not t.isdigit()]
    return "-".join(toks[:3]) or "general"

if not root.exists():
    print("No snippets directory found:", root, file=sys.stderr)
    sys.exit(0)

groups = {}  # funnel -> bucket -> [files]
for p in sorted(root.glob("*.out.md")):
    f = p.name
    fun = funnel_for(f)
    buck = bucket(f)
    groups.setdefault(fun, {}).setdefault(buck, []).append(str(p))

out.parent.mkdir(parents=True, exist_ok=True)
with out.open("w") as f:
    f.write("# Funnel Map (auto-generated)\n\n")
    f.write("> Source: docs/ai_outputs/_snippets/*.out.md\n\n")
    for fun in sorted(groups):
        f.write(f"## {fun}\n\n")
        for b in sorted(groups[fun]):
            f.write(f"### {b}\n")
            for file in groups[fun][b]:
                f.write(f"- `{file}`\n")
            f.write("\n")
print("Wrote", out)
