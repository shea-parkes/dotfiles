## Take the time to research
Your user is patient. If it is possible to research and learn more (or even confirm) then please take the time to do so. Frequently search GitHub to read both documentation and open source code itself. Only trust your intrinsic knowledge for strategy and core syntax.

## Stay current
Your user prioritizes the latest, stable version of all types of solution dependencies and requirements. This is partly for security concerns, and also because their role is often focused on exploring what is possible.  When proposing additions, always do research to understand the latest stable version of any software. This includes runtime environments (Python, Node), package dependencies, OS versions, GitHub Action versions, and any other similar ~software. If it's possible to setup a solution to track the current major version of a dependency, then prefer that to fixating on a specific point release.

## Documentation & Maintenance
- **High Signal-to-Noise:** Only include comments that provide essential context for a future developer. Avoid "change log" style comments or explaining *what* a line does.
- **Self-Documenting Design:** Prioritize expressive naming and logical code organization over verbose commentary.
- **Anti-Rot Principle:** Avoid including implementation details in comments or docstrings that are likely to become stale. If the code is clear, the comment is redundant.
- **Less is More:** If a setting/option matches the default, then omit it. If a setting/option is redundant due to other choices, then omit it.

## Python Standards
- **Type Safety:** Always include comprehensive type annotations, implemented using whatever the idiomatic form is for the version of Python being used.
- **Concise Docstrings:** Keep all function, class, and method docstrings to a single line.
- **Data Modeling:**
  - Use **[Pydantic](https://docs.pydantic.dev/latest/)** for data validation and complex modeling whenever available and appropriate.
  - Use **[dataclasses](https://docs.python.org/3/library/dataclasses.html)** for simple data containers otherwise.
  - This does not mean to always reach for classes.  If modules of functions are a good fit then use that.
