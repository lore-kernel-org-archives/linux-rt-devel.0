Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793956808;
	b=0S4yo1mMi5grp2O/y23Y1lPg7Zp5zyPy+OZ9SQbX7W3dsVpcCXtmqZV6x+EtgEMW8YMw
	 UNagst2o+4r/XCIFEFP0qKbhmSsLwdJiiSiV4mkH6cSa3TVqd03YgTg+rhqEhSN/Ta+/Z
	 5kWIWmw3+5Egvh6cFEFvyyzs6UxYVXojkkeb1Pu3srL6Rgy0IKaIREcqYxt3F+Y8Nuara
	 ldY3fs+idQ+Cojv3UuTp5mSYjsXpRYf/5QzVNLsIHDa3TIhSzYDslB3Cq62h6Z5YujR+t
	 tNR+cgyeBqMMzbAZEHdpdcZwQ2obrQkS+vGKLoLeA7SC3PTfHbjL8nsuoYKNK22RP0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956808;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cieHxXYoFdvsDAnH4UZMQYIUTVvb5arMKcEfb2knAhY=;
	b=j2a6G6h075XDKSPwFgnFT2DYn/vjaNu8nKgGgEuwlUzDt7vUS/4E9xS+YDpfPbqoDcp7
	 Q7HidzWx2pXklvCa+4mn4zbNh7B2+Dx3Ax/batV3fQ0lNkmoIyEqeTAtaDmOdec5u9UEl
	 MHE6FAVY4HD5PSEimouj9xg0DE2hwx3H7oL2tLWlan9eNLIYOPlGVXs7ZH6yVwEfUNVKX
	 Ne/LxwvfoRqo0duCrECi+sXzuKxObqpLsdMqTywT5xlVD1t3TAgSDwpuEisnX14lIwAip
	 d8LwptO+EutkNw9yeykg+9SC/K12QyyIeXqXf+ayXYJv3W6otxrTDC1Kxz9eNJr9sbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=fKLMx54w;
	dkim=temperror header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="qwHET7/t";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B06606A33F
	for <linux-rt-devel@lists.linux.dev>; Fri,  6 Nov 2026 09:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04B06606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=fKLMx54w;
	dkim=temperror header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=qwHET7/t
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793956800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cieHxXYoFdvsDAnH4UZMQYIUTVvb5arMKcEfb2knAhY=;
	b=fKLMx54whJvpxEHRcjpGttIXBvx/EvgJqj38ppJB4rSa6YMkur7iVThvZSy4sppNnZYcfd
	JiM3HC6JBQUwF/QmMs+5lpyQJf76ptF7b7ImDb+lQdAKnjzflX21d9SzfoUVXQbYaXaeV8
	KrO5TjIgry4nsmTYdK69vuSh9Hb7flBSWHM/O+I150EwuWOm12ZehEV89UIRTX7iq4Qix1
	q+UFO0ctsO0bqpG0FvjOfefl3hVuWfBAFojydfnt5pIRSUdu1MlD8lQNvKs06gw0rZdAKS
	ElywcB+PRT9EL+Ed3HWJNY5oGefB5rewF8jBPVB2FjeR3AvQM2fa0OEy7pFM+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793956800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cieHxXYoFdvsDAnH4UZMQYIUTVvb5arMKcEfb2knAhY=;
	b=qwHET7/tjAbHU1i/ljh7YgwRvwlfdnJYgcbzZ/0mJeJDKyWQ4tClFhh8qGUC3QO0LrzRyM
	oRX6y5kc+XbE7LAA==
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
Subject: [PATCH v1 08/10] kconfig-checker: Add support for rule overlays
Date: Fri,  6 Nov 2026 10:19:20 +0100
Message-ID: <20261106091922.7560-9-darwi@linutronix.de>
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

An kconfig-checker overlay is a YAML file applied on top of an existing
rules file.

Overlays are intended for distribution kernel packaging scripts, CI
environments, and board support packages; where the base rules may need
local adjustments.  Overlays may override any rule's field.  They may
also update the documentation URL or introduce totally new rules.

Add support for such an overlay mechanism at the kconfig checker.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/kconfig-checker/check.py | 89 +++++++++++++++++++++++++++++++++-
 1 file changed, 88 insertions(+), 1 deletion(-)

diff --git a/tools/kconfig-checker/check.py b/tools/kconfig-checker/check.py
index 4f79ec487da7..38ae4ed32817 100755
--- a/tools/kconfig-checker/check.py
+++ b/tools/kconfig-checker/check.py
@@ -7,7 +7,7 @@
 # Main usage:
 #
 #     $ check.py list-rules
