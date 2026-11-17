---
name: angular-signals-architecture
description: Modern Angular 17/18/19+ component design system, Signals state management, OnPush change detection, Control Flow, and WCAG accessibility standards.
---

# Modern Angular Architecture & Component Engineering

## 1. Modern Angular Paradigms (v17+)
- **Standalone Components**: Always specify `standalone: true`, avoiding legacy `NgModule` declarations.
- **Control Flow**:
  - Use `@if (condition) { ... } @else { ... }` instead of `*ngIf`
  - Use `@for (item of items(); track item.id) { ... } @empty { ... }` instead of `*ngFor`
  - Use `@switch (mode()) { @case ('val') { ... } @default { ... } }` instead of `*ngSwitch`
- **Deferrable Views (`@defer`)**:
  - Wrap non-critical or heavy UI (modals, charts, complex widgets) inside `@defer (on viewport) { ... } @placeholder { ... } @loading (minimum 300ms) { ... }`

## 2. Reactivity with Signals
- Use `signal<T>()` for writable states.
- Use `computed(() => ...)` for derived states.
- Use `effect(() => ...)` only for side-effects (e.g. logging, DOM bridge).
- Use `input<T>()`, `input.required<T>()`, and `output<T>()` instead of legacy `@Input()` and `@Output()` decorators.
- Use `model<T>()` for two-way bindings.
- Convert RxJS Observables with `toSignal(obs$, { initialValue: ... })`.

## 3. Component Architecture & Design Patterns
- **Change Detection**: Strict `changeDetection: ChangeDetectionStrategy.OnPush` on every component.
- **Smart vs Dumb Separation**:
  - Container Components handle data loading, signals, and routing.
  - Presentational Components receive signal inputs and emit outputs, free of direct service dependencies.
- **Content Projection**: Use `<ng-content select="[header]">` and `<ng-content select="[body]">` for composable card/modal atoms.
- **Accessibility (WCAG 2.1 AA)**:
  - Contrast ratios >= 4.5:1
  - Proper ARIA attributes (`role`, `aria-expanded`, `aria-live`, `aria-label`)
  - Keyboard navigation (Tab, Esc for dialogs, Enter/Space for buttons)
