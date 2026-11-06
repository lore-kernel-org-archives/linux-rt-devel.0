Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793956795;
	b=lA7Btc8+lX8ZmlA6C4mkf74VdkJ7yt38QWdVIYZ5vzgnabRRXgFnlX5jk2OfRyNk0Fd+
	 eaxgV5GuI0ll4QiHy7xoZvHw/FmPSxv0qQVS1fXNZk4WWKhMTn//zq2w3VrTubn6uvwGS
	 hkdAoaWVTK6nKHMQVaEX7euwfoEE507Ix8IAUQcLPbxpYaMj8PiAdK9JgAyeyWzkiJqXN
	 Qy1uOXV8skF7GGqKHlzEoq6lJOJw8IKaagHEfhL4vErYXKdVaHYbRMp2h/8zYY2yOR5LW
	 5XKbuOd2iEkSG/d0NEF1kh7xOXEyfJxFd+QreRRpQ3vJ6SMwMkIJYsneI7fj5qt77jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956795;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DK760ykl3d7OwCZiv0D+NLM0YSnbIU45SeYtc9P6QCo=;
	b=kTnik/w0GnFW/bER7mtDdbSulGo9rY/3nPkR/2Bj4T1Nnn52ei8AXHByI62tUQAZQ3OJ
	 EXNcBP1x1XRQRNXJwEVI+YZt4orkM01MXilZYcgmZ5fh4SJVVbb4VQahkOmfzMTA0gJAL
	 LClzHDdVZZwPtv0pibk0xNV7IRJZhx7LxQe84e9mhn7Wa81woNaCOtX+RvkYsh0RSrung
	 b1OaIFd6o/rxcIMRW5ew8HIIfRME4WT8m+CF4GjYaNuHStpfaiQzOK7COipoAJ2R5In54
	 q9d3fEgp3Fqm2Oc6r7kLB/KWzYZFcCEs407Xqty+9JHuD+WPPbWUVLbqAQpYWZsWXKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Iz4hDwFm;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=j2ICYQKe;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09743606D817
	for <linux-rt-devel@lists.linux.dev>; Fri,  6 Nov 2026 09:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09743606D817
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Iz4hDwFm;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=j2ICYQKe
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793956793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DK760ykl3d7OwCZiv0D+NLM0YSnbIU45SeYtc9P6QCo=;
	b=Iz4hDwFm8fVgSNCVVVnDO10yUt9E3NHYLh5TuOGBY1mZ4kIMOAE23C/hYFKzdXEUKZd5V/
	RrgdNC6nUM2JGT3AouI5SLWlYPcqJkVw0DIrLra+iDUdkx0G9Qyzi9VCqo9jf1fR6lDi71
	cM1l8ddDtpiVZ/tLVGA91jkQ/fuPPi5LBThj1MCN157OQb95FL7u1DkXUsa+dTE1VrxVNZ
	gVnChGY0ys+2MvJAIIJgrqpa/YFOqGXlsYKZ88Ys6eSewE1zITxnD7skgieHe+KiHzE0i+
	YbBEMev23O7JjV9fRjzwB6sk9B1Vqr192T63GNjqdVweHnPujB0oc1zvHPSOXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793956793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DK760ykl3d7OwCZiv0D+NLM0YSnbIU45SeYtc9P6QCo=;
	b=j2ICYQKe2moEMithThiqawOcijQQn/Q0SNJ1AT2W5DZ+5jW4j7BsNw4M0BWdQEUdxPmpSW
	riXW/AmtygFHREBA==
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
Subject: [PATCH v1 06/10] kconfig-checker: Split schema to support component reuse
Date: Fri,  6 Nov 2026 10:19:18 +0100
Message-ID: <20261106091922.7560-7-darwi@linutronix.de>
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

Normal rule files require every rule to define both 'expected' and
'severity'.  Overlay files are different: an overlay may update only
selected fields of an existing rule, so a future overlay schema will permit
these fields to be omitted.

Move the common rule definitions into schemas/base.yml and add a strict
schemas/rules.yml wrapper for complete rule files.

Teach the checker to build a Draft7Validator with local file:// URIs so
that rules.yml can resolve base.yml.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/kconfig-checker/check.py                | 52 ++++++++++++++++---
 .../{schema.yml => schemas/base.yml}          |  3 +-
 tools/kconfig-checker/schemas/rules.yml       | 20 +++++++
 3 files changed, 65 insertions(+), 10 deletions(-)
 rename tools/kconfig-checker/{schema.yml => schemas/base.yml} (97%)
 create mode 100644 tools/kconfig-checker/schemas/rules.yml

diff --git a/tools/kconfig-checker/check.py b/tools/kconfig-checker/check.py
index ef49c28b9dab..4f79ec487da7 100755
--- a/tools/kconfig-checker/check.py
+++ b/tools/kconfig-checker/check.py
@@ -80,6 +80,8 @@ except ModuleNotFoundError as e:
 # Actual script:
 #
 
+from jsonschema import Draft7Validator
+
 class KernelConfig:
     """.config file parser"""
 
@@ -133,9 +135,9 @@ class Helpers:
             error(f'Invalid YAML syntax at {yaml_f}:\n {e}', os.EX_DATAERR)
 
     @staticmethod
