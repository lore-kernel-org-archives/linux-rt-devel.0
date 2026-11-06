Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793956780;
	b=okjcz2tAZsUyz0i1/HihApKQsW9hDmDrwyzxc+IfwTet/wksguALHqCW8gbhB0xGNQp0
	 g8kMYHWzY91aRRra4l76PjUE192tPYDI6zcYhdof/jOdnMximAe248JOEBxxUFiOm3fvt
	 O46HEfK1uCMJKOzFB983MAPW+J8xq4vdZX4PFuXylEU0VsFrxXdZlMfGHofjbLmgOBh6R
	 yN/dJOpIw9eQdqPgmD3gyYNhBzjDyw+1nJB3i0qEOprRv1xK3SNEK1QHVY9U5X6spCT+9
	 pv26Jam3XbYVOEqL/N6tx56QboEDyV/Ed0irvFOkIXD7LjXmobU2V8dkXUVNZXd8i9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956780;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aoDieoIq5VMR4BGBHsSjoa5JYOQH+kmuD64+dqaaiwc=;
	b=rg0dMRqWV6QC/u7pRcXBSmgATxc/u/IdoC5aeJ1IQ/4eZzVXbJrwlBatsTgzTfgnOUT1
	 opJKZ+M0TzfO9+Xxy12oNM3zT7/r+motX6TPK5qwQGo8cB/F6UJ2g1FinEJmi1ODb6yOd
	 CIIHADSOhne+j/2CN6kyhdBCXbNrWj1+KuEHpStirFGGEOxiefi7/wihN31m0PHbPWhZO
	 EJMVPXtXcLaU2IEkpkZHuf+WadD4TSHfEc9VrS8cUtCBo3Mi5T/lJHHRpF84kfSDzG973
	 9eL7Gz8Um0HY1ZAIDJhq5MuJK70YrozLEjQIPkk0jhIuM3z4yBgbguUAXufr4TGficQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=rFMk6Lov;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="FVMPU6l/";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E3E606A32E
	for <linux-rt-devel@lists.linux.dev>; Fri,  6 Nov 2026 09:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48E3E606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=rFMk6Lov;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=FVMPU6l/
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793956777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aoDieoIq5VMR4BGBHsSjoa5JYOQH+kmuD64+dqaaiwc=;
	b=rFMk6LoviYvEcUMrQniZlbUQCnxazvIFXUDWJE86oEUBlyLyIhKG6Vrb+C22yrlT1l6Gfl
	niy4uI3MUjKdj7X4Izvim2T0Z83/rDkjNBYMbt35Iijpo1FYG22aNPfrZL5ZJfeUfYloTU
	e0qq+Ltdptr6dv4pp9Z/LyN1G/qxYPx8XXr0Hvek14jLf158bKOCBWD8SrsTm3CXgxsvKW
	tS7JdnAP0V9U9u5yRpsTmZAUCfVU2tRGlMRHoWmuHBYxtdFwn1J22MEEakp7jg3Uc7fVkX
	hvnThA71HCOv5+sfyLsLxmO1E0hppQLBlRJkuC71DQON2dFTOVtFOZmpvB0rBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793956777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aoDieoIq5VMR4BGBHsSjoa5JYOQH+kmuD64+dqaaiwc=;
	b=FVMPU6l/VvIZiRo8uL8GqpxoyAOZly8s+iYHzxVw9ors6FlbTymylSOcvvLMWEei1O6X6p
	ZvWvGBjKmHOMyRAQ==
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
Subject: [PATCH v1 01/10] kconfig-checker: Add schema for rule files
Date: Fri,  6 Nov 2026 10:19:13 +0100
Message-ID: <20261106091922.7560-2-darwi@linutronix.de>
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

The kconfig-checker YAML rule files describes which kernel .config symbols
are expected to be enabled or disabled. Introduce a schema for such files.

Describe and add rational for each element in the schema as well.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/kconfig-checker/schema.yml | 115 +++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100644 tools/kconfig-checker/schema.yml

diff --git a/tools/kconfig-checker/schema.yml b/tools/kconfig-checker/schema.yml
new file mode 100644
index 000000000000..a7f1b0a78cc7
--- /dev/null
+++ b/tools/kconfig-checker/schema.yml
@@ -0,0 +1,115 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+"$schema": "https://json-schema.org/draft-07/schema"
+
+title: Schema for kconfig-checker rule files
+type: object
+required: [rules]
+additionalProperties: false
+
+properties:
+  #
+  # Optional base URL for the documentation page used by rationale
+  # links.  See `docs_hint`.
+  #
+  docs_url:
+    type: string
+    format: uri
+
+  rules:
+    type: array
+    minItems: 1
+    items:
+      type: object
+      oneOf:
+        - required: [name]
+        - required: [name_pattern]
+      required: [expected, severity]
+      additionalProperties: false
+
+      properties:
+        #
+        # Exact kernel configuration symbol to check.
+        #
+        # Example: CONFIG_PREEMPT_RT
+        #
+        name:
+          type: string
+          pattern: '^CONFIG_[A-Z0-9_]+$'
+
+        #
+        # Regex matching one or more kernel configuration symbols.
+        #
+        # Example: CONFIG_DEBUG_.*
+        #
+        name_pattern:
+          type: string
+          format: regex
+
+        #
+        # Expected value for the matching kernel configuration option.
+        #
+        # Values:
+        #
+        #   y        option is expected to be enabled (built-in or module).
+        #   n        option is expected to be disabled or unset.
+        #   allowed  option is permitted and must not be reported as a violation.
+        #            This is used to exempt a specific symbol from a broader
+        #            `name_pattern` rule  with `expected: n`.
+        #
+        expected:
+          type: string
+          enum: [y, n, allowed]
+
+        #
+        # Issue severity to report when the configuration rule is not met.
+        #
+        # Higher severities should be reserved for rules affecting correctness.
+        #
+        severity:
+          type: string
+          enum: [fatal, high, medium, low, info]
+
+        #
+        # Optional documentation anchor for this rule.
+        #
+        # The rationale URL is built from `docs_url` plus an HTML fragment
+        # identifier.
+        #
+        # If `docs_hint` is set to `config`, then the HTML fragment id is
+        # derived from the kernel configuration symbol name:
+        #
+        #   CONFIG_DRM  ->  #config-drm
+        #
+        # For example, with below docs_url:
+        #
+        #   https://docs.kernel.org/core-api/real-time/kernel-configuration.html
+        #
+        # and the symbol entry:
+        #
+        #   - name: CONFIG_DRM
+        #     expected: n
+        #     severity: info
+        #     docs_hint: config
+        #
+        # the rationale URL becomes:
+        #
+        #   https://docs.kernel.org/core-api/real-time/kernel-configuration.html#config-drm
+        #
+        # If `docs_hint` is any other string, that string is used directly as
+        # the HTML fragment identifier.
+        #
+        docs_hint:
+          type: string
+          anyOf:
+            - const: config
+            - pattern: '^\S+$'   # URI fragments cannot have spaces
+
+        #
+        # Optional human-readable explanation for the rule.
+        #
+        # This text should explain why the option is expected to have the given
+        # value, and may span multiple lines.
+        #
+        rationale:
+          type: string
-- 
2.56.0

