# GitHub Copilot Agents

This directory contains custom GitHub Copilot agents that provide specialized assistance for this repository.

## Available Agents

### SSH Key Manager (`ssh-key-manager.yml`)

**Purpose**: Specialized agent for SSH key security, credential management, and preventing accidental key exposure.

**Use this agent when:**
- Setting up SSH keys for the first time
- You've accidentally exposed a private key
- You need to rotate SSH keys
- You want to audit your SSH security setup
- You need guidance on secure key storage
- You're troubleshooting SSH authentication issues

**Example prompts:**
```
"@ssh-key-manager help me set up SSH keys securely"
"@ssh-key-manager I accidentally committed a private key, what should I do?"
"@ssh-key-manager audit my SSH security setup"
"@ssh-key-manager explain proper file permissions for SSH keys"
```

**What it does:**
- Scans for accidentally committed SSH keys
- Provides emergency response guidance for exposed keys
- Helps implement secure key storage practices
- Guides through key rotation procedures
- Explains SSH agent configuration
- Implements .gitignore patterns for secrets
- Creates security documentation

**Documentation:**
- Full Guide: [docs/SSH_KEY_SECURITY.md](../../docs/SSH_KEY_SECURITY.md)
- Quick Reference: [docs/SSH_KEY_SECURITY_QUICKREF.md](../../docs/SSH_KEY_SECURITY_QUICKREF.md)
- Security Checklist: [docs/checklists/SECURITY_CHECKLIST.md](../../docs/checklists/SECURITY_CHECKLIST.md)

### Other Agents

- **affiliate-link-manager.yml**: Manages affiliate links and tracking
- **content-generator.yml**: Generates marketing content
- **documentation-expert.yml**: Creates and maintains documentation
- **landing-page-builder.yml**: Builds landing pages
- **plan-mode.yml**: Project planning and task breakdown

## How to Use Agents

In GitHub Copilot, reference an agent by name:

```
@agent-name your question or request here
```

For example:
```
@ssh-key-manager I need help securing my SSH keys
```

## Security Note

The SSH Key Manager agent has been specifically created to help prevent security incidents involving accidentally committed SSH keys. We strongly recommend:

1. **Reading the documentation** before working with SSH keys
2. **Running security checks** regularly: `./scripts/security-check.sh`
3. **Using pre-commit hooks** to catch issues early: `pre-commit install`
4. **Consulting the agent** when uncertain about security practices

## Contributing New Agents

When creating new agents:

1. Use YAML format with proper frontmatter
2. Include clear `name` and `description` fields
3. Provide detailed `instructions` for the agent's behavior
4. Document example use cases and prompts
5. Add the agent to this README

## Resources

- [GitHub Copilot Documentation](https://docs.github.com/en/copilot)
- [Custom Agent Guidelines](https://docs.github.com/en/copilot/customizing-copilot/creating-a-custom-copilot-agent)
- [Repository Security Policy](../../SECURITY.md)

---

**Last Updated**: 2025-12-30
