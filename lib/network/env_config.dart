enum Env { dev, prod }

class EnvConfig {
  static const Env currentEnv = Env.dev;

  static String get baseUrl {
    switch (currentEnv) {
      case Env.dev:
        return 'https://dev.api.example.com/';
      case Env.prod:
        return 'https://api.example.com/';
    }
  }
}