-    def validate_yaml(yaml: YamlDict, schema: YamlDict, f_name: str) -> None:
+    def validate_yaml(yaml: YamlDict, validator: Draft7Validator, f_name: str) -> None:
         try:
-            jsonschema.validate(yaml, schema)
+            validator.validate(yaml)
         except jsonschema.exceptions.ValidationError as e:
             error(
                 f'{f_name} does not match its schema\n'
@@ -144,12 +146,45 @@ class Helpers:
             )
 
 class Schema:
-    """Rules file schema, in json-schema.org format"""
+    """Rules file schema, in json-schema.org draft-07 format"""
+
+    # Rules schema refer to definitions from this base schema
+    BASE_SCHEMA = 'base.yml'
 
     def __init__(self, schema_f: Path):
-        self.schema = Helpers.load_yaml(schema_f)
-        # Validate the schema itself against draft-07 metaschema
-        jsonschema.Draft7Validator.check_schema(self.schema)
+        base_schema_f = schema_f.parent / self.BASE_SCHEMA
+
+        # Use file:// URIs so jsonschema can resolve local '$ref' entries
+        base_schema_uri = base_schema_f.resolve().as_uri()
+        schema_uri = schema_f.resolve().as_uri()
+
+        base_schema = self._load(base_schema_f)
+        self.schema = self._load(schema_f)
+
+        self.validator = self._create_validator(
+            base_schema_uri, base_schema,
+            schema_uri, self.schema,
+        )
+
+    @staticmethod
+    def _create_validator(base_schema_uri: str, base_schema: YamlDict,
+                          schema_uri: str, schema: YamlDict) -> Draft7Validator:
+        """Create a schema validator which can resolve local '$ref' URIs"""
+        resolver = jsonschema.RefResolver(
+            base_uri=schema_uri,
+            referrer=schema,
+            store={ base_schema_uri: base_schema },
+        )
+
+        return Draft7Validator(schema, resolver=resolver)
+
+    @staticmethod
+    def _load(path: Path) -> YamlDict:
+        """Load and validate the schema itself against its metaschema"""
+        schema = Helpers.load_yaml(path)
+
+        Draft7Validator.check_schema(schema)
+        return schema
 
     def as_dict(self) -> YamlDict:
         return self.schema
@@ -273,7 +308,7 @@ class RulesFile:
 
     def __init__(self, yaml_f: Path, schema: Schema):
         self.yaml = Helpers.load_yaml(yaml_f)
-        Helpers.validate_yaml(self.yaml, schema.as_dict(), yaml_f.name)
+        Helpers.validate_yaml(self.yaml, schema.validator, yaml_f.name)
 
     def parse(self) -> Rules:
         """Parse the YAML rules into a python Rules object"""
@@ -533,6 +568,7 @@ def parse_args(rules: list[str]) -> argparse.Namespace:
 def main() -> None:
     base_dir = Path(__file__).resolve().parent
     rules_dir = base_dir / 'rules'
+    schema_dir = base_dir / 'schemas'
 
     rules_l = sorted(path.stem for path in rules_dir.glob('*.yml'))
     args = parse_args(rules_l)
@@ -544,7 +580,7 @@ def main() -> None:
     kconfig_f = args.config.resolve()
     kconfig = KernelConfig(kconfig_f)
 
-    schema_f = base_dir / 'schema.yml'
+    schema_f = schema_dir / 'rules.yml'
     schema = Schema(schema_f)
 
     rules_f = rules_dir / f'{args.rules}.yml'
diff --git a/tools/kconfig-checker/schema.yml b/tools/kconfig-checker/schemas/base.yml
similarity index 97%
rename from tools/kconfig-checker/schema.yml
rename to tools/kconfig-checker/schemas/base.yml
index a7f1b0a78cc7..1cc19752ebd6 100644
--- a/tools/kconfig-checker/schema.yml
+++ b/tools/kconfig-checker/schemas/base.yml
@@ -2,7 +2,7 @@
 
 "$schema": "https://json-schema.org/draft-07/schema"
 
-title: Schema for kconfig-checker rule files
+title: Base schema for kconfig-checker rule files
 type: object
 required: [rules]
 additionalProperties: false
@@ -24,7 +24,6 @@ properties:
       oneOf:
         - required: [name]
         - required: [name_pattern]
-      required: [expected, severity]
       additionalProperties: false
 
       properties:
diff --git a/tools/kconfig-checker/schemas/rules.yml b/tools/kconfig-checker/schemas/rules.yml
new file mode 100644
index 000000000000..90f0eeef497f
--- /dev/null
+++ b/tools/kconfig-checker/schemas/rules.yml
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+"$schema": "https://json-schema.org/draft-07/schema#"
+
+title: Schema for kconfig-checker rule files
+
+allOf:
+  - $ref: "base.yml"
+
+  #
+  # The base schema leaves 'expected' and 'severity' optional so that
+  # overlay files can override only selected fields.  In a full rules
+  # file though, these fields are mandatory for each rule.
+  #
+  - type: object
+    properties:
+      rules:
+        type: array
+        items:
+          required: [expected, severity]
-- 
2.56.0

