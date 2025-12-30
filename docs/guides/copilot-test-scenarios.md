# Copilot Configuration Test Scenarios

This document provides test scenarios to validate the GitHub Copilot configuration for this repository.

## Test Scenario 1: Content Generation

**Objective**: Test the Content Generator agent for creating product descriptions

**Steps**:
1. Create a test issue with the title "Generate AI tool product descriptions"
2. Assign the issue to @copilot
3. Select "Content Generator" agent
4. Provide requirements:
   ```
   Create 3 product descriptions for AI copywriting tools:
   - Jasper AI
   - Copy.ai  
   - Writesonic
   
   Requirements:
   - Use InsightfulAffiliate voice (practical, honest, educational)
   - Include pros and cons
   - Add FTC disclosure
   - 200-300 words each
   ```

**Expected Result**: Agent generates three product descriptions matching the InsightfulAffiliate brand voice with proper FTC disclosures

**Validation**:
- [ ] Content uses practical, transparent tone
- [ ] Each description includes pros and cons
- [ ] FTC disclosure is present and clear
- [ ] Word count is appropriate (200-300 words)

## Test Scenario 2: Landing Page Component

**Objective**: Test the Landing Page Builder for creating a hero section

**Steps**:
1. In VS Code, open Copilot Chat
2. Use command: `@landing-page-builder create a hero section for "AI Copywriting Masterclass" course`
3. Specify requirements:
   ```
   Requirements:
   - NextGenCopyAI brand voice (modern, tool-focused)
   - Headline: "Master AI Copywriting in 30 Days"
   - Subheadline about transformation
   - Primary CTA: "Enroll Now" button
   - Mobile-responsive
   - Paste-ready for Systeme.io
   ```

**Expected Result**: Complete HTML/CSS hero section with inline styles, mobile-responsive, and ready to paste into Systeme.io

**Validation**:
- [ ] Self-contained component (inline styles)
- [ ] Responsive design (mobile-first)
- [ ] Clear CTA button
- [ ] NextGenCopyAI brand voice in copy
- [ ] Includes usage instructions

## Test Scenario 3: Affiliate Compliance Audit

**Objective**: Test the Affiliate Link Manager for compliance checking

**Steps**:
1. Create test content file with affiliate links but missing disclosure
2. Use agent: `@affiliate-link-manager audit this content for FTC compliance`
3. Review audit results

**Expected Result**: Agent identifies missing disclosure and provides recommendations

**Validation**:
- [ ] Detects missing FTC disclosure
- [ ] Recommends disclosure placement
- [ ] Provides disclosure template
- [ ] Checks link functionality
- [ ] Verifies ethical practices

## Test Scenario 4: Documentation Creation

**Objective**: Test the Documentation Expert for creating README content

**Steps**:
1. Use agent: `@documentation-expert create a README for the scripts/agent_codex.py file`
2. Specify requirements:
   ```
   Requirements:
   - Include usage examples
   - Document all command-line arguments
   - Add troubleshooting section
   - Follow repository documentation style
   ```

**Expected Result**: Comprehensive README with clear sections, examples, and troubleshooting

**Validation**:
- [ ] Clear overview and purpose
- [ ] Complete usage examples
- [ ] All CLI arguments documented
- [ ] Troubleshooting section included
- [ ] Follows repository style

## Test Scenario 5: Strategic Planning

**Objective**: Test Plan Mode for architecture analysis

**Steps**:
1. Use agent: `@plan-mode analyze the content generation workflow and suggest optimizations`
2. Provide context about current workflow using agent_codex.py

**Expected Result**: Detailed analysis with optimization suggestions and implementation plan

**Validation**:
- [ ] Understands current architecture
- [ ] Identifies optimization opportunities
- [ ] Provides actionable recommendations
- [ ] Considers constraints and dependencies
- [ ] Suggests implementation steps

## Test Scenario 6: Content Generation Workflow Skill

**Objective**: Test the Content Generation Workflow skill end-to-end

**Steps**:
1. Create a simple prompt template in `prompts/test_prompt.txt`
2. Create test input files in a temp directory
3. Run workflow using echo provider:
   ```bash
   ./scripts/agent_codex.py \
     --prompt ./prompts/test_prompt.txt \
     --input ./test_input \
     --output ./docs/ai_outputs/test \
     --provider echo \
     --dry-run \
     --verbose
   ```

**Expected Result**: Workflow executes successfully with detailed output showing file processing

**Validation**:
- [ ] Script runs without errors
- [ ] Files are discovered correctly
- [ ] Output paths are correct
- [ ] Dry-run prevents actual changes
- [ ] Verbose output is informative

## Test Scenario 7: Affiliate Compliance Skill

**Objective**: Test the Affiliate Compliance Check skill scripts

**Steps**:
1. Create test content with affiliate links
2. Run compliance check commands:
   ```bash
   grep -r -l "affiliate" copywriting/ --include="*.md"
   
   for file in $(grep -r -l "affiliate" copywriting/ --include="*.md"); do
     if ! grep -q "disclosure" "$file"; then
       echo "Missing disclosure: $file"
     fi
   done
   ```

**Expected Result**: Script identifies files with affiliate links and checks for disclosures

**Validation**:
- [ ] Finds all files with affiliate links
- [ ] Correctly identifies missing disclosures
- [ ] Reports results clearly
- [ ] No false positives/negatives

## Integration Test: Complete Workflow

**Objective**: Test complete workflow from content creation to compliance check

**Steps**:
1. Use Content Generator to create marketing copy with affiliate links
2. Use Affiliate Link Manager to add links to mapping file
3. Use Landing Page Builder to create component using the copy
4. Use Affiliate Compliance Check to audit final content
5. Use Documentation Expert to document the process

**Expected Result**: Complete, compliant, documented content ready for publication

**Validation**:
- [ ] All agents work together seamlessly
- [ ] Output is cohesive and on-brand
- [ ] Compliance is verified
- [ ] Process is documented
- [ ] Ready for publication

## Reporting Test Results

After running tests, document results:

1. **Test Date**: [Date]
2. **Tests Run**: [Number]
3. **Tests Passed**: [Number]
4. **Issues Found**: [List]
5. **Recommendations**: [List]

## Continuous Testing

Schedule regular testing:
- **Weekly**: Quick validation of all agents
- **Monthly**: Complete integration testing
- **After Updates**: Test modified agents/skills
- **Before Releases**: Full regression testing

## Support

For test failures or issues:
1. Check agent configuration files
2. Review error messages
3. Verify prerequisites
4. Test with simplified inputs
5. Open issue with details

---

**Note**: These tests validate the Copilot configuration. Actual agent behavior may vary based on GitHub Copilot updates and model improvements.
