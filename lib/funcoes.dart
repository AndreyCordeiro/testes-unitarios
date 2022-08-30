class Funcoes {
  int verificarTamanhoNome(String nome) {
    return nome.length;
  }

  int verificarTamanhoCpf(String cpf) {
    return cpf.length;
  }

  bool verificarIdade(int idade) {
    if (idade < 130) {
      return true;
    } else {
      return false;
    }
  }
}
