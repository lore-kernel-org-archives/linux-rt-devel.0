Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793956786;
	b=Ywcb1+3QlIRzAuaBzx6YggAu3RXrU+kfE1TYGt/b8wNjY9c1fYsmoUloQ/9wxe/xAgBl
	 jpCqAFP0sZNQBAJ3TBz//qv/7rTHeynbfFCZZ9M/IjQo08Zfj5ylVScqCjcX6y6CYesXj
	 HEurlfsfY2bZakOAOxcLVsGZOWoS3JJ38GN0fA1trTDqK/+Qz2kEx62Go3IibHVIv1ufm
	 fwz0ePS9jOxs312e0GoFGk4QakcUY+WNmQ2S0mhisowWYi4zF5rHpcgXUEc07HKwiJTSP
	 002kK6MzMjpWrXvQ7UtafCOgmx2yk7YgSSK37n+I2Okt8hChtooLt8ATZNI1m+VaKgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956786;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0X7uhXFmtfFZdleKpIxRqSx/g9j+1ioWtVw98FdmCRc=;
	b=tkZJ5a4gFSlIlxUFYt0MPp1bXVoDuO9WlsErePwbpNfrObHmNyiTD5cFYQG6aCoRWdec
	 uuA4C5am9VWFyJuzKGJI3DM3yrWAqbpFjm90v9Ll/jJQlnMHGj9thYpsQPKvsQ75pdx8r
	 b5VKaH0XYpLFgo3AdkRaPTR1JR6htpfDfFt0DiDeHxSx3KxLhYtX2biYA/LVAk25FdMbZ
	 hqsGnWiQKBcp1yOG4cYICEn9lfwqXk11h/R802Be75yY+PUjaS5SoQrcPdw/yROupjVaE
	 1xHsLVc9Y+aJSn+eOG9HD53qdKEAJfN/EPNuN3M1YfUJX0VJvTjfeOQ2Cl/RzK2duWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=YCUYv6Bq;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=e+1NQCiB;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED73606A329
	for <linux-rt-devel@lists.linux.dev>; Fri,  6 Nov 2026 09:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8ED73606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=YCUYv6Bq;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=e+1NQCiB
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793956784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0X7uhXFmtfFZdleKpIxRqSx/g9j+1ioWtVw98FdmCRc=;
	b=YCUYv6BqIjBRFDe/l3WKU3TiIa0Usk9sesvkiacGVGWkS47G+Wfw8Bb4spjDlTQP1CWhMY
	z9zXcBGs6qNi1I9Kcc9euJoX6lTQvjIx0WqZAhCWByzPrYe2YAAwAtWDkwmpMoHM/ueFtX
	x8Bpoy6B8xkfkBRPzQu13shWvU8rGDcYhJ6wApn8PTy4LKlC8WVavwsXeFSA6up1iQmQSi
	x/4E+FjDX1X7PMvI62gRc82HhQPWMTWmplTOxM8jJiZwpD4Uu/d+n67X8/X+bXCXJUTzc+
	nqihDRjg08oTnocNAXnxW3yG2WtCYUFvlNojJJRD9x6Bk+ruSIqWlAuAKA88zQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793956784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0X7uhXFmtfFZdleKpIxRqSx/g9j+1ioWtVw98FdmCRc=;
	b=e+1NQCiBcMPN+wl6WvRhhIuMRLbhN5tXwncXr9vrcfAbxX/QwFgqCi2P9yGT7VGy2VAvsV
	Haohn/ld9XqmHjDg==
To: Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	John Ogness <john.ogness@linutronix.de>,
	Derek Barbosa <debarbos@redhat.com>,
	=?UTF-8?q?Zbigniew=20J=C4=99drzejewski-Szmek?= <zbyszek@amutable.com>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Luca Boccassi <luca.boccassi@gmail.com>,
	linux-rt-devel@lists.linux.dev,
	debian-kernel@lists.debian.org,
	linux-kbuild@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v1 03/10] kconfig-checker: Add the configuration checker code
Date: Fri,  6 Nov 2026 10:19:15 +0100
Message-ID: <20261106091922.7560-4-darwi@linutronix.de>
In-Reply-To: <20261106091922.7560-1-darwi@linutronix.de>
References: <20261106091922.7560-1-darwi@linutronix.de>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a kernel configuration checker.

Validate the passed kernel .config against a YAML rules file and report
problematic configuration issues by severity.

For correctness, readability, and long-term maintainability, type-annotate
all the Python code and split the tool's logic into a clean set of classes.

