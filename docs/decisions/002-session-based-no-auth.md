# ADR 002: Session-Based (No Auth)

**Date**: 2025-11 (initial design)
**Status**: Accepted

## Context

The app is a local-first personal learning tool. Authentication (JWT, OAuth, passwords) adds significant complexity: registration flow, token refresh, password reset, secure storage, CSRF protection.

## Decision

No user accounts. Session identified by a UUID generated client-side (`crypto.randomUUID()`) and stored in `localStorage`. Sent as `X-Session-Id` header on every request.

## Reasons

1. **Zero friction** — no signup, no login. First-time users immediately start learning.
2. **Scope** — personal tool, single user, local network. Auth complexity has negative ROI.
3. **Privacy** — no PII stored. Session ID is a random UUID, not linked to any identity.
4. **Simplicity** — all server code is stateless. No token refresh, no session expiry, no middleware.

## Consequences

- `+` No registration flow to build or maintain
- `+` No sensitive data (no passwords, emails, tokens)
- `+` Progress is naturally isolated per browser/device
- `-` Progress is lost if localStorage is cleared
- `-` Cannot sync progress across devices (mitigation: session export/import via `GET/POST /api/progress/session/export|import`)
- `-` No multi-user support (would require full auth redesign)

## What Would Change This Decision

If the app ever becomes multi-user or hosted publicly, this decision reverses. At that point, JWT + refresh tokens or a managed auth service (Auth0, Clerk) is the right path.