-#     $ check.py check -c path/to/linux/.config -r preempt_rt
+#     $ check.py check -c path/to/linux/.config -r preempt_rt [-o path/to/overlay.yml]
 #
 # Notes:
 #
@@ -225,6 +225,48 @@ class Rule:
         if self.docs_hint:
             self.docs_hint = '#' + self.docs_hint
 
+    def overlay(self, overlay: YamlDict) -> None:
+        """Overlay passed yaml structure over existing data"""
+        if 'expected' in overlay:
+            self.expected = ExpectedValue[overlay['expected']]
+
+        if 'severity' in overlay:
+            self.severity = Severity[overlay['severity']]
+
+        if 'rationale' in overlay:
+            self.rationale = overlay['rationale']
+
+        if 'docs_hint' in overlay:
+            self.docs_hint = overlay['docs_hint']
+            self._normalize_docs_hint()
+
+    @staticmethod
+    def _ensure_required_fields(rule: YamlDict, rule_id: str) -> None:
+        """Ensure that passed rule has all required fields"""
+
+        # Normal rule files require every rule to define both 'expected'
+        # and 'severity'.
+        #
+        # Overlay files are different: an overlay may update only selected
+        # fields of an existing rule, so the overlay schema permits these
+        # fields to be omitted.
+        #
+        # However, an overlay may also introduce a completely new rule,
+        # where such a rule has no existing base rule to inherit from.
+        # Manually check all required fields existence in that case.
+
+        if 'expected' not in rule:
+            error(
+                f'Required field `expected` is missing from {rule_id}',
+                os.EX_DATAERR
+            )
+
+        if 'severity' not in rule:
+            error(
+                f'Required field `severity` is missing from {rule_id}',
+                os.EX_DATAERR
+            )
+
 class SymbolRule(Rule):
     """Rule entry for one .config symbol"""
 
@@ -232,6 +274,8 @@ class SymbolRule(Rule):
 
     def __init__(self, rule: YamlDict):
         self.symbol = rule['name']
+
+        super()._ensure_required_fields(rule, f'symbol {self.symbol}')
         super().__init__(rule)
 
     def _normalize_docs_hint(self) -> None:
@@ -253,6 +297,7 @@ class PatternRule(Rule):
         except re.error as e:
             error(f'Invalid symbol regex {regex}: {e}', os.EX_DATAERR)
 
+        super()._ensure_required_fields(rule, f'pattern {regex}')
         super().__init__(rule)
 
 @dataclass
@@ -333,6 +378,36 @@ class Issue:
     severity: Severity
     rationale: Optional[str]
 
+class OverlayFile:
+    """YAML overlay file access"""
+
+    overlays: YamlDict
+
+    def __init__(self, overlay_f: Path, schema: Schema):
+        self.overlays = Helpers.load_yaml(overlay_f)
+        Helpers.validate_yaml(self.overlays, schema.validator, overlay_f.name)
+
+    def apply(self, rules: Rules) -> Rules:
+        if 'docs_url' in self.overlays:
+            rules.docs_url = self.overlays['docs_url']
+
+        for overlay in self.overlays.get('rules', []):
+            if 'name' in overlay:
+                if rule := rules.get_symbol_rule(overlay['name']):
+                    rule.overlay(overlay)
+                else:
+                    rules.add_rule(SymbolRule(overlay))
+                continue
+
+            if 'name_pattern' in overlay:
+                if prule := rules.get_pattern_rule(overlay['name_pattern']):
+                    prule.overlay(overlay)
+                else:
+                    rules.add_rule(PatternRule(overlay))
+                continue
+
+        return rules
+
 @dataclass
 class SymbolIssue(Issue):
     """Checker issue concerning a single .config symbol"""
@@ -563,6 +638,14 @@ def parse_args(rules: list[str]) -> argparse.Namespace:
         help='rules file to check against',
     )
 
+    check_parser.add_argument(
+        '-o',
+        '--overlay',
+        metavar='OVERLAY_FILE',
+        type=Path,
+        help='file overlay over picked rules',
+    )
+
     return parser.parse_args()
 
 def main() -> None:
@@ -586,6 +669,10 @@ def main() -> None:
     rules_f = rules_dir / f'{args.rules}.yml'
     rules = RulesFile(rules_f, schema).parse()
 
+    if args.overlay:
+        schema = Schema(schema_dir / 'overlay.yml')
+        rules = OverlayFile(args.overlay, schema).apply(rules)
+
     checker = Checker(kconfig, rules)
     report = checker.find_issues()
 
-- 
2.56.0

