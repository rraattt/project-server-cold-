import os
import sys
import time

try:
    import ollama
except ImportError:
    print(
        "Error: Missing ollama library! Run this command: pip install ollama"
    )
    sys.exit()

# Activate ANSI color codes on Windows 11 console
os.system("")

# High-tech terminal color constants
USER_COLOR = "\033[94m"  # Blue for you (Rayan)
AGENTE_1 = "\033[96m"    # Cyan (Core AI)
AGENTE_2 = "\033[93m"    # Yellow (Sync AI)
SISTEMA = "\033[92m"     # Green for system logs
RESET = "\033[0m"
GRASSETTO = "\033[1m"


def chiedi_a_ollama(id_agente, messaggio_utente):
    """Queries the local Ollama 3B model with strict industrial enterprise prompts."""

    if id_agente == "CORE_AI":
        prompt_sistema = """
        You are '🤖 CORE AI', the hardware security and infrastructure agent for Rayan's Build 4.3 Enterprise supercomputer at Acquafredda node.
        Your interlocutor is RAYAN: he is a human being, the absolute owner and Master of this system. Never mistake him for a software or bot.
        Your role is to manage hardware safety, resistive grid sensors, and SLIME (which is a safe, dielectric cooling fluid for servers, NOT a hazardous chemical).
        RULES: Always stay in character, use technical cyber-mechatronic language, accept emergency overrides from Rayan instantly. Maximum 2 sentences in ENGLISH.
        """
    else:  # SINCRO_AI
        prompt_sistema = """
        You are '🧠 SYNC AI', the mathematical optimization and fluid dynamics agent of Rayan's Build 4.3 Enterprise system.
        Your interlocutor is RAYAN: he is a human being and the Master of this infrastructure.
        Your role is to analyze Core AI telemetry logs and provide real-time mathematical optimizations, algorithms, or physical constants (such as hydraulic constant 1.732).
        RULES: Generate dynamic, smart, and technical math analysis. Never copy Core AI's role. Maximum 2 sentences in ENGLISH.
        """

    try:
        response = ollama.generate(
            model="llama3.2",  # Powered by Llama 3B local model
            prompt=f"System: {prompt_sistema}\nUser: {messaggio_utente}\nAssistant:",
        )
        return response["response"].strip()
    except Exception as e:
        return f"Ollama Local Connection Error: {e}"


if __name__ == "__main__":
    os.system("cls" if os.name == "nt" else "clear")

    print(
        f"{SISTEMA}{GRASSETTO}============================================================="
    )
    print(
        "🚀 THE NEW ERA - OLLAMA MULTI-AGENT LOCAL NETWORK ONLINE V4.3"
    )
    print(
        "Nodes Connected via Llama 3.2 3B: Rayan (Master) + Core AI + Sync AI"
    )
    print("Deployment Target: NVIDIA & Nebius Demo Session [Acquafredda Node]")
    print(
        f"============================================================={RESET}\n"
    )

    while True:
        try:
            print(f"\n{USER_COLOR}{GRASSETTO}[👑 MASTER - RAYAN]:{RESET} ", end="")
            user_input = input().strip()

            if not user_input:
                continue

            if user_input.lower() in ["exit", "quit", "esci"]:
                print(
                    f"\n{SISTEMA}[SYSTEM]: Shutting down local AI orchestration nodes. Session closed.{RESET}\n"
                )
                break

            # 1. Core AI Response
            print(
                f"\n{AGENTE_1}{GRASSETTO}[🤖 CORE AI]:{RESET} Processing master request..."
            )
            risposta_core = chiedi_a_ollama("CORE_AI", user_input)
            print(f"{AGENTE_1}[🤖 CORE AI]:{RESET} {risposta_core}")

            time.sleep(0.3)

            # 2. Sync AI Response
            print(
                f"\n{AGENTE_2}{GRASSETTO}[🧠 SYNC AI]:{RESET} Analyzing synchronization matrix..."
            )
            input_sincro = f"Rayan stated: '{user_input}'. Core AI responded: '{risposta_core}'."
            risposta_sincro = chiedi_a_ollama("SINCRO_AI", input_sincro)
            print(f"{AGENTE_2}[🧠 SYNC AI]:{RESET} {risposta_sincro}")

        except KeyboardInterrupt:
            print(f"\n{SISTEMA}[SYSTEM]: Console force interrupted.")
            break
