Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793956803;
	b=2PUIFY876iAb6PsTsfsNhpoxMeds4KQj2MsZsAkP9ZQOIvb1QG4inffKW/GUY/crfkx4
	 Bav6ODBr0ssgOl/MZJ9ButaFmAJ6sXIyKNoP5cyj3MU6wKktTY0qT5hSnj5qD9sTLgRE8
	 a11bOEgdfJMCOw20WNWUKK2vjjg+hcTzOapOX8lB0xJdto1NtbyU6UB2t9GiXWATVf2RX
	 s+GdIyVTdaoL7uPN9vwuqPFqAb6Kc1DsjjdXMMgTiZB1J5Nfii2IS6VupJUp5cKZUCOWN
	 sPgDQZ4UbPdSvwFDxaBuoX5FP4I4C23dJrLSVl+DXWLdqO5b7FoE/TEO26Asj3xaxAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793956803;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VVQM4vpmIqtUkXlQycTZmxQFVlzTE7nC1mJ7AMYBMDo=;
	b=hO57/0NIUTWT8zP1iRmCzVfiE/vCEmTdyFCAwKxlHwWEflIWlTu2MAWELRelXde0/z/a
	 v+0tZ2v5AvhYFeTwLvSWPSBxTEletKwuMHHzLW4zPxEBGk6wG/Pcxpr5PIy9tnvCwnKWD
	 6UBAhuoTyvAV74wLr6bhfwe24r9hzsh8g+rUcfUPAclDtGmV2A/7qGwz6FT+liJoFSdDg
	 5gw7QUozsMErkOFtguG1h5Awt07ZKS0lQEDRicmVWLiiilNpT+tiyExOFxiEyMe+2jd2A
	 1JmlSxYn+b2WunHX0bc3vHNCYtMCE4R6dyRCbtMclF/vTbbs8P3jM4GwqZ5deDHUGaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=jA7uuWou;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=rHEfF4HE;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C19606A339
	for <linux-rt-devel@lists.linux.dev>; Fri,  6 Nov 2026 09:19:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49C19606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=jA7uuWou;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=rHEfF4HE
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793956796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VVQM4vpmIqtUkXlQycTZmxQFVlzTE7nC1mJ7AMYBMDo=;
	b=jA7uuWouOwWkZQ+uSsTvE7Y3WvtOhduBDYoFkQlzPW0Zsc25QoSb9hZvbiH6aUxPF6f+x1
	UE6ded12dAx3O5CmFBfjgODvb+tKFAlR0QuqTSmUbP32/tTdIjmK471dUzESfsDi7b//bZ
	HsBBEz9MpC9KupDb4rimU0dLC27cKoNDdiSnaUXxLMWAcbv+bXY4tp5Y317AIXv+HztLwu
	A7odMBP/D5pAzO6mgsFsDw3Gicq/GFFf8p0pOg84tDwXBMVt/1fBVhK5yvJhseJzc8TZFj
	SxL+bkH5OocsSw+/sYo+f+4jNUQ4kvuysOe69Z9m2A9W/VdmXkXHl8JZO+IO/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793956796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VVQM4vpmIqtUkXlQycTZmxQFVlzTE7nC1mJ7AMYBMDo=;
	b=rHEfF4HE/F/0vu2k1eqKQLg/3NzVGNRH0axzRz2vfFflb5RmrC8lYlc9V6B0L/scQlWpjD
	ECUgvlJJ9O4lP0Aw==
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
Subject: [PATCH v1 07/10] kconfig-checker: Introduce overlays schema
Date: Fri,  6 Nov 2026 10:19:19 +0100
Message-ID: <20261106091922.7560-8-darwi@linutronix.de>
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

Keep `expected` and `severity` as optional for every rule.

This allows overlay files to be partial by design: they may override only
selected fields of an existing rule.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 tools/kconfig-checker/schemas/base.yml    |  4 ++--
 tools/kconfig-checker/schemas/overlay.yml | 28 +++++++++++++++++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)
 create mode 100644 tools/kconfig-checker/schemas/overlay.yml

diff --git a/tools/kconfig-checker/schemas/base.yml b/tools/kconfig-checker/schemas/base.yml
index 1cc19752ebd6..6217eaba3e41 100644
--- a/tools/kconfig-checker/schemas/base.yml
+++ b/tools/kconfig-checker/schemas/base.yml
@@ -53,8 +53,8 @@ properties:
         #   y        option is expected to be enabled (built-in or module).
         #   n        option is expected to be disabled or unset.
         #   allowed  option is permitted and must not be reported as a violation.
-        #            This is used to exempt a specific symbol from a broader
-        #            `name_pattern` rule  with `expected: n`.
+        #            This is to be used either by overlays, or to exempt a specific
+        #            symbol from a broader `name_pattern` rule  with `expected: n`.
         #
         expected:
           type: string
diff --git a/tools/kconfig-checker/schemas/overlay.yml b/tools/kconfig-checker/schemas/overlay.yml
new file mode 100644
index 000000000000..4ac9a364a344
--- /dev/null
+++ b/tools/kconfig-checker/schemas/overlay.yml
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+"$schema": "https://json-schema.org/draft-07/schema#"
+
+title: Schema for kconfig-checker overlay files
+
+#
+# Full rule files require 'expected' and 'severity' for every rule.
+# Overlay files are partial by design: they may override only selected
+# fields of an existing rule, so such fields are not required here.
+#
+# For example, preempt_rt.yml:
+#
+# rules:
+#  - name: CONFIG_DRM
+#    expected: n
+#    severity: info
+#    docs_hint: config
+#
+# and a custom-overlay.yml:
+#
+# rules:
+#  - name: CONFIG_DRM
+#    expected: allow
+#
+
+allOf:
+  - $ref: "base.yml"
-- 
2.56.0

