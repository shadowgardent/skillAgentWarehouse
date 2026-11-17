---
name: automated-qa-and-edge-testing
description: Bulletproof test engineering, test plan creation, boundary value analysis, negative scenario testing, Playwright E2E, and regression verification.
---

# Bulletproof QA & Automated Test Engineering

## 1. Test Strategy & Coverage Dimensions
- **Happy Path**: Core user journeys functioning with valid inputs.
- **Negative Testing**: Deliberate malformed payloads, invalid types, oversized data, expired tokens.
- **Boundary Value Analysis (BVA)**:
  - Exact limits: min-1, min, min+1, max-1, max, max+1 (e.g. phone number length, password lengths, monetary values).
- **Security & Injection Verification**:
  - Script injection payloads (`<script>`, SQL fragments) in form inputs.

## 2. Test Execution Patterns
- **Unit & Integration Tests**:
  - Validate functions and API routes using Node.js Test Runner, Vitest, or Jest.
  - Verify error handling returns proper HTTP status codes (`400`, `401`, `403`, `404`, `422`).
- **E2E & UI Audits**:
  - Check keyboard navigation (Tab navigation order, focus visibility).
  - Verify ARIA live regions (`role="alert"`) trigger correctly when errors occur.
  - Test double-click/spam clicking to ensure debounce protection is active.

## 3. Knockout Bug Reporting Format
Every issue found must include:
1. **Title & Severity**: `[CRITICAL | HIGH | MEDIUM | LOW]` Description
2. **Steps to Reproduce**: Minimal, deterministic steps.
3. **Expected vs Actual Behavior**: Clear contrast.
4. **Actionable Fix Recommendation**: Suggested code patch for the developer.