Create a proper Python objects data model for the kconfig checker to work
with.  Confine all direct YAML dictionary access to YAML files loading,
validation, and data model construction.

Document the tool's development rules on top.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/kconfig-checker/check.py | 558 +++++++++++++++++++++++++++++++++
 1 file changed, 558 insertions(+)
 create mode 100755 tools/kconfig-checker/check.py

diff --git a/tools/kconfig-checker/check.py b/tools/kconfig-checker/check.py
new file mode 100755
index 000000000000..476cd13e59eb
--- /dev/null
+++ b/tools/kconfig-checker/check.py
@@ -0,0 +1,558 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Kernel .config checker
+#
+# Main usage:
+#
+#     $ check.py list-rules
+#     $ check.py check -c path/to/linux/.config -r preempt_rt
+#
+# Notes:
+#
+# - All code is to be fully type-annotated. Before introducing changes,
+#   please verify type-safety using:
+#
+#     $ mypy --strict --no-warn-return-any check.py
+#
+# - The minimum required Python version must not be newer than what is
+#   required by the kernel build at Documentation/process/changes.rst.
+#
+# - The tool must not depend on being run inside the kernel source tree.
+#   This simplifies invocation, testing and possible future packaging.
+#
+# - The YAML rule files are only treated as a serialization format.  After
+#   loading and schema validation, such rules are parsed into an internal
+#   data model: Severity, Rule, SymbolRule, PatternRule, Rules, and other
+#   related python objects.
+#
+#   All checker logic must operate on that typed model, and not on the raw
+#   YAML dictionaries.
+#
+# - Minimize external dependencies: this tool is also intended to be run
+#   from distribution kernel-package scripts in the future.
+#
+# Script exit codes:
+#
+#   os.EX_CONFIG          passed kernel .config does not match rules
+#   os.EX_NOINPUT         input file(s) could not be opened
+#   os.EX_DATAERR         YAML/schema/rule data is malformed
+#   os.EX_UNAVAILABLE     Python version or dependency is unavailable
+#
+
+from __future__ import annotations
+
+import argparse
+import os
+import re
+import sys
+import textwrap
+
+from dataclasses import dataclass
+from enum import Enum, auto
+from pathlib import Path
+from typing import Any, NoReturn, Optional
+
+#
+# Initial sanity checks:
+#
+
+def error(message: str, code: int) -> NoReturn:
+    print(f'Error: {message}', file=sys.stderr)
+    sys.exit(code)
+
+if sys.version_info < (3, 9):
+    error('Python 3.9 or later is required', os.EX_UNAVAILABLE)
+
+try:
+    import jsonschema               # type: ignore
+    import yaml as yaml_m           # type: ignore
+except ModuleNotFoundError as e:
+    error(f'Missing Python module: {e.name}', os.EX_UNAVAILABLE)
+
+#
+# Actual script:
+#
+
+class KernelConfig:
+    """.config file parser"""
+
+    def __init__(self, file: Path):
+        try:
+            self.lines = file.read_text().splitlines()
+        except OSError as e:
+            error(f'Could not open {file}: {e.strerror}', os.EX_NOINPUT)
+
+        self.symbols = self._parse_symbols()
+
+    def _parse_symbols(self) -> dict[str, str]:
+        """Extract CONFIG_* symbol assignments from .config"""
+        symbol_set = re.compile(r'^(CONFIG_[A-Za-z0-9_]+)=([ym])$')
+        symbol_unset = re.compile(r'^# (CONFIG_[A-Za-z0-9_]+) is not set$')
+
+        symbols: dict[str, str] = {}
+        for line in self.lines:
+            line = line.rstrip('\n')
+
+            if m := symbol_set.match(line):
+                symbols[m.group(1)] = m.group(2)
+                continue
+
+            if m := symbol_unset.match(line):
+                symbols[m.group(1)] = 'n'
+
+        return symbols
+
+    def get_symbol_value(self, sym_name: str) -> Optional[str]:
+        """Return a .config symbol value: 'y', 'm', or 'n'"""
+        return self.symbols.get(sym_name)
+
+    def get_matching_symbols(self, pa: re.Pattern[str]) -> list[str]:
+        """Get all CONFIG_* symbol names matching passed regex"""
+        return [ sym for sym in self.symbols if pa.search(sym) ]
+
+YamlDict = dict[str, Any]
+
+class Helpers:
+    """YAML file access helpers"""
+
+    @staticmethod
+    def load_yaml(yaml_f: Path) -> YamlDict:
+        try:
+            with open(yaml_f, 'r') as f:
+                return yaml_m.safe_load(f)
+        except OSError as e:
+            error(f'Could not open {yaml_f}: {e.strerror}', os.EX_NOINPUT)
+        except yaml_m.YAMLError as e:
+            error(f'Invalid YAML syntax at {yaml_f}:\n {e}', os.EX_DATAERR)
+
+    @staticmethod
+    def validate_yaml(yaml: YamlDict, schema: YamlDict, f_name: str) -> None:
+        try:
+            jsonschema.validate(yaml, schema)
+        except jsonschema.exceptions.ValidationError as e:
+            error(
+                f'{f_name} does not match its schema\n'
+                f'Reason: {e.message}',
+                os.EX_DATAERR
+            )
+
+class Schema:
+    """Rules file schema, in json-schema.org format"""
+
+    def __init__(self, schema_f: Path):
+        self.schema = Helpers.load_yaml(schema_f)
+        # Validate the schema itself against draft-07 metaschema
+        jsonschema.Draft7Validator.check_schema(self.schema)
+
+    def as_dict(self) -> YamlDict:
+        return self.schema
+
+class ExpectedValue(Enum):
+    """Expected values for a .config symbol"""
+
+    y       = auto()  # 'y' implies a built-in or a module; as in schema
+    n       = auto()
+    allowed = auto()
+
+class Severity(Enum):
+    """Rule-check severity"""
+
+    fatal  = auto()
+    high   = auto()
+    medium = auto()
+    low    = auto()
+    info   = auto()
+
+class Rule:
+    """Single rule entry"""
+
+    expected: ExpectedValue
+    severity: Severity
+    rationale: Optional[str] = None
+    docs_hint: Optional[str] = None
+
+    def __init__(self, rule: YamlDict) -> None:
+        self.expected = ExpectedValue[rule['expected']]
+        self.severity = Severity[rule['severity']]
+        self.rationale = rule.get('rationale')
+        self.docs_hint = rule.get('docs_hint')
+        self._normalize_docs_hint()
+
+    def _normalize_docs_hint(self) -> None:
+        """Transform the hint to a URI fragment identifier"""
+        if self.docs_hint:
+            self.docs_hint = '#' + self.docs_hint
+
+class SymbolRule(Rule):
+    """Rule entry for one .config symbol"""
+
+    symbol: str
+
+    def __init__(self, rule: YamlDict):
+        self.symbol = rule['name']
+        super().__init__(rule)
+
+    def _normalize_docs_hint(self) -> None:
+        """Transform the hint to a docs.kernel.org URI fragment identifier"""
+        if self.docs_hint == 'config':
+            self.docs_hint = self.symbol.lower().replace('_', '-')
+
+        super()._normalize_docs_hint()
+
+class PatternRule(Rule):
+    """Rule entry for a regex pattern of .config symbols"""
+
+    symbol_regex: re.Pattern[str]
+
+    def __init__(self, rule: YamlDict):
+        regex = rule['name_pattern']
+        try:
+            self.symbol_regex = re.compile(regex)
+        except re.error as e:
+            error(f'Invalid symbol regex {regex}: {e}', os.EX_DATAERR)
+
+        super().__init__(rule)
+
+@dataclass
+class Rules:
+    """The .config checker rules repository / data model"""
+
+    rules: list[Rule]
+    docs_url: Optional[str] = None
+
+    def add_rule(self, rule: Rule) -> None:
+        """Add given rule to the existing rules repository"""
+        if isinstance(rule, SymbolRule):
+            symbol = rule.symbol
+            if self.get_symbol_rule(symbol):
+                error(f'Duplicate rule name: {symbol}', os.EX_DATAERR)
+
+        if isinstance(rule, PatternRule):
+            pattern = rule.symbol_regex.pattern
+            if self.get_pattern_rule(pattern):
+                error(f'Duplicate rule pattern: {pattern}', os.EX_DATAERR)
+
+        self.rules.append(rule)
+
+    def get_docs_url_for(self, rule: Rule) -> Optional[str]:
+        """Return full documentation URL for a rule, if available"""
+        if not self.docs_url or not rule.docs_hint:
+            return None
+
+        return f'{self.docs_url}{rule.docs_hint}'
+
+    def get_symbol_rule(self, kconfig_symbol: str) -> Optional[SymbolRule]:
+        """Return symbol rule matching passed .config symbol, if any"""
+        for rule in self.rules:
+            if isinstance(rule, SymbolRule):
+                if rule.symbol == kconfig_symbol:
+                    return rule
+
+        return None
+
+    def get_pattern_rule(self, pattern: str) -> Optional[PatternRule]:
+        """Return pattern rule matching passed .config symbol, if any"""
+        for rule in self.rules:
+            if isinstance(rule, PatternRule):
+                if rule.symbol_regex.pattern == pattern:
+                    return rule
+
+        return None
+
+class RulesFile:
+    """YAML rules file access"""
+
+    yaml: YamlDict
+
+    def __init__(self, yaml_f: Path, schema: Schema):
+        self.yaml = Helpers.load_yaml(yaml_f)
+        Helpers.validate_yaml(self.yaml, schema.as_dict(), yaml_f.name)
+
+    def parse(self) -> Rules:
+        """Parse the YAML rules into a python Rules object"""
+        rules = Rules([])
+
+        for rule in self.yaml.get('rules', []):
+            if 'name' in rule:
+                rules.add_rule(SymbolRule(rule))
+                continue
+
+            if 'name_pattern' in rule:
+                rules.add_rule(PatternRule(rule))
+                continue
+
+        rules.docs_url = self.yaml.get('docs_url')
+        return rules
+
+@dataclass
+class Issue:
+    message: str
+    docs_url: Optional[str]
+    severity: Severity
+    rationale: Optional[str]
+
+@dataclass
+class SymbolIssue(Issue):
+    """Checker issue concerning a single .config symbol"""
+    symbol: str
+
+@dataclass
+class PatternIssue(Issue):
+    """Checker issue concerning a regex pattern of .config symbols"""
+    symbols: list[str]
+
+class Issues:
+    """Repository of all issues found by the checker"""
+
+    def __init__(self, issues_l: list[Issue]):
+        # Index all issues by severity
+        self.issues: dict[Severity, list[Issue]] = {
+            severity: [] for severity in Severity
+        }
+        for issue in issues_l:
+            self.issues[issue.severity].append(issue)
+
+    def by_severity(self, severity: Severity) -> list[Issue]:
+        return self.issues[severity]
+
+@dataclass
+class Report:
+    """kconfig checker sanity report. Main script output"""
+
+    issues: Issues
+
+    def _print_header(self, header: str) -> None:
+        print(header)
+        print('=' * len(header))
+        print()
+
+    def _print_symbol(self, issue: SymbolIssue) -> None:
+        print(f'* {issue.symbol} is {issue.message}')
+        print()
+
+    def _print_pattern(self, issue: PatternIssue) -> None:
+        print(f'* Below options are {issue.message}:\n')
+        for symbol in issue.symbols:
+            print(f'  {symbol}')
+        print()
+
+    def _print_issue(self, issue: Issue) -> None:
+        if isinstance(issue, SymbolIssue):
+            self._print_symbol(issue)
+        elif isinstance(issue, PatternIssue):
+            self._print_pattern(issue)
+
+    def _print_rationale(self, issue: Issue) -> None:
+        if not issue.docs_url and not issue.rationale:
+            return
+
+        print('  Rationale:')
+
+        if issue.docs_url:
+            print(' ', issue.docs_url)
+            if issue.rationale:
+                print()
+
+        if issue.rationale:
+            print(textwrap.fill(
+                issue.rationale,
+                width=75,
+                initial_indent='  ',
+                subsequent_indent='  ',
+            ))
+
+        print()
+
+    def print(self) -> None:
+        """Print the checker's .config report, in order of severity"""
+        print()
+        for severity in Severity:
+            issues = self.issues.by_severity(severity)
+            if not issues:
+                continue
+
+            self._print_header('Configuration Issues with severity = ' +
+                               severity.name.upper())
+
+            for issue in issues:
+                self._print_issue(issue)
+                self._print_rationale(issue)
+
+@dataclass
+class Checker:
+    """The actual kconfig checker machinery"""
+
+    kconfig: KernelConfig
+    rules: Rules
+
+    def _find_issue_symbol(self, rule: SymbolRule) -> Optional[SymbolIssue]:
+        """Check the .config against passed rule. Return found issues, if any"""
+        value = self.kconfig.get_symbol_value(rule.symbol)
+        docs_url = self.rules.get_docs_url_for(rule)
+
+        if rule.expected == ExpectedValue.y:
+            if value is None:
+                return SymbolIssue(
+                    'not in .config',
+                    docs_url,
+                    rule.severity,
+                    rule.rationale,
+                    rule.symbol,
+                )
+            if value == 'n':
+                return SymbolIssue(
+                    'unset',
+                    docs_url,
+                    rule.severity,
+                    rule.rationale,
+                    rule.symbol,
+                )
+
+        if rule.expected == ExpectedValue.n:
+            if value in ('y', 'm'):
+                return SymbolIssue(
+                    'set',
+                    docs_url,
+                    rule.severity,
+                    rule.rationale,
+                    rule.symbol,
+                )
+
+        return None
+
+    def _find_issue_pattern(self, pattern_rule: PatternRule) -> Optional[PatternIssue]:
+        """Check the .config against a pattern rule. Return found issues, if any."""
+        if pattern_rule.expected == ExpectedValue.allowed:
+            return None
+
+        violation_type = 'unset' if pattern_rule.expected == ExpectedValue.y else 'set'
+        docs_url = self.rules.get_docs_url_for(pattern_rule)
+
+        violating_symbols = []
+
+        for symbol in self.kconfig.get_matching_symbols(pattern_rule.symbol_regex):
+            symbol_value = self.kconfig.get_symbol_value(symbol)
+
+            if pattern_rule.expected == ExpectedValue.y and symbol_value == 'n':
+                # Exclude the config symbol if it's explicitly disabled elsewhere
+                symbol_rule = self.rules.get_symbol_rule(symbol)
+                if symbol_rule and symbol_rule.expected == ExpectedValue.n:
+                    continue
+
+                violating_symbols.append(symbol)
+
+            if pattern_rule.expected == ExpectedValue.n and symbol_value in ('y', 'm'):
+                # Exclude the config symbol if it's explicitly allowed elsewhere
+                symbol_rule = self.rules.get_symbol_rule(symbol)
+                if symbol_rule and symbol_rule.expected in (ExpectedValue.y, ExpectedValue.allowed):
+                    continue
+
+                violating_symbols.append(symbol)
+
+        if not violating_symbols:
+            return None
+
+        return PatternIssue(
+            violation_type,
+            docs_url,
+            pattern_rule.severity,
+            pattern_rule.rationale,
+            violating_symbols,
+        )
+
+    def _find_issue(self, rule: Rule) -> Optional[Issue]:
+        """Check the .config against passed rule. Return found issues, if any"""
+        if isinstance(rule, SymbolRule):
+            return self._find_issue_symbol(rule)
+
+        if isinstance(rule, PatternRule):
+            return self._find_issue_pattern(rule)
+
+        return None
+
+    def find_issues(self) -> Optional[Report]:
+        """Check the .config file against required rules"""
+        issues: list[Issue] = []
+        for rule in self.rules.rules:
+            if issue := self._find_issue(rule):
+                issues.append(issue)
+
+        if issues:
+            return Report(Issues(issues))
+
+        return None
+
+def parse_args(rules: list[str]) -> argparse.Namespace:
+    parser = argparse.ArgumentParser(
+        prog='check.py',
+        description='Kernel .config options checker',
+    )
+
+    subparsers = parser.add_subparsers(
+        dest='command',
+        required=True,
+    )
+
+    subparsers.add_parser(
+        'list-rules',
+        help='return available .config rule checking profiles',
+    )
+
+    check_parser = subparsers.add_parser(
+        'check',
+        help='check a .config file against a rule profile',
+    )
+
+    check_parser.add_argument(
+        '-c',
+        '--config',
+        metavar='KCONFIG_FILE',
+        type=Path,
+        required=True,
+        help='.config file to be checked',
+    )
+
+    check_parser.add_argument(
+        '-r',
+        '--rules',
+        metavar='RULES',
+        choices=rules,
+        required=True,
+        help='rules file to check against',
+    )
+
+    return parser.parse_args()
+
+def main() -> None:
+    base_dir = Path(__file__).resolve().parent
+    rules_dir = base_dir / 'rules'
+
+    rules_l = sorted(path.stem for path in rules_dir.glob('*.yml'))
+    args = parse_args(rules_l)
+
+    if args.command == 'list-rules':
+        print(*rules_l, sep=', ')
+        return
+
+    kconfig_f = args.config.resolve()
+    kconfig = KernelConfig(kconfig_f)
+
+    schema_f = base_dir / 'schema.yml'
+    schema = Schema(schema_f)
+
+    rules_f = rules_dir / f'{args.rules}.yml'
+    rules = RulesFile(rules_f, schema).parse()
+
+    checker = Checker(kconfig, rules)
+    report = checker.find_issues()
+
+    if report:
+        report.print()
+        error(f'{kconfig_f} does not match required rules', os.EX_CONFIG)
+
+    print(f'Success: {kconfig_f} matches required rules')
+
+if __name__ == '__main__':
+    main()
-- 
2.56.0

