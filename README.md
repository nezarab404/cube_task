# cube_task

A new Flutter project.

## Getting Started

- First we want to make sure that we have generated all the necessary code for translation files,
  models files, and service files

### Generate models serialization files using build runner:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Generate Easy localization files:

```bash
dart run easy_localization:generate --source-dir ./assets/i18n/;dart run easy_localization:generate --source-dir ./assets/i18n -f keys -o locale_keys.g.dart
```

---

- **Note: For task purposes only I kept the `.env` file without ignore it from git.**